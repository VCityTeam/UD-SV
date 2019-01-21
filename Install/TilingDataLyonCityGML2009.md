This document describes how to obtained some Tiling data out of some specific 
[Lyon Métropole Open Data](https://data.grandlyon.com/) already stored within a
[3DCity Database](https://github.com/3dcitydb/3dcitydb).

## Prerequisite
 Prior to Tiling the data (describe at next chapter) you first need to
  - [Import the orginal data in a 3DCityDB database](DataLyonCityGML2009.md). 
  - Install Py3dTiles tiling software.

## Importing the Data




````
python3 Tilers/CityTiler/CityTiler.py \
        Tilers/CityTiler/CityTilerDBConfig_2009_full.yml 
mv junk ../../DataStore/TileSet_Lyon_2009_full
python3 Tilers/CityTiler/CityTiler.py \
        Tilers/CityTiler/CityTilerDBConfig_2012_full.yml 
mv junk ../../DataStore/TileSet_Lyon_2012_full
python3 Tilers/CityTiler/CityTiler.py
        Tilers/CityTiler/CityTilerDBConfig_2015_full.yml 
mv junk ../../DataStore/TileSet_Lyon_2015_full
````
````
python3 Tilers/CityTiler/CityTiler.py --with_BTH \
        Tilers/CityTiler/CityTilerDBConfig_2009_full.yml 
mv junk ../../DataStore/TileSet_Lyon_2009_full_BTH
python3 Tilers/CityTiler/CityTiler.py --with_BTH \
        Tilers/CityTiler/CityTilerDBConfig_2012_full.yml 
mv junk ../../DataStore/TileSet_Lyon_2012_full_BTH
python3 Tilers/CityTiler/CityTiler.py --with_BTH \
        Tilers/CityTiler/CityTilerDBConfig_2015_full.yml 
mv junk ../../DataStore/TileSet_Lyon_2015_full_BTH
````
