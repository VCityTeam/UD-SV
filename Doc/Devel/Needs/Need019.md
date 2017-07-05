## Need 019 : Provide means for storing and accessing semantic information extending the geometric information of a city 

### User story
As a GUI user, I want to retrieve the semantic information attached 
to some geometry displayed in the interface so that I can then explore
and navigate that semantic information within the interface.

Sub Needs :
 - [Need 11](Need011.md) : user interface 
 - [Need 18](Need018.md) : means for storing and accessing semantic information
 
### Beneficiary role: 
City knowledgeable person, general audience

### Impact: 
Minor

### Maturity:
Ongoing

### Cost evaluation:
1 man month

### Tags or keywords

### Description
Geometry is a restricted concern that might not sufficient (e.g. to the considered domain of concern like noise, economics, light, sociology...) when modeling (representing) cities. It is also usefull to have 
  - semantic information such as the kind of city objects (this is the type of object) 
  - a modeling hierarchy between such levels of semantic information
  - additional (to the geometry) information concerning these city objects such as the construction date of a building or the owner of a terrain (these are the object attributes)

### Notes:
* [CityGML](https://www.citygml.org/) allows to have semantic and a geometric model representing the city and has a strong community.
* [3DCityDB](www.3dcitydb.org/) is a free CityGML compliant 3D geo database to store, represent, and manage virtual 3D city models on top of PostGIS.
