## On debian
Tested on:
 - Debian (GNU/Linux) 8.8 (jessie)
 - Ubuntu 14.04.3 (`lsb_release -a` yields `Ubuntu 14.04.3 LTS, Release 14.04, Codename trusty` and `more /etc/debian_version` yields `jessie/sid`)

We follow the [install documentation of 3DCityDB](http://www.3dcitydb.org/3dcitydb/fileadmin/downloaddata/3DCityDB_Documentation_v3.3.pdf) for the PostGRESql case:  
 * Chapter 3.1.1 p. 93: **install PostgreSQL 9.1 or higher and PostGIS 2.0 or higher**
   ````
   (bash)$ sudo apt-get install postgresql-9.4-postgis-2.1
   ````   
 * Chapter 3.3.2 P. 100, Step 1: **create an empty PostgreSQL database**
   We follow [debian PostgreSql tutorial](https://wiki.debian.org/PostgreSql) (with some help of [: 
   ````
   (root)$ sudo adduser citydb_user               # that is at OS level
           ...
   (root)$ sudo su postgres
   (postgres)$ createuser citydb_user             # this account (same name as above) is at PostGreSql level  
   (postgres)$ createdb -O citydb_user citydb_v3  # creates a new citydb_v3 database
   (postgres)$ exit
   ````
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
     (citydb_user)$ psql -d citydb_v3
        citydb_v3=# create extension postgis;
        citydb_v3=# \q
     ````
 * Install Java Runtime Environment (version 8 or higher) (as [3DCityDB requirement](http://www.3dcitydb.org/3dcitydb/downloads/). We follow the ["Manual install" section of Ask Ubuntu(https://askubuntu.com/questions/521145/how-to-install-oracle-java-on-ubuntu-14-04)] (see also [here](https://www.mkyong.com/java/how-to-install-oracle-jdk-8-on-debian/):
     - assert your architecture (32 or 64 bits) with `arch` and download the [latest version of JRE-8 from Oracle](http://www.oracle.com/technology/software/index.html) (`jre-8u131-linux-x64.tar.gz` as of April 2017) (you'
     - ````
       cd /tmp
       tar zxvf jre-8u131-linux-x64.tar.gz
       sudo mv jre1.8.0_131 /usr/lib/jvm/oracle_jre1.8.0_131
       sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/oracle_jre1.8.0_131/bin/java 2000
       rm -f jre-8u131-linux-x64.tar.gz
       ````
     - Create a `/etc/profile.d/oraclejdk.sh` with ad-hoc content

 * Download 3DCityDB software from [3DCityDB.org download site](http://www.3dcitydb.org/3dcitydb/downloads/) 
     - `wget http://www.3dcitydb.org/3dcitydb/fileadmin/downloaddata/3DCityDB-Importer-Exporter-3.3.1-Setup.jar` 

 * Install 3DCityDB and follow installer steps:
     - `java -jar 3DCityDB-Importer-Exporter-3.3.1-Setup.jar` 

 * Configure 3DCityDB to match your postgresql configuration:

    * Edit the shell variables of the "Provide your database details here" section of the `<path_to_3DCityDB-Importer-Exporter>/3dcitydb/postgresql/CREATE_DB.sh` script. After edition this section should look like:

      ````
          # Provide your database details here
          export PGPORT=5432
          export PGHOST=localhost
          export PGUSER=citydb_user
          export CITYDB=citydb_v3
          export PGBIN=/usr/bin/

      ````
 * Chapter 3.3.2 P. 100, Step 3: **Execute the CREATE_DB script**
   - ````
     cd <path_to_3DCityDB-Importer-Exporter>/3dcitydb/postgresql/
     psql -h <your_host_address> -p 5432 -d citydb_v3 -U citydb_user -f CREATE_DB.sql
     ````
    - When asked for `Please enter a valid SRID (e.g., 3068 for DHDN/Soldner Berlin):` , enter : `3946` (which is the standard coordinate system for Lyon)
    - When asked for `Please enter the corresponding SRSName to be used in GML exports (e.g., urn:ogc:def:crs, crs:EPSG::3068, crs:EPSG::5783):` , enter : `crs:EPSG::3946`

* Start 3DCityDB:
   ````
      chmod u+x 3DCityDB-Importer-Exporter.sh
      ./3DCityDB-Importer-Exporter.sh&
   ````

 * Go to database tab and change database connection to the following:

   ````
      Connection: new connection

     Connection Details
      Description: citydb_v3
      Username: citydb_user
      Password: 
      Type: PostgreSQL/PostGIS
      Server: localhost
      Port:5432
      Database: citydb_v3
   ````

   Hit `Connect button`
 
 * Import a CityGML file: 
   * Go back to import tab. 
   * Hit browse and choose a CityGML file.
   * Hit Import 

 *Note: there is a console on the right side.* 

 
## References
 * The following install notes are a derivation of [those previous notes](https://github.com/MEPP-team/VCity/wiki/3DCityDB_2017_03_07.md).
 * Chapter 3 p. 93 of [3DCityDB reference manual](http://www.3dcitydb.org/3dcitydb/fileadmin/downloaddata/3DCityDB_Documentation_v3.3.pdf) describe the install notes. 

