This document describes how to concretly import some specific [Lyon Métropole Open Data](https://data.grandlyon.com/) within a [3DCity Database](https://github.com/3dcitydb/3dcitydb).

## Prerequisite
Prior to importing the data (describe at next chapter) you first need to [install a 3DCityDB database](Install3DCityDB.md). 

## Importing the Data
Create a target directory and connect into it. Then
````
mkdir Lyon_2009
cd Lyon_2009
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_1ER_2009.zip
unzip LYON_1ER_2009.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_2EME_2009.zip
unzip LYON_2EME_2009.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_3EME_2009.zip
unzip LYON_3EME_2009.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_4EME_2009.zip
unzip LYON_4EME_2009.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_5EME_2009.zip
unzip LYON_5EME_2009.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_6EME_2009.zip
unzip LYON_6EME_2009.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_7EME_2009.zip
unzip LYON_7EME_2009.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_8EME_2009.zip
unzip LYON_8EME_2009.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_9EME_2009.zip
unzip LYON_9EME_2009.zip
````

* Edit file `LYON_8EME_2009/LYON_8EME_BATI_2009.gml` and remove 
   - the full <cityObjectMember> block describing the <bldg:Building gml:id="LYON_8_00166"> building (starting on line 1202763 and ending at line 1202789),
   - the full <cityObjectMember> block describing the <bldg:Building gml:id="LYON_8_00177"> building (that prior to the above previous block deletion, is starting on line 1202791 and ending at line 1202817).

* Edit file `LYON_7EME_2009/LYON_7EME_BATI_2009.gml` and remove the full <cityObjectMember> block describing the <bldg:Building gml:id="LYON_7EME_00110"> building (starting on line 3065366 and ending at line 3065392).

* Note: the above buildings had to be removed because their <gml:MultiSurface srsDimension="3"> entries, that supposedly decribe the geometry of the respective parts of this building, are empty (which might confuse any geometrical post-treatment).

Proceed with the [importation within your 3DCityDB database](Install3DCityDB.md#import-some-citygml-file-content)
For the impatient this goes:
 * Create the database
   ````
   (citydb_user)$ psql -d citydb_v3 -c 'DROP DATABASE IF EXISTS citydb_lyon_2009_full'
   (citydb_user)$ createdb -O citydb_user citydb_lyon_2009_full
   (citydb_user)$ psql  -d citydb_lyon_2009_full -c'create extension postgis;'
   ```` 
 * Edit 3dcitydb/postgresql/CREATE_DB.sh
 * Run that database table creation script:
   ````
   cd 3dcitydb/postgresql
   psql -h 127.0.0.1 -p 5432 -d citydb_lyon_2009_full -U citydb_user -f CREATE_DB.sql
   ````
   When asked for enter 
    - the database password
    - `3946` as valid SRID (this corresponds to the standard coordinate system for Lyon)
    - `crs:EPSG::3946` as corresponding SRSName to be used in GML exports
    
 * Run the interface with `./3DCityDB-Importer-Exporter.sh`and for each burough import:
   - `<burough_name>BATI<year>.gml`
   - `<burough_name>BATI_REMARQUABLE/*.gml  (this is a subdirectory)`
