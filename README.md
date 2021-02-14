<img src="https://github.com/diliscia/stm_accessibilty_review/blob/main/image/accessible-icon-dinamic.jpeg" width="80" height="80"> 

# Montreal Public Transport Accessibility

## Context

- The current project analyze the availability of accessibility in the STM system. 
- The actual analysis involves boarding accessibility in the Metro Stations, Bus Stops and Bus Units. 
- The goal is to provide an more detailed approximation about the global acces in the STM for people with mobility limitation, including people using Wheelchair and pares with kids that require strollers. This accesibility is also helful for users with bikes who need plublic transit to complete of the full schedule. 
- Accodringto the STM "[All vehicles are wheelchair accessible]((https://www.stm.info/en/access/using-public-transit-wheelchair)), with the exception of minibuses operated on Navette Or shuttles and the 212 - Sainte-Anne line.". Howver based on the `schedule for buses with ramp at the front` is possible to guess that not all of the have the complete ideal equipment.
- At the [button of this readme](https://github.com/diliscia/stm_accessibilty_review/blob/main/README.md#stm-accessibilty-review-metodology-notes), more details about the methodology used.

---

#### Caveat
-  In the data is not available the actual number of STM bus units. However using the trips information it was possible to create a proxy value called `bus trips`.
- Is not clear in the data how is computed the total of services offered.
- *boarding accesible* is related to the Bus stop infrastructure, "wheelchair boardings are possible from the location".*
- *wheelchair accessible* refers to the vehicle, "used on this particular trip can accommodate at least one rider in a wheelchair."*
[STM data dictionary](https://developers.google.com/transit/gtfs/reference)
---

### Bus Stops Accessibility based on Wheelchair Boarding

- 91% of all Montréal Bus stops have Wheelchair Boarding Accessibility. This is 
- PLACEHOLDER TO ADD SOMETHING ABOUT WHERE ARE THE MOST STOPS WITHOUT ACCESS

![](chart/BusWCHAccess.png)

### Bus Trips Accessibility Based on Wheelchair Boarding

- Since it was not possible to find the number of Bus units, it was used the variable `Wheelchair Accessible` related to the trips.
- The same bus can do more than one trip, but it won't change during the trip.
- Based on the results, 65% of the bus trips are indicated as Wheelchair Accessible. That differs from the `all vehicules accesible`
- It's possible that the variable `wheelchair accesible` in the trip data is defined with a different approach and the 35% gap could be related to the availability to the `ramp at the front`.

![](chart/TripsWCHAccess.png)

### Total Bus Accesibility Oportunities (Stop + Unit)

- Accessible stops are not enough, the person with rediced mobility requires a Accesible unite and have boarding accesibility in the starting and ending stop.
- Based on the data it was proposed an Bus Accessibility Opportunity index:

    - When the stop is `boarding accesible` and the vehicule is `wheelchair accessible` the trip is defined as `fully accesible`.
    - When the stop is `boarding accesibile` but the vehicule is not `wheelchair accessible` the trip is defined as `bad vehicle`.
    - When the stop is not `boarding accesibile` but the vehicule is `wheelchair accessible` the trip is defined as `bad stop`.
    - When the stop is not `boarding accesibile` and the vehicule is not `wheelchair accessible` the trip is defined as `fully_innacesible`.
    
- The data shows that just 2.5% of trips and fully inacessible and 63.7% are fully inacessible.
- The 31.2% of trips not accessible due to the vehicule, could cause some valid frustration to the users, however there are good propbabilities to have a approtiated vehicule in the text trip.

![](chart/BusComWCHAccess.png)

### Metro Stations Accessibility Based on Wheelchair Boarding

- However, there is significantly room for improvement in the Metro stations. 
- Only 14 (20 %) of the 68 Montréal Metro stations have a at least one entrance with Wheelchairs Boarding Accessibility. 
- In order to provide more details, it was proposed an accessibility index to compute the total of entrances with Wheelchair Boarding Accessibility based on the total number of entrances:

    - If more than the half of the entrances to the station have Wheelchair Boarding Accessibility it is considered that is a `Very Accessible Station`. 
    - If less than half of the entrances have Wheelchair Boarding Accessibility it is considered a `Little Accessible Station`.
    
- Is interesting to notice that 9 stations have more than half of the entrances with Wheelchair Boarding Accessibility.

![](chart/MetWCHAccess.png)

---
## Conclusion
- The Montreal Bus offer in Montreal seems pretty friendly with users with reduced mobility.
- Despite the Metro Accesibility is not offered widely, the biggest stations are properly equiped with elevators to facilitate the secure access with wheelchair.
- Some Metro stations are accessible in most of the half of the access.
- Based on the STM website, improve accesiibility in the syste is a priority, and the data could help to find the best and more impactufull oportunities for the impacted users.


## Next Steps
* Cross the data with traffic and trips usage capacity, to validate the best times for people with reduced mobility to use the public transit
* Map the most accesible friendly routes in Montreal
* Cross the accesibility data with cultural routes or any other activities, in order to offer the best options to users with reduced mobility.

---
---

<img src="https://github.com/diliscia/stm_accessibilty_review/blob/main/image/accesibility.png" width="80" height="80"> 

# STM Accessibilty Review. Metodology notes

## Data exploration and tools
- For this analysis it was used public data was accesible on the [STM.com website](http://www.stm.info/en/about/developers). 
- The data was downloaded on February 2021 and according to the `calendar` table contains data related to the trips from October 26th 2020 to March 21st, 2021 
- The analysis was done using SQL and Python.

## Data ask
With the main purpose to use data analysis on public transit accessibility, the objetive is to provide more details about the real accesibility to the Bus and Metro in Montreal, using as proposed metrics: the access to Metro the stations and posibility to use the bus service offered by the STM.

## Data Quality test
- Some data was duplicated due to malformed names in the metro stations (accents, dash or numbers to idnetify the metro entrance). Some cleaning was perfomed to remove the duplications.
- The total of trips in the data were validated using the public information on the STM website.
- The total of available Bus units os not available, however the total of trips is consistent with the public information on the STM website. 

## Data Modeling

Four SQL queries were required to model and perfom the initial data exploration:
- **bus_stop_wheelchair_boarding**: to validate the total of bus stops adecuate for users on wheelchair.
- **bus_trips_wheelchair_accessibility**: to validate the total of bus trips adecuate for users on wheelchair.
- **metro_stations_wheelchair_boarding_accessibility**: to validate the total of metro stations with adecuate access for users on wheelchair
- **total_bus_accessibility_opportunities_stops_plus_units**: combining the bus stops data and the trips accesibility, to create an index based on the total ooporunities to effectively board a accesible vehicule from an accesible stop.

All queries are included in SQL files (sql_code folder).

## Data Analysis

Additinally some Statiscs Analysis were done using Pyhton:

PLACE HOLDER TO EXPLAIN THE PYTHON WORK DONE

All code is included (python_code folder).

