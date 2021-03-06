<img src="https://github.com/diliscia/stm_accessibilty_review/blob/main/image/accessible-icon-dinamic.jpeg" width="80" height="80"> 

# Montreal Public Transport Accessibility

## Context

- The current project analyzes the availability of accessible transport in the STM system. 
- The actual analysis involves boarding accessibility in the Metro Stations, Bus Stops and Bus Units. 
- The goal is to summarize overall STM access for people with mobility limitation, including people using wheelchairs and parents with kids that require strollers. Accessible public transport is also helpful for users with bikes who need public transport to complete their journey. 
- According to the STM website "[All vehicles are wheelchair accessible](https://www.stm.info/en/access/using-public-transit-wheelchair), with the exception of minibuses operated on Navette Or shuttles and the 212 - Sainte-Anne line.". However, given that there exists a schedule for `buses with a ramp at the front`, it's likely that not all buses have the complete ideal equipment.
- In this document, I start by summarizing my findings. Afterwards at the [bottom of this readme](https://github.com/diliscia/stm_accessibilty_review/blob/main/README.md#stm-accessibilty-review-metodology-notes), you can find details about the methodology used.

---
## Content
The analysis is presented in two main blocks, Bus and Metro

Regarding the Bus it was possible to analyze: 
- [Bus Stops Accessibility Based on Wheelchair Boarding](https://github.com/diliscia/stm_accessibilty_review#bus-stops-accessibility-based-on-wheelchair-boarding)
- [Bus Trips Accessibility Based on Wheelchair Accessible](https://github.com/diliscia/stm_accessibilty_review#bus-trips-accessibility-based-on-wheelchair-accesible)
- [Total Bus Accessibility Opportunities (Stop + Unit)](https://github.com/diliscia/stm_accessibilty_review#total-bus-accessibility-oportunities-stop--unit)
- [Total Bus Accessibility Opportunities by Routes (Stop + Unit)](https://github.com/diliscia/stm_accessibilty_review#total-bus-accessibility-opportunities-by-routes-stop--unit)
- [Presence of the Bus Accessibility Combination Events in the Routes](https://github.com/diliscia/stm_accessibilty_review#presence-of-the-bus-accessibility-combination-events-in-the-routes)
- [Vehicle and Stops Accessibility by Routes](https://github.com/diliscia/stm_accessibilty_review#vehicle-and-stops-accessibility-by-routes)

Regarding the Metro stations:
- [Metro Stations Accessibility Based on Wheelchair Boarding](https://github.com/diliscia/stm_accessibilty_review#metro-stations-accessibility-based-on-wheelchair-boarding)

---
# STM Bus Accessibility

### Bus Stops Accessibility Based on Wheelchair Boarding

- 91% of all Montreal Bus stops have Wheelchair Boarding Accessibility. Is important to mention that the same access also can be used for bikes. According to the STM site all the STM buses are properly equipped to securely carry wheelchairs and bikes. This accessibility is also relevant for parents with small kids in strollers.

![](chart/BusWCHAccess.png)

### Bus Trips Accessibility Based on Wheelchair Accessible

- Since it was not possible to find the number of bus units, the variable **wheelchair_accessible** related to the trips was used.
- A same bus can do more than one trip, but the bus won't change during the trip.
- Based on the results, 65% of the bus trips are indicated as Wheelchair Accessible. This differs from the `All vehicles are wheelchair accessible` information on the STM website.
- It's possible that the variable *wheelchair_accessible* in the trips data is defined with a different approach and that the 35% gap could be related to the availability of the `ramp at the front` or number of wheel_chairs that can be accommodated inside the unit.

![](chart/TripsWCHAccess.png)

### Total Bus Accessibility Opportunities (Stop + Unit)

- Accessible stops are not enough, a person with reduced mobility requires an Accessible unit and to have accessible boarding both where they get on and where they get off.
- For the purpose of this analysis, an **event** is defined as the combination of a trip and a stop. 
- Based on the data, I created a Bus Accessibility Opportunity index:

    - When the stop is `boarding accessible` and the trip is `wheelchair accessible` the event is defined as `fully accessible`.
    - When the stop is `boarding accessible` but the trip is not `wheelchair accessible` the event is defined as `inadequate vehicle`.
    - When the stop is not `boarding accessible` but the trip is `wheelchair accessible` the event is defined as `inadequate stop`.
    - When the stop is not `boarding accessible` and the trip is not `wheelchair accessible` the event is defined as `fully_innaccessible`.
    
- The data shows that just 2.5% of all the events are Fully Inaccessible and 63.7% are Fully Accessible. 
- 31.2% of the events are not accessible due to the vehicule. This could cause some valid frustration to the users, however there is a high probability that the next trip will have an appropriate vehicule.

![](chart/BusComWCHAccess.png)

### Total Bus Accessibility Opportunities by Routes (Stop + Unit)

- Data shows consistency by showing well defined areas or clouds of event points even distributed overall the routes. 
- The `Fully Accessible` events are on the top of the chart (higher percentages) and `Fully Inaccessible` events are mainly at the bottom (lower percentages), with few outliners `Fully Inaccessible`  with high percentage.
- It can be seen that the `Fully Accessible` events are between 50% and 100% present in all the routes.
- `Fully Inaccessible` events are located mostly below the 25% with a few isolated cases that are analyzed in the following: 

    - Three routes have 100% Fully Accessibility, followed closely by other routes with high Fully Accessibility events percentage:
        - 13-Christophe-Colomb 
        - 77-Station Lionel-Groulx / CUSM 
        - 193-Jarry
    - These routes are mostly located in the [Centre of the Metropolitan Area of the City](http://www.stm.info/sites/default/files/pdf/fr/plan_reseau.pdf). 
    - There are just 4 routes with more `Fully Inaccessibility` events superior to 50%, the rest of the routes have less than 35% `Fully Inaccessibility`events: 
        - 212-Sainte-Anne
        - 219 Chemin Sainte-Marie 
        - 220-Kieran 
        - 419-Express John Abbott
    - These 4 routes travel through the [Autoroute 40](http://www.stm.info/sites/default/files/pdf/fr/plan_reseau.pdf) or operate in [West-Island](http://www.stm.info/sites/default/files/pdf/fr/plan_reseau.pdf). This reinforces that if you are taking a bus from a route within the Centre of the Metropolitan Area of the City you have more chances to board an `adequate vehicle` from an `adequate stop`. 
    
![](chart/BusComWCHAccessScatter.png)

### Presence of the Bus Accessibility Combination Events in the Routes
- Over 67% of the routes have more than 50% of `Fully Accessibility` events. This means that when taking a bus, in more than 2/3 of the total routes the user has more than 50% of chances of boarding an `adequate vehicle` from an `adequate bus stop`.
- The other events (`Inadequate Vehicle`, `Fully Inaccessibility` and `Inadequate Stop`) have a presence below 50% each in more than 80% of the routes.
- More than 95% of the `Fully Inaccessibility` and `Inadequate Stop` events are present in less than 20% of the routes. This means that no matter the route you are using the chance of taking an `inadequate vehicle` is low, but the chance of boarding from an `inadequate stop` is even lower.

![](chart/BusAccPres.png)

### Vehicle and Stops Accessibility by Routes
- It was computed an Accesibility average per route, either for stops and vehicules accesibility.
- Over 92% of the routes have a high percentage on average (75-100%) of `aboardable stops`, that means that the chances to board from an `adequate stop` are really high doesn't matter in which route you are traveling. 
- On the other hand, the vehicle availability on average (trips) is good, but not as good as the stops. 71% of the routes have more than 50% on average of `accessible vehicles`, but just 28% of the routes on everage have a high percentage (75-100%). 

![](chart/VehStoAcc.png)

# STM Metro Accessibility

### Metro Stations Accessibility Based on Wheelchair Boarding

- However, there is significantly room for improvement in the [Metro Stations](http://www.stm.info/en/info/networks/metro). Only 14 (20%) of the 68 Montreal Metro Stations have at least one entrance with Wheelchairs Boarding Accessibility.
- In order to provide more details, I created an Accessibility Index to compute the number of entrances with Wheelchair Boarding Accessibility based on the total number of entrances:

    - If more than half of the entrances to the station have Wheelchair Boarding Accessibility it is considered that is a `Very Accessible Station`. 
    - If less than half of the entrances have Wheelchair Boarding Accessibility it is considered a `Little Accessible Station`.
    
- It is interesting to notice that 9 stations have more than half of the entrances with Wheelchair Boarding Accessibility.

![](chart/MetWCHAccess.png)

---
## Conclusion
Based on the STM website, improving accessibility in the system is a priority and the data could help to find the best and more impactful opportunities for the affected users, here some useful insights:
- The Montreal Bus offer seems pretty friendly for users with reduced mobility.
- The STM bus network has more than 60% of `Fully Accessibility` in all the Metropolitan Area.
- The chance to take an `adequate vehicle` from an `adequate stop` is higher close to the Montreal Metropolitan Centre.
- The chance of boarding from an `adequate stop` is higher than taking an `adequate vehicle`.
- The availability of `adequate vehicles` must increase to catch-up with the `adequate stops`.
- Despite the fact that the Metro Accessibility is not offered widely in the system the biggest stations are properly equipped with elevators to facilitate secure access with a wheelchair.
- Some Metro Stations have over half of their entrances accessible.



## Next Steps
* Cross reference the data with traffic and trips usage capacity, to validate the best t

imes for people with reduced mobility to use the public transit.
* Map the most accessible friendly routes in Montreal.
* Cross reference the accessibility data with cultural routes or any other activities, in order to offer the best options to users with reduced mobility.
* Follow the improvement of the accessibility in the whole network through time.

---
---

<img src="https://github.com/diliscia/stm_accessibilty_review/blob/main/image/accesibility.png" width="80" height="80"> 

# STM Accessibility Review. Methodology notes

## Data Exploration and Tools
- For this analysis I used publicly accessible data on the [STM.com website](http://www.stm.info/en/about/developers). 
- The data was downloaded on February 2021 and according to the `calendar` table it contains data related to the trips from October 26th 2020 to March 21st, 2021. 
- The analysis was done using SQL.

## Data Task
- The objective of the analysis is to provide more details about the real accessibility of Buses and Metro Stations in Montreal.

## Caveat
- The actual number of STM bus units is not available in the data. However, using the trips information, it was possible to create a proxy value called `bus trips`.
- The dataset does not clarify the computation used for “total services offered”.
- *wheelchair_boarding* is related to the Bus Stop or Metro Station infrastructure, "wheelchair boardings are possible from the location".*
- *wheelchair_accessible* refers to the vehicle, "used on this particular trip can accommodate at least one rider in a wheelchair."*
[STM data dictionary](https://developers.google.com/transit/gtfs/reference)

## Data Quality Test
- Some data was duplicated due to malformed names in the Metro Stations (accents, dash or numbers to identify the Metro entrances). Some cleaning was performed to remove the duplications.
- The total of trips in the data were validated using the public information on the STM website.
- The total of Bus units is not available, however the total of trips (within the calendar window) is consistent with the public information on the STM website. 

## Data Modeling and Analysis

Five SQL queries were required to model and perform the initial data exploration:
- **bus_stop_wheelchair_boarding.sql**: to validate the total of bus stops adequate for users on a wheelchair.
- **bus_trips_wheelchair_accessibility.sql**: to validate the total of bus trips adequate for users on wheelchair.
- **metro_stations_wheelchair_boarding_accessibility.sql**: to validate the total of metro stations with adequate access for users on wheelchair
- **total_bus_accessibility_opportunities_stops_plus_units.sql**: combining the bus stops and trips accessibility data, to create an index based on the total opportunities to effectively board an accessible vehicle from an boardable stop.
- **total_bus_accessibility_opportunities_by_route.sql**: grouping the stops / trips events by routes, to validate the total opportunities of full access presented to the users for each offered bus route in the system.   
- **total_bus_accessibility_average_per_route.sql**: compute the average of accessible stops and accessible vehicles per route.


All queries are included in SQL files (sql_code folder).
