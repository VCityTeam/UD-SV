This document describes how to obtained some Tiling data out of some specific 
[Lyon Métropole Open Data](https://data.grandlyon.com/) already stored within a
[3DCity Database](https://github.com/3dcitydb/3dcitydb).

## Prerequisite
 Prior to Tiling the data (describe at next chapter) you first need to
  - [Import the orginal data in a 3DCityDB database](DataLyonCityGML2009.md). 
  - Install Py3dTiles tiling software refer below

### Install Py3DTiles
```
git clone https://github.com/MEPP-team/py3dtiles.git
mv py3dtiles/ py3dtiles.git
cd py3dtiles.git
git checkout 91a4755 ( SHA1 91a47558819a5b5a065f1101c727fd72f552d9b6 )
git checkout Tiler   
virtualenv -p python3 venv
. venv/bin/activate
pip install -e .
python setup.py install
pip install pytest pytest-benchmark
pytest
pip install pyyaml
```

## Configure the Tiler
```
pushd  Tilers/CityTiler
cp CityTilerDBConfigReference.yml CityTilerDBConfig_2009.yml
```
Edit `CityTilerDBConfig_2009.yml` and proceed with configuration
by giving the information required to access the 3DCityDB. You should
obtain something like
```
PG_HOST: 'rict.liris.cnrs.fr'
PG_NAME: 'citydb_lyon_2009_full'
PG_PORT: 5432
PG_USER: 'citydb_user'
PG_PASSWORD: 'XXXXXXXXXX'
```
Change working directory back to home of py3dtiles git repository
``` 
popd    
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
