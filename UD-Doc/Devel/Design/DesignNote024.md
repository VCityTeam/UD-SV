# Design note of [Need 024](../Needs/Need024.md) : Street Adress Geolocation 

## References

[Associated issue](https://github.com/MEPP-team/RICT/issues/49)

## What need to be developed to obtain a prototype

To answer this need, we need to:
  * 1. The adresses of the objects of the city (e.g. buildings) in the database
  * 2. A geolocation library (client-side, so javascript) allowing to browse adresses and to map adresses to geolocations in the virtual representation of the city.  
  
### 1. Adresses of the objects of the city in the database

* There is a geolocation database available on the data grand lyon website: https://data.grandlyon.com/localisation/base-adresse-locale-bal-de-la-mftropole-de-lyon/

* CityGML 2015 data holds the adresses associated to each city object. However, they are stored as "Generic attributes" (see the following screenshot) while there is a field for storing them in the CityGML standard. This might be a problem when loading the CityGML files in the 3DCityDB database. 

![](images/CityGMLAdresses.jpg)

### 2. Geolocation javascript library

We might need a geolocation library on the client side to help us manage street adresses. A lead might be to check the one Cesium uses.


