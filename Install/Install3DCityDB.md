# 3DCityDB installation walkthrough<a name="top"></a>
In the following we distinguish two deployment use cases:
 - the **docker use case** where the 3dCity datastore is obtained by running a container
 - the **(linux) server configuration case** where a (linux) server is (intrusingly) configured by installing (with a package manager) a database server (and then configured).

## 1/ Installing a 3DCityDB+PostGIS (database) server
This chapter describes two different methods for installing a [3DCity Data Base](https://www.3dcitydb.org/3dcitydb/) server :
 - a quick an easy [3DCityDB **docker install**](#1a-installing-a-3dcitydbpostgis-server-with-docker)
 - a customizable [native package (apt) level installation](#1b-installing-a-3dcitydbpostgis-server-with-a-package-manager-apt)
 
### 1.A/ Installing a 3DCityDB+PostGIS server: the docker deployment case
 * Pre-requisite: [install Docker](https://docs.docker.com/install/).
 * Follow the [3DCityDB docker install steps](https://github.com/tum-gis/3dcitydb-docker-postgis#how-to-use-this-image) that boils down to ([mutatis mutandis](https://en.wikipedia.org/wiki/Mutatis_mutandis) and specially the password) 
    ```
    docker pull tumgis/3dcitydb-postgis:latest
    docker run -dit \
    --name citydb-container \
    -p 5432:5432 \
    -e "CITYDBNAME=citydb" \
    -e "SRID=3946" \
    -e "SRSNAME=espg:3946" \
    -e "POSTGRES_USER=postgres" \
    -e "POSTGRES_PASSWORD=postgres" \
      tumgis/3dcitydb-postgis
    ```
 * Troubleshooting:
   <br>
   if you get the following error message (when invocating your do`docker run`)
   ```
   ERROR: for citydb  Cannot start service citydb: driver failed programming external connectivity
          on endpoint v4xx_citydb_1 (...): Bind for 0.0.0.0:5432 failed: port is already allocated
   ```
   then some other service is already using port 5432. You now have three cases concerning the 5432 port:
     1. it was pre-empted by a (previously run) dandling container
     1. it was pre-empted by another service/container that you don't need anymore
     1. it was pre-empted by another service/container that you _do_ need (for example the [default API_Enhanced_City configuration](https://github.com/MEPP-team/UDV-server/blob/master/API_Enhanced_City/INSTALL.md#install-using-docker), that you [might have installed](Readme.md#backend-udv-serverapi_enhanced_city-install-notes) for your UDV demo, uses that port)<br>
   In the first two cases, you can free that port e.g. by retrieving the container culprit and killing with the following method<br>
      * print the list of running containers with the command `sudo docker container ls`,
      * find the `<name>` of container using port 5432,
      * run the command `sudo docker container stop <name>`,
      * eventually try again your `docker run ...` command.
   <br>
   Note that the 5432 port might also be allocated by some other services that you might retrieve with at command of the from `lsof -i :5432`.
   <br>
   In the third case (that is you don't have the freedom to kill the services/container) you can alter the `-p 5432:5432 ` argument of the above docker run by exposing another port of your choice.
 
 * **Use of the container**: After running the `docker run` command when installing the database, you can use the container immediately without any other command. However, each time you restart your computer, you should run the following command `sudo docker start citydb-container` in order to launch your database.
 
 
### 1.B/ Installing a 3DCityDB+PostGIS server: the (linux) server configuration case
Tested on:
 - Debian (GNU/Linux) 8.8 (jessie)
 - Ubuntu 14.04.3 (`lsb_release -a` yields `Ubuntu 14.04.3 LTS, Release 14.04, Codename trusty`)

We follow the [install documentation of 3DCityDB](http://www.3dcitydb.org/3dcitydb/fileadmin/downloaddata/3DCityDB_Documentation_v3.3.pdf) for the PostGRESql case:  
 * Chapter 3.1.1 p. 93: **install PostgreSQL 9.1 or higher and PostGIS 2.0 or higher**
   ````
   (bash)$ sudo apt-get install postgresql-9.4-postgis-2.1
   ````   
 * Chapter 3.3.2 P. 100, Step 1: **create an empty PostgreSQL database**
   We follow [debian PostgreSql tutorial](https://wiki.debian.org/PostgreSql) that goes:
   ````
   (root)$ sudo adduser citydb_user               # that is at OS level
           ...
   (root)$ sudo su postgres
   (postgres)$ createuser --password <new_password> citydb_user  # this account (same name as above) is at PostGreSql level  
   (postgres)$ createdb -O citydb_user citydb_v3                 # creates a new citydb_v3 database
   (postgres)$ exit
   ````
   Note: in order to suppress the existing database say citydb_v3 the command is `psql  -d <some-existing-base> -c 'DROP DATABASE IF EXISTS citydb_v3 '`
   
   Test that the server is accessible with
   ````
   (postgres)$ psql -d citydb_v3 -U citydb_user
   ````
   If you get an error message of the form `psql: FATAL:  Peer authentication failed for user "citydb_user" `then
     1. Obtain the server IP number  e.g. with the `ifconfig` command (below this IP is referred as ``<server_IP_number>`)  
     2. Edit the `/etc/postgresql/X.Y/main/pg_hba.conf` file (location may vary and edit as root or postgres user) and modify the local and host entries to read 
         ```` 
         local all all trust
         ...
         host all all <server_IP_number>/24 trust
         ````
     3. Edit the `/etc/postgresql/X.Y/main/postgresql.conf` file and allow for IPV4 bindings (i.e. on "which interfaces should PostgreSQL accept connections on" as opposed to specifying "who is allowed to connect to")
         ````
         listen_addresses = '0.0.0.0'
         port = 5432 
         ```` 
     4. Restart the server with :
         - Ubuntu: `(postgres)$ service postgresql restart`
         - Debian: `(postgres)$ systemctl restart postgresql`

    Test again with 
    ````
    (postgres)$ psql -d citydb_v3 -U citydb_user
    ````
    and the network connection (from the server) with
    ````
    (postgres)$ psql -h <server_IP_number> -d citydb_v3 -U citydb_user
    ````
 
 * Chapter 3.3.2 P. 100, Step 2: **Add the postgis extension**
   - Make sure you use a PostGre user that has Superuser (that is a PostGre role denomination as opposed to the Unix root user: this can be asserted with `\du`) rights on the considered database. The following gives `Superuser`rights to the citydb_user user: 
     ````
     (root)$ su - postgres
     (postgres)$ psql -d citydb_v3 -U postgres
        citydb_v3=# alter role citydb_user with superuser;
        citydb_v3=# \q
     ````
   - Add the postgis extension to the citydb_v3 database
     ````
     (root)$ su - citydb_user
     (citydb_user)$ psql -d citydb_v3 -c 'create extension postgis;'
     ````

## 2/ Feeding data to the 3DCity Data Base <a name="import-some-citygml-file-content"></a>

### 2.1/ Installation of Java Runtime Environment
Installing such an environment is required in order to run [3DCityDB Importer/Exporter](https://github.com/3dcitydb/importer-exporter).
 
 * Install Java Runtime Environment (version 8 or higher as specified in the [3DCityDB requirement](http://www.3dcitydb.org/3dcitydb/downloads/)). We here follow the ["Manual install" section of Ask-Ubuntu](https://askubuntu.com/questions/521145/how-to-install-oracle-java-on-ubuntu-14-04)] (refer also [here](https://www.mkyong.com/java/how-to-install-oracle-jdk-8-on-debian/)):
     - assert your architecture (32 or 64 bits) with `arch` and download the [latest version of JRE-8 from Oracle](http://www.oracle.com/technology/software/index.html) (`jre-8u131-linux-x64.tar.gz` as of April 2017) (because of Oracle's acceptance policy uses a cookie validation you might not be able to use wget directly in which case rebounce e.g. on your desktop) 
     - ````
       (root)$ cd /tmp       # in case the tarball is not clean
       (root)$ tar zxvf jre-8u131-linux-x64.tar.gz
       (root)$ mkdir /usr/lib/jvm
       (root)$ mv jre1.8.0_131 /usr/lib/jvm/oracle_jre1.8.0_131
       (root)$ update-alternatives --install /usr/bin/java java /usr/lib/jvm/oracle_jre1.8.0_131/bin/java 2000
       (root)$ rm -f jre-8u131-linux-x64.tar.gz
       ````
     - Create a `/etc/profile.d/oraclejdk.sh` with ad-hoc content e.g.
       ````
       export J2REDIR=/usr/lib/jvm/oracle_jre1.8.0_131
       export PATH=$PATH:/usr/lib/jvm/oracle_jre1.8.0_131/bin:
       export JAVA_HOME=/usr/lib/jvm/oracle_jre1.8.0_131
       ````
     
### 2.2/ Download and configure 3DCityDB Importer/Exporter 
 * Download 3DCityDB Importer/Exporter latest stable version software from [3DCityDB.org download site](http://www.3dcitydb.org/3dcitydb/downloads/).
   <br>
   Here is the command to run for the version 3.3.1:
   <br>
   `(citydb_user)$ wget http://www.3dcitydb.org/3dcitydb/fileadmin/downloaddata/3DCityDB-Importer-Exporter-3.3.1-Setup.jar` 

 * Install 3DCityDB and follow installer steps:
     - **Launch the `3DCityDB-Importer-Exporter`**: `(citydb_user)$ java -jar 3DCityDB-Importer-Exporter-3.3.1-Setup.jar`
     - Trouble shooting:
       <br>
        * on **debian** when getting the `Exception in thread "main" java.lang.NoClassDefFoundError: Could not initialize class java.awt.Toolkit` error message then ([cross fingers](https://stackoverflow.com/questions/18099614/java-lang-noclassdeffounderror-could-not-initialize-class-java-awt-toolkit) and) try `apt-get install libxtst6`.
        * **Distant server Warning**:
          <br>
          Note: distant server here means that e.g. you installed the 3DCityDB-Importer-Exporter on the remote server (using e.g. ssh to connect) where you previously installed the 3DCityDatabase.
          <br>
          If you are getting an error message of the form `X11 connection rejected because of wrong authentication` it is probably because 3DCityDB-Importer-Exporter, that uses a GUI interface based on the X11 windowing protocol, does not have the ad-hoc permissions to access the X11 server (running/emulated on you desktop). Thus you should first assert that so called ssh X11 forwarding is allowed. In order to do so, try to launch some X client e.g. `xclock` and assert that a clock indeeds pops up on your terminal.
          <br> 
          When this fails:
           - allow ssh login as `citydb_user` user and configure ssh for "X11 forwarding"
           - open a new terminal and run:
             * `ssh <server_ip_address>`
             * `sudo su - <user_to_authorize_forwarding>`
             * `pwd` and note the result
           - open a new terminal and run:
             * `ssh -X <server_ip_address>` (authorize X11 forwarding for the connection user)
             * `sudo cp .Xauthority <pwd_output_from_above>`
           - Make sure that the user for which we want to authorize forwarding has reading rights on the resulting copy of `.Xauthority` located in its home directory (when not, use e.g. `chown` or `chmod`) 

### 2.3/ Creating the 3DCityDB database structure

#### 2.3.A/ Creating the 3DCityDB database structure: the docker deployment case
The pre-build docker container comes with this task already integrated. You thus have nothing to do and can skip this step.

#### 2.3.B/ Creating the 3DCityDB database structure: the (linux) server configuration case
 * Configure 3DCityDB-Importer-Exporter to match your postgresql configuration
   * in version 3.3.1 of 3DCityDB Importer/Exporter:
     <br>
     Edit the shell variables of the "Provide your database details here" section of the `<path_to_3DCityDB-Importer-Exporter>/3dcitydb/postgresql/CREATE_DB.sh` script. After edition this section should look like:
      ```
      # Provide your database details here
      export PGPORT=5432
      export PGHOST=localhost
      export PGUSER=citydb_user
      export CITYDB=citydb_v3
      export PGBIN=/usr/bin/
      ```
   * In version 4.2.0 of 3DCityDB Importer/Exporter:
     <br>
     In this version, you do not have to modify the file `<path_to_3DCityDB-Importer-Exporter>/3dcitydb/postgresql/ShellScripts/Unix/CREATE_DB.sh`, because the shell variables to change are in the "Provide your database details here" section of the `<path_to_3DCityDB-Importer-Exporter>/3dcitydb/postgresql/ShellScripts/Unix/CONNECTION_DETAILS.sh` script.
     <br>
     After edition this section should look like (if you followed our docker tutorial above):
     ```
     # Provide your database details here ------------------------------------------
     export PGBIN=/usr/bin/
     export PGHOST=localhost
     export PGPORT=5432
     export CITYDB=citydb
     export PGUSER=postgres
     #------------------------------------------------------------------------------
     ```
 * Apply [chapter 3.3.2 p. 100, Step 3](http://www.3dcitydb.org/3dcitydb/fileadmin/downloaddata/3DCityDB_Documentation_v3.3.pdf): **Execute the CREATE_DB script**
   - ````
     cd <path_to_3DCityDB-Importer-Exporter>/3dcitydb/postgresql/
     psql -h <your_host_address> -p 5432 -d citydb_v3 -U citydb_user -f CREATE_DB.sql
     ````
    - When asked for `Please enter a valid SRID (e.g., 3068 for DHDN/Soldner Berlin):` , enter : `3946` (which is the standard coordinate system for Lyon)
    - When asked for `Please enter the corresponding SRSName to be used in GML exports (e.g., urn:ogc:def:crs, crs:EPSG::3068, crs:EPSG::5783):` , enter : `crs:EPSG::3946`
    
### 2.4/ Configure 3DCityDB-Importer-Exporter with your chosen 3dCityDB datastore
Before realising this step, please make independtly sure (with e.g. [pgAdmin4](https://www.pgadmin.org/download/)) that the preivous stages were successfull and that your 3DCityDB PostGreSQL database server is running, the considered port is accessible and that the database name you exists. 
   
Start 3DCityDB-Importer-Exporter GUI:
````
(citydb_user)$ chmod u+x 3DCityDB-Importer-Exporter.sh
(citydb_user)$ ./3DCityDB-Importer-Exporter.sh&
````
and notice that there is a console on the right side of the graphical interface.

#### 2.4.A/ Configure 3DCityDB-Importer-Exporter with your chosen 3dCityDB datastore: the (linux) server configuration case
Go to 3DCityDB-Importer-Exporter's "database configuration" tab and change the database connection configuration with the following configuration:
````
Connection: new connection
 ...
 Connection Details
    Description: citydb_v3
    Username: citydb_user
    Password: 
    Type: PostgreSQL/PostGIS
    Server: localhost
    Port:5432
    Database: citydb_v3
````
Hit the `Connect button`

Troubleshooting: when this fails and depending on your postgresql setup, you might need to provide the IP number of the server in place of the localhost string when configuring the Server entry.

#### 2.4.B/ Configure 3DCityDB-Importer-Exporter with your chosen 3dCityDB datastore: the docker deployment case
Go to 3DCityDB-Importer-Exporter's "database configuration" tab and change the database connection configuration with the following configuration that matches the one of the underlying Dockerfile:
````
Connection: New connection
 ...
 Connection Details
    Description: New connection
    Username: postgres
    Password: postgres
    Type: PostgreSQL/PostGIS
    Server: localhost
    Port:5432
    Database: citydb
    schema: citydb
````
Hit the `Connect button`

Troubleshooting: when this fails and depending on your postgresql setup, you might need to provide the IP number of the server in place of the localhost string when configuring the Server entry.

### 2.5/ CityGML file imporation per se.
In order to import a CityGML file from the 3DCityDB-Importer-Exporter GUI 
  * Go to to the "import" tab 
     - hit `browse`
     - choose a CityGML file (e.g. [Lyon data](https://data.grandlyon.com/localisation/maquette-3d-texturfe-de-larrondissement-de-lyon-1er-la-mftropole-de-lyon/))
     - hit `Import` 

### 2.6/ Some toher examples of CityGML files that you can import 
 - [Open Data](https://data.grandlyon.com/search/?Q=citygml+lyon) of Lyon Métropole for [year 2012: a walkthrough](DataLyonCityGML2012.md) 
 - [Open Data](https://data.grandlyon.com/search/?Q=citygml+lyon) of Lyon Métropole for [year 2015: a walkthrough](DataLyonCityGML2015.md)

## References
 * The following install notes are a derivation of [those previous notes](https://github.com/MEPP-team/VCity/wiki/3DCityDB_2017_03_07.md).
 * Chapter 3 p. 93 of [3DCityDB reference manual](http://www.3dcitydb.org/3dcitydb/fileadmin/downloaddata/3DCityDB_Documentation_v3.3.pdf) describe the install notes. 

