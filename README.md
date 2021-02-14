![](image/accesibility.png) 
# STM Accessibilty Review 

## Data exploration and tools
- For this the data tables were taken directly form the [STM.com website](http://www.stm.info/en/about/developers). 
- The data was downloaded on February 2021 and according to the `calendar` table contains data related to the trips from October 26th 2020 to March 21st, 2021 
- The analysis was done using SQL and Python.

## Data ask
With the main purpose to use data analysis on public transit accessibility, the objetive is to provide more details about the real accesibility to the Bus and Metro un Montreal, based on the Access to Stations and posibility to use the bus service offered by the STM

## Data Quality test
- Some data was dumplicated due to malformed names in the metro stations.
- The total of trips in the data were validated using the public information on the STM website.
- The total of available Bus units os not available, however the total of trips is consistent with the public information on the STM website. 

## Data Modeling

Four SQL queries were required to model and perfom the initial data exploration:
- *bus_stop_wheelchair_boarding*: to validate the total of bus stops adecuate for users on wheelchair.
- *bus_trips_wheelchair_accessibility*: to validate the total of bus trips adecuate for users on wheelchair.
- *metro_stations_wheelchair_boarding_accessibility*: to validate the total of metro stations with adecuate access for users on wheelchair
- *total_bus_accessibility_opportunities_stops_plus_units*: combining the bus stops data and the trips accesibility, to create an index based on the total ooporunities to effectively board a accesible vehicule from an accesible stop.

All queries are included in SQL files (sql_code folder).

## Data Analysis

Additinally some Statiscs Analysis were done using Pyhton:

All code is included (python_code folder).

## Results: Data story
Final results are presented in the data story "Montréal Public Transport Accessibility" in this repo. 
The data story contains: context, caveats, findings, charts (also available in the charts folder) and conclusion. Finally added personal next steps based on my data interest in the subject.
