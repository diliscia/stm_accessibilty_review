with wheelchair_accessible_info_per_trip AS
  (
    SELECT 
          route_id,
          trip_id,
          wheelchair_accessible
   FROM 
          trips --grain one row per trip
 ),
routes_enriched_wheelchair_accessible AS
 (
   SELECT 
          route_short_name,
          route_long_name,
          wheelchair_accessible,
          rou.route_id,
          trip_id,
          route_type
   FROM 
          wheelchair_accessible_info_per_trip wai
   LEFT JOIN  routes rou
   ON rou.route_id = wai.route_id
 ),
getting_stop_information AS
 (
   SELECT 
          stop.stop_id,
          tim.trip_id,
          stop.stop_name,
          stop.stop_sequence,
          stop.wheelchair_boarding
   FROM 
          stops stop
   JOIN 
          stop_times tim
   ON 
          tim.stop_id = stop.stop_code 
 ),
adding_bus_stops AS
 (
   SELECT 
        rou.route_id,
        rou.trip_id,
        rou.route_short_name,
        rou.route_long_name,
        rou.wheelchair_accessible,
        gsi.stop_id,
        gsi.stop_name,
        gsi.wheelchair_boarding
   FROM 
        routes_enriched_wheelchair_accessible rou
   JOIN 
        getting_stop_information gsi
   ON 
        rou.trip_id = gsi.trip_id
   WHERE 
        route_type = '3' 
 ),
compute_total_stops_and_trips_per_route AS
 (
   SELECT 
         route_id,
         count(*),
         count (distinct route_id) AS total_routes,
         count (distinct stop_id) AS total_stops,
         count (distinct trip_id) AS total_trips
   FROM 
         adding_bus_stops
   GROUP BY 
         route_id
 ),
compute_total_access_user_opportunities AS
 (
    
   SELECT 
         total_stops,
         total_trips,
         total_stops * total_trips AS total_access_user_opportunities,
         route_id
   FROM 
         compute_total_stops_and_trips_per_route
 ),
compute_full_boarding_accesibility AS
 (
   SELECT 
          route_id,
          route_short_name,
          route_long_name,
          wheelchair_accessible,
          stop_id,
          stop_name,
          wheelchair_boarding,
          CASE
              WHEN wheelchair_accessible = 2
                   AND wheelchair_boarding = 2 then 'fully_innacesible'
              WHEN wheelchair_accessible = 2
                   AND wheelchair_boarding = 1 then 'bad_vehicle'
              WHEN wheelchair_accessible = 1
                   AND wheelchair_boarding = 2 then 'bad_stop'
              WHEN wheelchair_accessible = 1
                   AND wheelchair_boarding = 1 then 'fully_accesible'
              END AS 
          full_boarding_accesibility
   FROM   
          adding_bus_stops
 ),
summary_of_accecibility_per_route AS
 (
   SELECT 
          route_id,
          route_short_name,
          route_long_name,
                   count (CASE
                    WHEN full_boarding_accesibility = 'fully_innacesible' then 1
                    ELSE null
                    END) AS 
          fully_innacesible,
                    count(CASE
                    WHEN full_boarding_accesibility = 'bad_vehicle' then 1
                    ELSE null
                    END) AS 
          bad_vehicle,
                    count(CASE
                    WHEN full_boarding_accesibility = 'bad_stop' then 1
                    ELSE null
                    END) AS 
          bad_stop,
                    count(CASE
                    WHEN full_boarding_accesibility = 'fully_accesible' then 1
                    ELSE null
                    END) AS 
          fully_accesible
   FROM 
          compute_full_boarding_accesibility
   GROUP BY 
          route_id,
          route_short_name,
          route_long_name
 ),
total_opportunities_granular AS
 (
   SELECT 
          cfb.route_short_name,
          cfb.route_long_name,
          cfb.total_stops,
          cfb.total_trips,
          ctao.fully_innacesible,
          ctao.bad_vehicle,
          ctao.bad_stop,
          ctao.fully_accesible,
          ctao.total_access_user_opportunities, ---is overcounting somehow
          ctao.fully_innacesible+bad_vehicle+bad_stop+fully_accesible AS validation, --- real total
               (ctao.fully_innacesible + ctao.bad_vehicle + ctao.bad_stop + ctao.fully_accesible) - ctao.total_access_user_opportunities AS 
          double_validation --- is giving error since is not the same name
   FROM 
          summary_of_accecibility_per_route cfb
   LEFT JOIN 
          compute_total_access_user_opportunities ctao
   ON 
          cfb.route_id = ctao.route_id
   ORDER BY 
          route_short_name ASC
 )

   SELECT 
          sum(fully_innacesible) AS fully_innacesible,
          sum (bad_vehicle) AS bad_vehicle,
          sum (bad_stop) AS bad_stop,
          sum(fully_accesible) AS fully_accesible
   FROM
          total_opportunities_granular
