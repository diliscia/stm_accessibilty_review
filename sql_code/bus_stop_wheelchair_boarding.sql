 with stops_clean as 
 (
 SELECT stop_name,
 split_part (stop_name, ' -', 1) as metro_station_name,
    stop_code,
    stop_id,
            stop_lat,
            stop_lon,
            location_type,
            parent_station,
                      CASE
              WHEN wheelchair_boarding = 0 then 'no wheelchair boarding information'
              WHEN wheelchair_boarding = 1 then 'wheelchair boarding'
              WHEN wheelchair_boarding = 2 then 'no wheelchair boarding'
          END AS wheelchair_boarding
  FROM diliscia.stops
  WHERE 
  stop_name != upper(stop_name) 
  and  stop_code > 20000
)

select  
'' as bus,
count(stop_id) as total_stops, 
count( case when wheelchair_boarding = 'wheelchair boarding' then 1  else null end) as total_boardable_stops
from stops_clean
