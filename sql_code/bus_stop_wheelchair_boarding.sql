with stops_clean as 
 (
 SELECT 
         stop_name,
         stop_code,
         stop_id,
              --- adding more readibility to the access code based on STM data dictionary
              CASE
              WHEN wheelchair_boarding = 0 then 'no wheelchair boarding information'
              WHEN wheelchair_boarding = 1 then 'wheelchair boarding'
              WHEN wheelchair_boarding = 2 then 'no wheelchair boarding'
              END AS 
         wheelchair_boarding
  FROM  
         stops
  WHERE 
         stop_name != upper(stop_name) ---to remove duplicated stops
  AND  
         stop_code > 20000
)

SELECT  
              COUNT (stop_id) as 
         total_stops, 
              COUNT 
              (CASE 
               WHEN 
               wheelchair_boarding = 'wheelchair boarding' then 1  else null 
               END) as 
         total_boardable_stops
FROM 
         stops_clean
