with stops_clean AS
 (
  SELECT 
           stop_name,
              split_part (stop_name, ' -', 1) AS 
           metro_station_name,
           stop_code,
           stop_id,
           parent_station,
              CASE
               WHEN wheelchair_boarding = 0 then 'no wheelchair boarding information'
               WHEN wheelchair_boarding = 1 then 'wheelchair boarding'
               WHEN wheelchair_boarding = 2 then 'no wheelchair boarding'
               END AS 
           wheelchair_boarding
   FROM 
           stops
   WHERE 
           stop_name != upper(stop_name) -- to remove duplications
   AND     stop_code <= 20000 ---to remove buses
 ),
managing_execpetion AS --- some names are malformed or duplicated
 (
   SELECT 
           stop_name,
           stop_code,
           stop_id,
           parent_station,
           wheelchair_boarding
              CASE
              WHEN metro_station_name ilike '%Station Square-Victoria%' then 'Station Square-Victoria'
              WHEN metro_station_name ilike '%Station Snowdon%' then 'Station Snowdon'
              WHEN metro_station_name ilike '%Station Longueuil%' then 'Station Longueuil'
              WHEN metro_station_name ilike '%Station Jean-Talon%' then 'Station Jean-Talon'
              WHEN metro_station_name ilike '%Station Fabre%' then 'Station Fabre'
              WHEN metro_station_name ilike '%Catherine%' then 'Station Côte-Sainte-Catherine'
              WHEN metro_station_name ilike '%Station Berri-UQAM%' then 'Station Berri-UQAM'
              ELSE metro_station_name
              END AS 
          metro_station_name_clean
   FROM 
          stops_clean 
 ), 
total_entrances AS -- count the total entrances and the total accesible ones
 (
   SELECT 
              COUNT(stop_id) AS 
          total_entrances,
              COUNT(CASE
                    WHEN wheelchair_boarding = 'wheelchair boarding' then 1
                    ELSE null
                    END) AS 
          total_accesible_entrances,
          metro_station_name_clean
   FROM 
          managing_execpetion
   GROUP BY 
          metro_station_name_clean
   ORDER BY 
          metro_station_name_clean ASC 
)
--- compute the accesibility index based on the total of entrances available per metro station
   SELECT     CASE
              WHEN total_accesible_entrances= 0 then 'no accesible'
              WHEN total_accesible_entrances <= total_entrances/2 then 'Little Accesible'
              WHEN total_accesible_entrances >total_entrances/2 then 'Very Accesible'
              END AS 
          accesibility,
          metro_station_name_clean
FROM 
          total_entrances
