with wheelchair_accessible_info_per_trip AS
  (
    SELECT 
          route_id,
          trip_id,
          wheelchair_accessible
   FROM 
          diliscia.trips 
          where route_id = 66
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
   LEFT JOIN  diliscia.routes rou
   ON rou.route_id = wai.route_id
 ),
getting_stop_information AS
 (
   SELECT 
          stop.stop_id,
          tim.trip_id,
          stop.stop_name,
          tim.stop_sequence,
          stop.wheelchair_boarding
   FROM 
          diliscia.stops stop
   JOIN 
          diliscia.stop_times tim
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
)
,
compute_full_boarding_accesibility AS
(
   SELECT 
          route_id,
          route_short_name,
          route_long_name,
          stop_id,
          stop_name,

          count(case when wheelchair_accessible = 1 then 1 end ) as accesible_vehicule, 
          count(case when wheelchair_accessible = 2 then 1 end ) as innaccesible_vehicule, 
          count(case when wheelchair_boarding = 1 then 1 end ) as accesible_stop, 
          count(case when wheelchair_boarding = 2 then 1 end ) as innaccesible_stop
   FROM   
          adding_bus_stops
   GROUP BY 
          route_id,
          route_short_name,
          route_long_name,
          stop_id,
          stop_name

 )
-- , 
-- innacessible_vehicule_percentage_per_stop as 
-- (
   SELECT  *, 
         case when ROUND(innaccesible_vehicule *100.00)/ ROUND(NULLIF((accesible_vehicule + innaccesible_vehicule) ,0 ), 1) is null 
             then '100' 
             else ROUND(innaccesible_vehicule *100.00)/ ROUND(NULLIF((accesible_vehicule + innaccesible_vehicule),0 ), 1) end 
             as innacessible_vehicule_percentage,
         case when ROUND(innaccesible_stop *100.00)/ ROUND(NULLIF((accesible_stop + innaccesible_stop),0 ), 1) is null 
             then '100' 
             else ROUND(innaccesible_stop *100.00)/ ROUND(NULLIF((accesible_stop + innaccesible_stop),0 ), 1) end 
             as innacesible_stop_percentage
FROM compute_full_boarding_accesibility


)
SELECT route_short_name,
          route_long_name,
AVG(innacessible_vehicule_percentage) as average_innaccesible_vehicles,
  AVG(innacesible_stop_percentage) as average_innaccesible_stops
from innacessible_vehicule_percentage_per_stop
group by  route_short_name,
          route_long_name
