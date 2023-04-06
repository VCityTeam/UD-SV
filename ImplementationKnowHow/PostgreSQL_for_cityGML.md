# Install 3DCityDB with Docker

Assert that docker is properly installed.

Pull the latest [3DCityDB Image](https://hub.docker.com/r/3dcitydb/3dcitydb-pg) :
```
docker pull 3dcitydb/3dcitydb-pg:latest
```
Run the image on a chosen port (/!\ assert that this port is not already used by another program):

```
docker run --name citydb -p $YOURPORT:5432 -d -e POSTGRES_PASSWORD=$YOURPASSWORD -e SRID=$EPSGCODE 3dcitydb/3dcitydb-pg:latest
```

You can now use pgAdmin4 to connect to the 3DCityDB and check if its running (both db and user should be by default "postgres")

/!\ Do not use 'localhost' but use your local ip adress to point to the 3DCityDB 

Fill the 3DCityDB using the [3DCityDB/impexp](https://hub.docker.com/r/3dcitydb/impexp) docker :

```
docker pull 3dcitydb/impexp:latest
docker run --rm --name impexp -v $PATH_TO_YOUR_REPO_HOLDING_YOUR_DATA:/data 3dcitydb/impexp:latest import -H $YOUR_LOCAL_IP -p $WYOURPORT -d postgres -u postgres -p $YOURPASSWORD /data/$YOURFILE.gml
```

# Install 3DCityDB with CL

This note explains how to setup PostgreSQL to be able to create cityGML databases, for example in order to run [py3dtilers](https://github.com/VCityTeam/py3dtilers).

This tuto is inspired by [Fabrice Lainard's tutorial](https://www.flprogramming.fr/index.php/2020/01/21/integration-citygml/) (in french).

## 1. Download PostgreSQL/PostGIS

Download and install a [PostgreSQL version](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads).

Run the installer and install PostgreSQL and all the additional components. You can keep the default installation parameters.

![image](https://user-images.githubusercontent.com/32875283/141955094-14e12007-2c24-46a0-8363-85b62544d241.png)

Once PostgreSQL installation is over, execute Stack Builder and install Postgis.

![image](https://user-images.githubusercontent.com/32875283/154264885-634ded09-bf89-4f7a-aa80-ab838faaff69.png)

![image](https://user-images.githubusercontent.com/32875283/135090973-3954ca72-da20-4711-8242-262039bc9373.png)

Install PostGIS

![image](https://user-images.githubusercontent.com/32875283/154265126-f7753c9b-8046-4e96-95e6-52ffa078edda.png)

If your PostgreSQL password isn't set yet, launch pgAdmin4 to set it.

![image](https://user-images.githubusercontent.com/32875283/154265468-4f98e8f8-0f38-4c3b-87d9-502be8e6fb98.png)

_Note_: To be able to use the `psql` command in Windows shell, add the `bin` folder path (for example _C:\Program Files\PostgreSQL\10\bin_) in PATH environmental variable. You can now use the `psql -U postgres <...>` commands on Windows.

## 2. Create a 3DCityDB database
_Warning_: Java must [installed and setted](https://docs.oracle.com/cd/E19182-01/821-0917/inst_jdk_javahome_t/index.html) to continue.

Download and install [3DCityDB](https://www.3dcitydb.org/3dcitydb/downloads/).

Launch the application pgAdmin4 and create a database.

![image](https://user-images.githubusercontent.com/32875283/154266268-7a2922c4-a918-4d73-b427-0c1bc37fef0a.png)

Select your database and open the `Query tool`.

![image](https://user-images.githubusercontent.com/32875283/154266657-0bc83528-f30c-4fe0-96e2-12b36e0ba85f.png)

Create `postgis` and `postgis_raster` extensions. Execute the query.

![image](https://user-images.githubusercontent.com/32875283/141961178-9fe74cab-2988-499e-a501-25247a6a81fa.png)

![image](https://user-images.githubusercontent.com/32875283/154267027-998ff6c0-a3d9-4058-afcc-fce51b550bbe.png)

In the `3DCityDB-Importer-Exporter` folder you've installed before, find the `CONNECTION_DETAILS` script (in _<path>\3DCityDB-Importer-Exporter\3dcitydb\postgresql\ShellScripts_, then choose _Windows_ or _Unix_). Edit `CONNECTION_DETAILS` with the details of your database and run `CREATE_DB`. The script will ask you a SRID (for example 3946 if your data is in EPSG:3946) and your PostgreSQL password.

![image](https://user-images.githubusercontent.com/32875283/154267768-98274d45-2aa3-4942-a60b-75f8b87975e1.png)

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
