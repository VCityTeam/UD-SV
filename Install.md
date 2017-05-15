
![Sketchy iTowns usage/developing  context](Doc/Devel/Needs/Architecture/Diagrams/OslandiaiTown2Context.png)
  
# Install notes for Unix users

### Install pre-requisite tools
 * The data base packages 
   - OSX : `brew install postgis` (that will pull postGRE) 
   - Ubuntu : 
   ```` 
     sudo apt-get install postgresql-9.6
     sudo apt-get install postgresql-9.6-postgis-2.3 postgresql-contrib-9.6

     #to get the commandline tools shp2pgsql, raster2pgsql you need to do this
     sudo apt-get install postgis
   ````
   (http://trac.osgeo.org/postgis/wiki/UsersWikiPostGIS23UbuntuPGSQL96Apt)
   
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
      sudo apt-get install python-pip
      pip3 install virtualenv
      ````


    
### Data base: initialization and preparation
 * OSX :
   ```` 
    initdb /usr/local/var/postgres -E utf8
    postgres -D /usr/local/var/postgres &` (for launching a server)
   ````

  * Ubuntu : `service postgresql start`
  * createdb bozo
 
 * *Note : it is advised to replace 'myuser' by your session name in the following instructions.'*
    ```` 
    psql bozo
    - bozo=# create extension postgis;
    - bozo=# create table lyon(gid serial primary key, geom GEOMETRY('POLYHEDRALSURFACEZ', 3946));
    - bozo=# create user myuser with password 'password';
    - bozo=# alter user myuser with superuser;
    - bozo=# \q`  (or use CTRL d equivalently)
    ````

### Data base: upload CityGML data to the DB
 * The original source for the CityGML based description of the building geometries is the [Grand Lyon open data](https://data.grandlyon.com/). For the time being (Q1 2017) this data doesn't separate the geometries of buildings. This is why FPE did a building split treatment (based on VCity) resulting in the [`LYON_6EME_BATI_2012_SplitBuildings.gml` file](http://liris.cnrs.fr/vcity/Data/iTowns2/LYON_6EME_BATI_2012_SplitBuildings.gml). In the following we'll assume this file is located in the HOME (shortened as `~`) directory. 
    ````
      git clone https://github.com/Oslandia/citygml2pgsql
      mv citygml2pgsql citygml2pgsql.git && cd citygml2pgsql.git
      wget http://liris.cnrs.fr/vcity/Data/iTowns2/LYON_6EME_BATI_2012_SplitBuildings.gml
      ./citygml2pgsql.py -l LYON_6EME_BATI_2012_SplitBuildings.gml
      python ./citygml2pgsql.py LYON_6EME_BATI_2012_SplitBuildings.gml 2 3946 geom lyon |  psql bozo
    ````
   If you plateform doesn't have `wget` simply [open the LYON_6EME_BATI_2012_SplitBuildings.gml` link](git clone https://github.com/MEPP-team/RICT.wiki.git) with your favorite browser and place the downloaded gml file in the ad-hoc directory.
 * Assert there is some content in the DB

    `psql bozo` and `bozo=# select count(*) from lyon;`

### Switch to python3 (and install required dependencies)
Deploy a Python3 [virtual environment](http://python-guide-pt-br.readthedocs.io/en/latest/dev/virtualenvs/) with all the bells and whistles:

 * OSX :
   ````
     unset PYTHONPATH 
     virtualenv venv      # Make sure this was installed with pip3
     . venv/bin/activate
     pip install --upgrade setuptools
     pip install -e .
     pip install uwsgi
     pip install lxml     # Note sure this is truly required but it can't hurt
   ````
 * Ubuntu :
   ````
     virtualenv -p /usr/bin/python3 venv      # Make sure this was installed with pip3 (if not, run : pip3 uninstall virtualenv && sudo pip3 install virtualenv)
     . venv/bin/activate
     pip install --upgrade setuptools
     pip install -e .
     pip install uwsgi
     pip install lxml     # Note sure this is truly required but it can't hurt
   ````
### Data base: add bounding box data to database (JGA specific)
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
Edit configuration file `building-server.git/conf/building.yml` in order to inform the extent entry labeled with the result of the above command (remove `lyon_lod1:`, lyon_lod2:` and `test:` sections). The `cities:` section of the `building.yml` configuration file should then be of the form (note that the DB access was also modified):
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

Then launch
````
  (venv): python building-server-processdb.py conf/building.yml lyon
````
which will compute the bounding boxes out of the content of the pointed table within the concerned database and push the resulting hierarchy of bounding box data to a corresponding new table (named with a trailing `_bbox`) within that database.

**Technical note**: the `conf/bulding.yml` configuration file mentions flask entries (and is also used to configure flask). Yet the `building-server-processdb.py` script only uses this file to retrieve the database access information and doesn't make any usage of flask. This lack of separation of concerns for the configuration files is an historical side effect...

## Install the http server
 * The http server is based on [flask](http://flask.pocoo.org/). Note: the http server could also be configured to be Apache server.
 * We follow the install lines of [Oslandia's 3D tiles](https://github.com/Oslandia/building-server/tree/3d-tiles)
 * `cd building-server.git/`
 * **FIXME**: we probably don't need this anymore `git checkout 3d-tiles` (the "correct" branch is not the master) 
 * Install branch b3dm of py3dtiles: **FIXME**: the following is a temporary patch, but it won't be needed anymore in the next comming weeks.
   ````
     git clone https://github.com/Oslandia/py3dtiles.git`
     git checkout b3dm`
     go into building-server folder and run : `pip install /chemin/vers/py3dtiles --upgrade`
   ````

### Launch the [REST](https://en.wikipedia.org/wiki/Representational_state_transfer) server 
 * Edit bulding.uwsgi.yml to obtain a configuration like
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
 * `(venv): uwsgi --yml conf/building.uwsgi.yml --http-socket :9090 &`
 * `(venv): deactivate     # Exiting the python virtual environment`
 * Assert that resulting REST server is operational by opening e.g. `http://localhost:9090/#!/default/get_api_get_geometry`

Technical notes:
 * http gateway code is in
     [App.py](https://github.com/Oslandia/building-server/blob/3d-tiles/building_server/app.py)
 * Conversion SQL to client content is defined in [database.py](https://github.com/Oslandia/building-server/blob/3d-tiles/building_server/database.py)

### Launch a local iTowns server
````
cd <somewhere>
git clone https://github.com/iTowns/itowns2.git
cd itowns2
git checkout 3d-tiles
npm install
````
Now either open `itowns2/index.html` file with your browser or alternatively run `npm start`.

Assert all is well by opening `http://localhost:8080/examples/planar.html` with your browser.

# Architecture notes:

Notes:
 * [uWSGI](https://uwsgi-docs.readthedocs.io/en/latest/) is a [Web Server Gateway Interface (WSGI)](https://en.wikipedia.org/wiki/Web_Server_Gateway_Interface) compatible applications and frameworks (used among the Python community). [uWSGI can be deployed](https://uwsgi-docs.readthedocs.io/en/latest/WebServers.html) with its own integrated http server. [Flask](http://flask.pocoo.org/) is a [web micro-framework](https://en.wikipedia.org/wiki/Flask_(web_framework)) that uses [uWSGI as web deployment option](http://flask.pocoo.org/docs/0.12/deploying/uwsgi/).
 * The `citygml2PSQL.py` and `building_server_processdb.py` both update a database. Yet note that the usage of `citygml2PSQL.py` is at the command line level (its input is a file and it uses a [shell based pipe](https://en.wikipedia.org/wiki/Pipeline_(Unix) mechanism) and is hence offline) whereas `building_server_processdb.py` is at the SQL protocol level (hence online or networked). 
 * The [DTM](https://en.wikipedia.org/wiki/Digital_elevation_model) terrain data is downloaded on the fly by iTowns (in the case of Lyon directly from [Grand Lyon WMS server](https://download.data.grandlyon.com/wms/grandlyon?SERVICE=WMS&REQUEST=GetMap&LAYERS=MNT2012_Altitude_10m_CC46&VERSION=1.3.0&STYLES=&FORMAT=image/jpeg&TRANSPARENT=false&BBOX=1840285.7887575002,5172130.550769992,1841520.2114662502,5173177.596804991&CRS=EPSG:3946&WIDTH=256&HEIGHT=256).
 * The deployed REST server uses [3DTiles](https://github.com/AnalyticalGraphicsInc/3d-tiles) (made by the [Cesium consortium](http://cesiumjs.org/about.html) i.e. mainly an [AGI ( Analytical Graphics, Inc.)](http://www.agi.com/home) emanation.
