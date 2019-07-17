This document describes how to obtained some Tiling data out of some specific 
[Lyon Métropole Open Data](https://data.grandlyon.com/) already stored within a
[3DCity Database](https://github.com/3dcitydb/3dcitydb).

## Prerequisite
 Prior to Tiling the data (describe at next chapter) you first need to
  - [Import the orginal data in a 3DCityDB database](DataLyonCityGML2009.md). 
  - Install (refer below) [Py3dTiles](https://github.com/Oslandia/py3dtiles) that includes some tiling utilities 

### Install and configure Py3DTiles
Follow the [py3Dtiles install notes](https://github.com/MEPP-team/py3dtiles/Tiler/Tilers/CityTiler/Install.md).
For the [database configuration](https://github.com/MEPP-team/py3dtiles/blob/Tiler/Tilers/CityTiler/Install.md#4-configure-the-database-description-file) file (the rest of this description uses the `CityTilerDBConfig_2009.yml` filename) ou should
obtain something like
```
PG_HOST: 'rict.liris.cnrs.fr'
PG_NAME: 'citydb_lyon_2009_full'
PG_PORT: 5432
PG_USER: 'citydb_user'
PG_PASSWORD: 'XXXXXXXXXX'
```

## Running the Tiler
Running the Tiler (_without_ the [Batch Table Hierarchy](https://github.com/AnalyticalGraphicsInc/3d-tiles/tree/master/extensions/3DTILES_batch_table_hierarchy))
````
python3 Tilers/CityTiler/CityTiler.py \
        Tilers/CityTiler/CityTilerDBConfig_2009_full.yml
````
You can collect the results from the `junk` sub-directory
````
mv junk ../../<where-you-need-them-to-be>
````
In case you need the [Batch Table Hierarchies](https://github.com/AnalyticalGraphicsInc/3d-tiles/tree/master/extensions/3DTILES_batch_table_hierarchy), the invocations goes
````
python3 Tilers/CityTiler/CityTiler.py --with_BTH \
        Tilers/CityTiler/CityTilerDBConfig_2009_full.yml 
mv junk ../../DataStore/TileSet_Lyon_2009_full_BTH
````

## Publishing the resulting Tile Sets
A simple way of "publishing" your data (through http) is to use the lightweight [server](https://github.com/AnalyticalGraphicsInc/3d-tiles-samples/blob/master/server.js) offered by the [AGI's 3D-tiles-samples utility](https://github.com/AnalyticalGraphicsInc/3d-tiles-samples.git) and provided with their Data samples.
