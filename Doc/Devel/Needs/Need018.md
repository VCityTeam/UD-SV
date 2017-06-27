# Need 018 : Enhance geometry of the city by adding semantic information

### User story
As a city knowledgeable person, I want to be have semantic information about the geometry representing the city.

### Beneficiary role: 
City knowledgeable person, general audience

### Impact: 
Major

### Maturity:
Ongoing

### Cost evaluation:
1 man month

### Tags or keywords

### Description
Geometry is not sufficient for representing cities. It is also usefull to have semantic information such as the type of city
objects and a hierarchy between this semantic information.It is also useful to have complementary information about these city 
objects such as the construction date of a building or the owner of a terrain. 

Example of usecases:
  * View composition analysis, Sunlight and shadow computation... (Atmosphere of the city)
  * Enhancing city models with documents

### Notes:

* [CityGML](https://www.citygml.org/) allows to have semantic and a geometric model representing the city and has a strong community.
* [3DCityDB](www.3dcitydb.org/) is a free CityGML compliant 3D geo database to store, represent, and manage virtual 3D city models on top of PostGIS.
