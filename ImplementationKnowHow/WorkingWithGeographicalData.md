## What should be documented here

---
### Projection system
Converting from one system to another: proj4 library (exists in python, JS ?, C++, Java...but where)

**Content to be included**:

[Find the projection system out of the coordinates](https://cad.kerlom.fr/topographie_coordonnees.php#)

---
### Extent

**Content to be included**:

The [geofabrik-calc tool](http://tools.geofabrik.de/calc/), enables to find coordinates of your area of interest in the "CD" tab. Please mind the projection system, that you can easily transform using [this platform](https://epsg.io/transform#s_srs=4326&t_srs=3946).

---
### Going back and forth between global and local coordinates
More precisely going back and forth between geographical coordinate system (global as on the earth globe) and 
visusalization coordinate system (local to the vizualization context).

The [following comments in CityTiler](https://github.com/VCityTeam/py3dtilers/blob/master/py3dtilers/CityTiler/CityTiler.py#L124) illustrate this issue and the associated good practice. 
   


