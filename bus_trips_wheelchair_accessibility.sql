with trips_clean AS
  ( SELECT route_id,
           trip_id,
           CASE
               WHEN wheelchair_accessible = 0 then 'no wheelchair accessible information'
               WHEN wheelchair_accessible = 1 then 'wheelchair accessible'
               WHEN wheelchair_accessible = 2 then 'no wheelchair accessible'
           END AS wheelchair_accessible
   FROM diliscia.trips)
SELECT '' AS trip,
       count(trip_id) AS total_trips,
       count(CASE
                 WHEN wheelchair_accessible = 'wheelchair accessible' then 1
                 ELSE null
             END) AS total_boardable_trips
FROM trips_clean
