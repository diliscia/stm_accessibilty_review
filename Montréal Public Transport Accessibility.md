# Montréal Public Transport Accessibility

## Context

The current project analyses the availability of accessibility in the STM system. 
The actual analysis involves boarding accessibility in the Metro Stations, Bus Stops and Bus Units. 
For this the data tables were taken directly form the [STM.com website](http://www.stm.info/en/about/developers). 
The analysis was done using SQL and Python.

#### Caveat
* The actual number of STM bus units is not known. The availabe  information consists of the existing Metro stations, bus stops and trips.

## Bus Stops Accessibility based on Wheelchair Boarding

91% of all Montréal Bus stops have Wheelchair Boarding Accessibility. Is important to mention that the same access also can be used for bikes.
According to the STM site all the STM buses are properly equipped to securely carry wheelchairs and bikes.
This accessibility is also relevant for parents with small kids in strollers.

![BusWCHAccess](/charts/BusWCHAccess.png)

## Metro Stations Accessibility Based on Wheelchair Boarding

However, there is significantly room for improvement in the Metro stations. As is shown by the next chart, only 14 (20 %) of the 68 Montréal Metro stations have a at least one entrance with Wheelchairs Boarding Accessibility. The rest of the stations are No Accessible at all, what is an important point to consider.
In order to analyze this, it was proposed an accessibility index to compute the total of entrances with Wheelchair Boarding Accessibility based on the total number of entrances.
If more than the half of the entrances to the station have Wheelchair Boarding Accessibility it is considered that is a Very Accessible Station. If less than half of the entrances have Wheelchair Boarding Accessibility it is considered a Little Accessible Station.
Is interesting to notice that 9 stations have more than half of the entrances with Wheelchair Boarding Accessibility.

![MetWCHAccess](https://github.com/diliscia/stm_accessibilty_review/blob/main/chart/BusWCHAccess.png)

## Bus Trips Accessibility Based on Wheelchair Boarding

From the data 65% of the bus trips are indicated as Wheelchair Accessible, this is curious knowing that the STM website mentions that "All vehicles are wheelchair accessible, with the exception of minibuses operated on Navette Or shuttles and the 212 - Sainte-Anne line." (https://www.stm.info/en/access/using-public-transit-wheelchair).
This could come from differences in the definitions of what the STM means in the website information as a wheelchair accesible vehicle and the definition from the data reference that says "Vehicle being used on this particular trip can accommodate at least one rider in a wheelchair.".

![TripsWCHAccess](/charts/TripsWCHAccess.png)

## Total Bus Accesibility Oortunities (Stop + Unit)

![TripsWCHAccess](/charts/TripsWCHAccess.png)

## Next Steps
* Considering that the exact number of units is unknown (is known that is over 1800) a   
