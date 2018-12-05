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
 * Run the interface with `./3DCityDB-Importer-Exporter.sh`and for each burough import:
   - `<burough_name>BATI<year>.gml`
   - `<burough_name>BATI_REMARQUABLE/*.gml  (this is a subdirectory)`
