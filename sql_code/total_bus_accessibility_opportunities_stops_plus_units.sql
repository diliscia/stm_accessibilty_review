with wheelchair_accessible_info_per_trip AS
  (SELECT route_id,
          trip_id,
          wheelchair_accessible
   FROM diliscia.trips --grain one row per trip
--   where route_id = 97
 ),
     routes_enriched_wheelchair_accessible AS
  (SELECT route_short_name,
          route_long_name,
          wheelchair_accessible,
          rou.route_id,
          trip_id,
          route_type
   FROM wheelchair_accessible_info_per_trip wai
   left join diliscia.routes rou
     ON rou.route_id = wai.route_id),
     getting_stop_information AS
    (SELECT stop.stop_id,
            trip_id,
            stop_name,
            stop_sequence,
            wheelchair_boarding
   FROM diliscia.stops stop
   JOIN diliscia.stop_times tim
     ON tim.stop_id = stop.stop_code --   where stop_code in (54010, 60658)
 ),
     adding_bus_stops AS
    (SELECT rou.route_id,
            rou.trip_id,
            route_short_name,
            route_long_name,
            wheelchair_accessible,
            stop_id,
            stop_name,
            wheelchair_boarding
   FROM routes_enriched_wheelchair_accessible rou
   JOIN getting_stop_information stop
     ON rou.trip_id = stop.trip_id
     WHERE route_type = '3' ),
     compute_total_stops_and_trips_per_route AS
    (SELECT route_id,
            count(*),
            count (distinct route_id) AS total_routes,
                  count (distinct stop_id) AS total_stops,
                        count (distinct trip_id) AS total_trips
   FROM adding_bus_stops
   GROUP BY route_id),
     compute_total_access_user_opportunities AS
  (SELECT total_stops,
          total_trips,
          total_stops * total_trips AS total_access_user_opportunities,
          route_id
   FROM compute_total_stops_and_trips_per_route),
     compute_full_boarding_accesibility AS
  (SELECT route_id,
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
          END AS full_boarding_accesibility
   FROM adding_bus_stops),
     summary_of_accecibility_per_route AS
  (SELECT route_id,
          route_short_name,
          route_long_name,
          count(CASE
                    WHEN full_boarding_accesibility = 'fully_innacesible' then 1
                    ELSE null
                END) AS fully_innacesible,
          count(CASE
                    WHEN full_boarding_accesibility = 'bad_vehicle' then 1
                    ELSE null
                END) AS bad_vehicle,
          count(CASE
                    WHEN full_boarding_accesibility = 'bad_stop' then 1
                    ELSE null
                END) AS bad_stop,
          count(CASE
                    WHEN full_boarding_accesibility = 'fully_accesible' then 1
                    ELSE null
                END) AS fully_accesible
   FROM compute_full_boarding_accesibility
   GROUP BY route_id,
            route_short_name,
            route_long_name),
     total_opportunities_granular AS
  (SELECT route_short_name,
          route_long_name,
          total_stops,
          total_trips,
          fully_innacesible,
          bad_vehicle,
          bad_stop,
          fully_accesible,
          total_access_user_opportunities, ---is overcounting somehow
fully_innacesible+bad_vehicle+bad_stop+fully_accesible AS validation, --- real total
(fully_innacesible+bad_vehicle+bad_stop+fully_accesible)- total_access_user_opportunities AS double_validation --- is giving error since is not the same name
FROM summary_of_accecibility_per_route cfb
   left join compute_total_access_user_opportunities ctao
     ON cfb.route_id = ctao.route_id
   ORDER BY route_short_name ASC)
SELECT '' AS total_buses,
       sum(fully_innacesible) AS fully_innacesible,
       sum (bad_vehicle) AS bad_vehicle,
           sum (bad_stop) AS bad_stop,
               sum(fully_accesible) AS fully_accesible
FROM total_opportunities_granular
