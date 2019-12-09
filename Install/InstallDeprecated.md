**Note: this installation process is now deprecated : please refer to the [up to date version](Readme.md)**

![Sketchy iTowns usage/developing  context](../UD-Doc/Devel/Architecture/Diagrams/OslandiaiTown2Context.png)

# Install notes for Unix users

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
 * Node.js
   - `sudo apt-get install node.js`
   - `sudo apt-get install npm`

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

### (4) Data base (c): Create an empty database
 * OSX:
   ````
   createdb bozo
   ````

* Ubuntu ([reference](https://wiki.debian.org/PostgreSql)):
   ````
   (root)$ sudo adduser db_user          # that is at OS level
           ...
   (root)$ sudo su postgres
   (postgres)$ createuser db_user        # this account (same name as above) is at PostGreSql level
   (postgres)$ createdb -O db_user bozo  # creates a new citydb_v3 database
   (postgres)$ exit
   ````

### (5) Data base (d): Add postgis extension and create a city table
````
(postgres)$ psql bozo
  bozo=# create extension postgis;
  bozo=# \q`  (or use CTRL d equivalently)
````
In the following interactions with the above created data base it is advised to `sudo su db_user`
````
  (db_user)$ psql bozo
    bozo=# create table lyon(gid serial primary key, geom GEOMETRY('POLYHEDRALSURFACEZ', 3946));
    bozo=# alter user dbuser with superuser;
    bozo=# \q  (or use CTRL d equivalently)
````

### (6) Data base (e): upload CityGML data to the DB
 * The original source for the CityGML based description of the building geometries is the [Grand Lyon open data](https://data.grandlyon.com/). For the time being (Q1 2017) this data doesn't separate the geometries of buildings. This is why FPE did a building split treatment (based on VCity) resulting in the [`LYON_6EME_BATI_2012_SplitBuildings.gml` file](http://liris.cnrs.fr/vcity/Data/iTowns2/LYON_6EME_BATI_2012_SplitBuildings.gml). In the following we'll assume this file is located in the HOME (shortened as `~`) directory.

    **WARNING**: the following snipet the set of commands must be executed with **VERSION 2 of python** (and pip) !

    ````
      git clone https://github.com/Oslandia/citygml2pgsql
      mv citygml2pgsql citygml2pgsql.git && cd citygml2pgsql.git
      wget http://liris.cnrs.fr/vcity/Data/iTowns2/LYON_6EME_BATI_2012_SplitBuildings.gml
      pip --version           ## Must be python version 2 !
      pip install lxml
      python ./citygml2pgsql.py -l LYON_6EME_BATI_2012_SplitBuildings.gml
      python ./citygml2pgsql.py LYON_6EME_BATI_2012_SplitBuildings.gml 2 3946 geom lyon |  psql bozo
    ````
   If you plateform doesn't have `wget` simply [open the LYON_6EME_BATI_2012_SplitBuildings.gml link](http://liris.cnrs.fr/vcity/Data/iTowns2/LYON_6EME_BATI_2012_SplitBuildings.gml) with your favorite browser and place the downloaded gml file in the ad-hoc directory.
 * Assert there is some content in the DB
   ````
    (db_user)$ psql bozo
      bozo=# select count(*) from lyon;
      bozo=# \q`  (or use CTRL d equivalently)
   ````

### (7) Data base (f): add bounding box data to database (JGA specific) & Install the http server

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

#### Temporary patch for handling gltf and b3dm

**WARNING**: make sure that
 - you are located in the `building-server.git` that you cloned
 - that you are using version3 of python and pip (that pip should be pip3!)

 * Install py3dtiles:
   ````
     git clone https://github.com/Oslandia/py3dtiles.git
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
 * `(venv): deactivate     # Exiting the python virtual environment`
 * Assert that resulting REST server is operational by opening e.g. `http://localhost:9090/#!/default/get_api_get_geometry`

Technical notes:
 * http gateway code is in
     [App.py](https://github.com/Oslandia/building-server/blob/3d-tiles/building_server/app.py)
 * Conversion SQL to client content is defined in [database.py](https://github.com/Oslandia/building-server/blob/3d-tiles/building_server/database.py)

### (9) Launch a local iTowns based application server
Note: this is iTowns version 2
````
cd <somewhere>
git clone https://github.com/iTowns/itowns.git
cd itowns
npm install
````
Configure a planar example over your data:
````
cd examples
cp planar.html planar_3dtiles.html
````
Edit the resulting `planar_3dtiles.html` and
  - replace `planar.js` with `planar_3dtiles.js`
````
cp planar.js planar_3dtiles.js
````
Edit the resulting `planar_3dtiles.js`:
 * copy the following section of js code into this `planar_3dtiles.js` (place it in global scope e.g. after the calls to `view.addLayer()`.  :
 ````
     // function use :
    // For preupdate Layer geomtry :
    const preUpdateGeo = (context, layer) => {
        if(layer.root === undefined) {
            itowns.init3dTilesLayer(context, layer);
            return [];
        }
        itowns.pre3dTilesUpdate(context, layer);
        return [layer.root];
    };

    // Create a new Layer 3d-tiles For DiscreteLOD
    // -------------------------------------------
    const $3dTilesLayerDiscreteLOD = new itowns.GeometryLayer('3d-tiles-discrete-lod', view.scene);

    $3dTilesLayerDiscreteLOD.preUpdate = preUpdateGeo;
    $3dTilesLayerDiscreteLOD.update = itowns.process3dTilesNode(
        itowns.$3dTilesCulling,
        itowns.$3dTilesSubdivisionControl
    );
    $3dTilesLayerDiscreteLOD.name = 'DiscreteLOD';
    $3dTilesLayerDiscreteLOD.url = 'http://localhost:9090/getCity?city=citydb_v3';
    $3dTilesLayerDiscreteLOD.protocol = '3d-tiles'
    $3dTilesLayerDiscreteLOD.overrideMaterials = true;  // custom cesium shaders are not functional
    $3dTilesLayerDiscreteLOD.type = 'geometry';
    $3dTilesLayerDiscreteLOD.visible = true;

    itowns.View.prototype.addLayer.call(view, $3dTilesLayerDiscreteLOD);

    // Create a new Layer 3d-tiles For Viewer Request Volume
    // -----------------------------------------------------
    const $3dTilesLayerRequestVolume = new itowns.GeometryLayer('3d-tiles-request-volume', view.scene);

    $3dTilesLayerRequestVolume.preUpdate = preUpdateGeo;
    $3dTilesLayerRequestVolume.update = itowns.process3dTilesNode(
        itowns.$3dTilesCulling,
        itowns.$3dTilesSubdivisionControl
    );

    $3dTilesLayerRequestVolume.name = 'RequestVolume';
    $3dTilesLayerRequestVolume.url = 'http://localhost:9090/getCity?city=citydb_v3';
    $3dTilesLayerRequestVolume.protocol = '3d-tiles'
    $3dTilesLayerRequestVolume.overrideMaterials = true;  // custom cesium shaders are not functional
    $3dTilesLayerRequestVolume.type = 'geometry';
    $3dTilesLayerRequestVolume.visible = true;

    itowns.View.prototype.addLayer.call(view, $3dTilesLayerRequestVolume);

 ````

Run `npm start`
Now open the resulting `http://localhost:8080/examples/planar_3dtiles.html` file with your favorite browser.

*Note : if after running `npm start` you have an error message saying that node is not find in `/usr/bin/env`, try running the following : `sudo ln -s /usr/bin/nodejs /usr/bin/node`. Explainations : on ubuntu node.js package is installed in /usr/bin/nodejs and when npm starts, it runs a the command `/usr/bin/env node` which it doesn't find. `sudo ln -s /usr/bin/nodejs /usr/bin/node` allows to create a symbolic link between node and nodejs in order to allow npm to find nodejs.*

Assert all is well by opening `http://localhost:8080/examples/planar.html` with your browser.
