with trips_clean AS
  ( SELECT route_id,
           trip_id,
          --- adding more readibility to the access code based on STM website
           CASE
               WHEN wheelchair_accessible = 0 then 'no wheelchair accessible information'
               WHEN wheelchair_accessible = 1 then 'wheelchair accessible'
               WHEN wheelchair_accessible = 2 then 'no wheelchair accessible'
           END AS wheelchair_accessible
   FROM trips)
 ---adding extra column to be able to create chart  
SELECT '' AS trip,
       count(trip_id) AS total_trips,
       count(CASE
                 WHEN wheelchair_accessible = 'wheelchair accessible' then 1
                 ELSE null
             END) AS total_boardable_trips
FROM trips_clean
