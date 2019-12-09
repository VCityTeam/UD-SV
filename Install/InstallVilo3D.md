

# Vilod3D demo installation notes

**Note**: Vilo3d demo is configured by default such that the buildings come from locally encoded data (a tileset together with the geometry provided to the client as files). There is thus no requirement for a database server.

## Prerequisite: install nodejs and npm

* **Ubuntu**
  - Install and update npm
    ```
    sudo apt-get install npm    ## Will pull NodeJS
    sudo npm install -g n     
    sudo n latest
    ```
  - References: [how can I update Nodejs](https://askubuntu.com/questions/426750/how-can-i-update-my-nodejs-to-the-latest-version), and [install Ubuntu](http://www.hostingadvice.com/how-to/install-nodejs-ubuntu-14-04/#ubuntu-package-manager)

## Client Installation
```
  mkdir Vilo3D    # Not really needed but cleaner with a
                  # containment directory
  cd Vilo3d
  git clone https://github.com/MEPP-team/UDV.git
  pushd UDV
  git checkout Vilo3D-Demo-1.0
  popd
  git clone https://github.com/itowns/itowns.git
  cd itowns/
  git checkout v2.1.0
  Edit `itowns/node_modules/three/examples/js/loaders/ColladaLoader2.js`
     ---> insert the following line as first line
          `THREE = itowns.THREE;`
  npm install
```

## Installation of a temporal database to provide geometry

### (1) Install pre-requisite tools
 * The data base packages
   - OSX : `brew install postgis` (that will pull postGRE)
   - Ubuntu ([reference](http://trac.osgeo.org/postgis/wiki/UsersWikiPostGIS23UbuntuPGSQL96Apt)):
     ````
     sudo apt-get install postgresql-9.6
     sudo apt-get install postgresql-9.6-postgis-2.3 postgresql-contrib-9.6
     sudo apt-get install postgresql-9.6-postgis-2.3-scripts

     #to get the commandline tools shp2pgsql, raster2pgsql you need to do this
     sudo apt-get install postgis
     ````
     Additionaly you might consider installing [pgAdmin](https://www.pgadmin.org/) which is a convenient database management tool and thus usefull for debugging). If you choose to install pgAdmin on ther server (as opposed to your client/desktop) be aware that this will pull all the X11 related packages (which some consider as not belonging on a server).

 * Python tools
   - **Important notice**: in the following some scripts do work with python2.7 but some other scripts require python3...
   - OSX :
      ````
      brew install python3
      unset PYTHONPATH && pip3 install virtualenv
      ````
   - Ubuntu :
      ````
      sudo apt-get install python3
      sudo apt-get install python3-pip
      sudo pip3 install virtualenv      # Mind the sudo or the install will happen in `$(HOME)/.local/...`
      ````

### (2) Data base (a): start a postgres service
       * OSX :
         ````
         (root)$ initdb /usr/local/var/postgres -E utf8
         (root)$ postgres -D /usr/local/var/postgres &` (for launching a server)
         ````
       * Ubuntu :
         ````
         (root)$ service postgresql start
         ````

### (3) Data base (b): enable remote access to PostgreSQL database server via TCP/IP
         The reference for this step [is here](https://www.cyberciti.biz/tips/postgres-allow-remote-access-tcp-connection.html))
          * Change user to postgres : sudo su postgres
          * Enable lient authentication : vim /etc/postgresql/9.6/main/pg_hba.conf
          * Add the following line to this file (host) : all all 127.0.0.1/24 trust
          * Open PostgreSQL config file : vim /etc/postgresql/9.6/main/postgresql.conf
           * Change listen_adresses and port to the following :
           ````
               # - Connection Settings -

               listen_addresses = 'localhost'          # what IP address(es) to listen on;
                                                       # comma-separated list of addresses;
                                                       # defaults to 'localhost'; use '*' for all
                                                       # (change requires restart)
               port = 5432                             # (change requires restart)
           ````

           * switch back user : `exit`
           * restart psql : `sudo service postgresql restart`

### (4) Install the database.
The following instructions are within the context of Ubuntu version as given
by `lsb_release -a` yields `Description: Debian GNU/Linux 8.8 (jessie)`:

```
  sudo su citydb_user
  (citydb_user)$ createdb -O citydb_user lyon6_buildings
  (citydb_user)$ psql lyon6_buildings -c "create extension postgis;"
  (citydb_user)$ psql lyon6_buildings -c "create table lyon(gid serial primary key, geom GEOMETRY('POLYHEDRALSURFACEZ', 3946));"
```
Proceed with feeding the DB:
```
  (citydb_user)$ cd
  (citydb_user)$ mkdir Vilo3d
  (citydb_user)$ cd Vilo3d
  (citydb_user)$ git clone https://github.com/Oslandia/citygml2pgsql
  (citydb_user)$ mv citygml2pgsql citygml2pgsql.git && cd citygml2pgsql.git
  (citydb_user)$ wget http://liris.cnrs.fr/vcity/Data/iTowns2/LYON_6EME_BATI_2012_SplitBuildings.gml
  (citydb_user)$ pip --version         # sudo apt-get install python-pip in case you miss pip on python2 !
  (citydb_user)$ sudo pip install lxml # Refer below in case of failure on Python.h, libxml.h...
  python ./citygml2pgsql.py -l LYON_6EME_BATI_2012_SplitBuildings.gml
  python ./citygml2pgsql.py LYON_6EME_BATI_2012_SplitBuildings.gml 2 3946 geom lyon |  psql lyon6_buildings
```

Note: in case of trouble when install lxml python package with pip:
```
  # The following package install were required for pip install lxml to get through
  (citydb_user)$ sudo apt-get install libxml2-dev libxslt1-dev python-dev
  (citydb_user)$ sudo apt-get install zlib1g-dev    # because on 64 bit (uname-a)
```

Assert some content was indeed fed to the DB
```
  psql lyon6_buildings -c "select count(*) from lyon;"
```
which should return 511 buildings.

### (5) Manual edit of database
Then we need to delete two buildings from the 'lyon 6ème' database (in psql) in order to make room for our handmade models (of so called "Îlot du Lac").

Identifying the gid (`173` and `503`) of the buildings to be removed is achieved through geography based requests.

Delete those two buildings from the DB:
```
  (db_user)$ psql lyon6_buildings -c "delete from lyon where gid in (173,503);"
```

### (6) Install an http server

This step allows to serve the Collada files.

```
  sudo apt install apache2
  sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/rict.liris.cnrs.fr.conf
```
Edit the newly copied configuration file `/etc/apache2/sites-available/rict.liris.cnrs.fr.conf`: the following ad-hoc configuration should make it
```
<VirtualHost *:80>
	ServerName rict.liris.cnrs.fr
	ServerAlias www.rict.liris.cnrs.fr
	ServerAdmin webmaster@localhost
	DocumentRoot /home/citydb_user/Vilo3d
  <Directory /home/citydb_user/Vilo3d>
     Options Indexes FollowSymLinks MultiViews
     AllowOverride all
     Require all granted
  </Directory>
  ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```
In case of [CORS](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing) related errors refer to [Getting CORS to work with Apache](https://awesometoast.com/cors/) for further twitching.

Remove the default server (to avoid collisions):
```
  sudo rm /etc/apache2/sites-enabled/000-default.conf   ## which is a symlink anyhow
```
```
  sudo a2ensite rict.liris.cnrs.fr.conf   ## To enable the virtual site
  sudo service apache2 restart            ## Relaunch the service
```
Use Firefox to pop some requests on `http://rict.liris.cnrs.fr/UDV/Vilo3D/index.html`.

Trouble shoot by looking at server's error and log files:
  - `tail -f /var/log/apache2/error.log`
  - `tail -f /var/log/apache2/access.log`

Notes and references:
 * JGA discourages (within this context) the [usage of uWSGI](http://uwsgi-docs.readthedocs.io/en/latest/StaticFiles.html) as simple http server
 * [Ubuntu Apache2 configuration](https://www.digitalocean.com/community/tutorials/how-to-set-up-apache-virtual-hosts-on-ubuntu-14-04-lts)
 * [Ubuntu Apache2 install](https://help.ubuntu.com/lts/serverguide/httpd.html)

### (7) Data base (f): add bounding box data to database (JGA specific) & Install another http server

This http server is for serving the data of the database

  * The http server is based on [flask](http://flask.pocoo.org/). Note: the http server could also be configured to be Apache server.
  * We follow the install lines of [Oslandia's 3D tiles](https://github.com/Oslandia/building-server/tree/3d-tiles)
 JGA specific quad-tree based display uses a hierarchy of bounding boxes.

 Building that bounding box hierarchy is achieved by using an utility code (`building-server-processdb.py`) that comes bundled with the http server deployment code. Also notice although `building-server-processdb.py` make usage of Flask (see below) it nevertheless shares its configuration file with some Flak related concerns (see below for more).

 First grab the bounding boxes hierarchy building code:
 ````
   git clone https://github.com/Oslandia/building-server.git
   mv building-server building-server.git
   cd building-server.git/
   git checkout 3d-tiles
 ````
 Then extract the domain size from the DB with
 ```
   psql bozo
   bozo=# select ST_extent(geom) from lyon;
 ````
 which should yield a result of the form
 ````
   BOX(1843184.223319 5175387.163907,1845435.993083 5177744.541117)
 ````
 Edit configuration file `building-server.git/conf/building.yml` in order to inform the extent entry labeled with the result of the above command (remove `lyon_lod1:`, `lyon_lod2:` and `test:` sections). The `cities:` section of the `building.yml` configuration file should then be of the form (note that the DB access was also modified):

 Under ''flask'' related configuration, enter the details of Postgis DB you have just created.
 ````
 flask:
   DEBUG: True
   LOG_LEVEL: debug
   PG_HOST: localhost
   PG_NAME: bozo
   PG_PORT: 5432
   PG_USER: myuser
   PG_PASSWORD: password
 cities:
   lyon:
     tablename: lyon
     extent: [[1843184.223319, 5175387.163907],[1845435.993083, 5177744.541117]]
     maxtilesize: 2000
     srs: "EPSG:3946"
     attributes: []
     featurespertile: 20
 ````

 #### Install python3 required dependencies
 Deploy a Python3 [virtual environment](http://python-guide-pt-br.readthedocs.io/en/latest/dev/virtualenvs/) with all the bells and whistles.

 **WARNING**: make sure that
  1. you are located in the `building-server.git` that you cloned
  1. you are indeed on the `3d-tiles` branch
  1. that you are using version3 of python and pip (that pip should be pip3!)

  * OSX :
    ````
       unset PYTHONPATH
       virtualenv -p python3 venv      # Make sure this was installed with pip3
    ````
  * Ubuntu :
    ````
       virtualenv -p /usr/bin/python3 venv      # Make sure this was installed with pip3
    ````
  * OSX or Ubuntu:
  ````
      . venv/bin/activate
      pip install --upgrade setuptools
      pip install -e .
      pip install uwsgi
      pip install lxml     # Note sure this is truly required but it can't hurt
    ````

#### (8) Temporary patch for handling gltf and b3dm

 **WARNING**: make sure that
  - you are located in the `building-server.git` that you cloned
  - that you are using version3 of python and pip (that pip should be pip3!)

  * Install py3dtiles:
    ````
      git clone https://github.com/Oslandia/py3dtiles.git
      git checkout a9cc7adb411c8cabd6d532d8a586a53c3a525edb
      pip install ./py3dtiles/ --upgrade
      deactivate #since you are done with all necessary installation
    ````
    Warning: when doing the `pip install` make sure you are pointing to the `./py3dtiles` local directory as opposed to just `py3dtiles` that will look for some online repository version that won't be correct.


   * go back into building-server.git folder
   * activate venv : `. venv/bin/activate`

 #### Eventually compute the bounding boxes
 Then launch
 ````
   (venv): python building-server-processdb.py conf/building.yml lyon
 ````
 which will compute the bounding boxes out of the content of the pointed table within the concerned database and push the resulting hierarchy of bounding box data to a corresponding new table (named with a trailing `_bbox`) within that database.

 **Technical note**: the `conf/bulding.yml` configuration file mentions flask entries (and is also used to configure flask). Yet the `building-server-processdb.py` script only uses this file to retrieve the database access information and doesn't make any usage of flask. This lack of separation of concerns for the configuration files is an historical side effect...

### (8) Launch the [REST](https://en.wikipedia.org/wiki/Representational_state_transfer) server
  * Edit building-server.git/conf/building.uwsgi.yml to obtain a configuration like
    ````
     uwsgi:
         virtualenv: /Users/mylogin/tmp/building-server.git/venv      # <--- adapt this
         master: true
         uid: oslandia
         gid: oslandia
         module: building_server.wsgi:app
         processes: 1                                                 # <--- adapt that
         enable-threads: true
         protocol: uwsgi
         need-app: true
         catch-exceptions: true
         log-maxsize: 10000000
         logto2: /Users/mylogin/tmp/building-server.git/building-server.log                # <--- change this
         env: BUILDING_SETTINGS=/Users/mylogin/tmp/building-server.git/conf/building.yml   # <--- change this
    ````
  * `(venv): uwsgi --yml conf/building.uwsgi.yml --http-socket :9090`
  * Assert that resulting REST server is operational by opening e.g. `http://localhost:9090/#!/default/get_api_get_geometry`

 Technical notes:
  * http gateway code is in
      [App.py](https://github.com/Oslandia/building-server/blob/3d-tiles/building_server/app.py)
  * Conversion SQL to client content is defined in [database.py](https://github.com/Oslandia/building-server/blob/3d-tiles/building_server/database.py)


### (6) Usage
 * When on the http server, open `UDV/Vilo3D/index.html` in Firefox (Chrome not supported)
