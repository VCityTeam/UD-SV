# PostgreSQL for cityGML

This note explains how to setup PostgreSQL to be able to create cityGML databases, for example in order to run [py3dtilers](https://github.com/VCityTeam/py3dtilers).

This tuto is inspired by [Fabrice Lainard's tutorial](https://www.flprogramming.fr/index.php/2020/01/21/integration-citygml/) (in french).

## 1. Download PostgreSQL/PostGIS

Download and install a [PostgreSQL version](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads).

Run the installer and install PostgreSQL. When PostgreSQL installation is over, execute Stack Builder and install Postgis.

![image](https://user-images.githubusercontent.com/32875283/141955094-14e12007-2c24-46a0-8363-85b62544d241.png)

![image](https://user-images.githubusercontent.com/32875283/135090973-3954ca72-da20-4711-8242-262039bc9373.png)

Launch pgAdmin to set your `postgres` password.

To be able to use the `psql` command in Windows shell, add the `bin` folder path (for example _C:\Program Files\PostgreSQL\10\bin_) in PATH environmental variable. You can now use the `psql -U postgres <...>` commands on Windows.

## 2. Create a 3DCityDB database
_Warning_: Java must [installed and setted](https://docs.oracle.com/cd/E19182-01/821-0917/inst_jdk_javahome_t/index.html) to continue.

Download and install [3DCityDB](https://www.3dcitydb.org/3dcitydb/downloads/).

In pgAdmin, create a database then create `postgis` and `postgis_raster` extensions.

![image](https://user-images.githubusercontent.com/32875283/141961178-9fe74cab-2988-499e-a501-25247a6a81fa.png)

In the _3DCityDB-Importer-Exporter_ you've installed before, find the `CONNECTION_DETAILS` script (in _<path>\3DCityDB-Importer-Exporter\3dcitydb\postgresql\ShellScripts_, then choose _Windows_ or _Unix_). Edit `CONNECTION_DETAILS` with the details of your database and run `CREATE_DB`. The script will ask you a SRID (for example 3946) and your PostgreSQL password.
  
![image](https://user-images.githubusercontent.com/32875283/141962647-c7e2f2b1-17b9-413a-a6a8-693f51518d16.png)

![image](https://user-images.githubusercontent.com/32875283/141962939-16578a8e-1a1f-4265-8e25-60fb67a17504.png)

Your database can now receive cityGML data.
  
## 3. Import cityGML in database
  
Launch the `3DCityDB-Importer-Exporter` script (from the root of your 3DCityDB-Importer-Exporter installation.
  
In _Database_, add the details of your database.
  
![image](https://user-images.githubusercontent.com/32875283/141963964-aebed5a7-3f57-426f-ae03-9342fcb9728a.png)

Then in _Import_, browse for a .gml file then click on 'Import' below.
  
![image](https://user-images.githubusercontent.com/32875283/141964362-30d8830a-1cfb-4ed5-aadf-d04521b171c3.png)

You can import as much cityGML files as you want in your database. Your database is now ready.
