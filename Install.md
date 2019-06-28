# Install and utilization notes for Unix users

This document first explains how to install and configure all the components of
VCity's web application and then how to use them with two use-cases:
    * 3D urban data web exchange and visualisation
    * 3D+time urban data web exchange and visualisation

The application is composed of server-side components and of a web client based on [iTowns](http://www.itowns-project.org/) (javascript web framework for visualisation 3D geospatial data). You can find more information about these components and about the software architecture of the application [here](https://github.com/MEPP-team/RICT/tree/master/Doc/Devel/Architecture).

## Install notes

### Server-side components install

#### Install 3DCityDB

If you need to install a 3DCityDB database, follow the instructions described [here](Install/Install3DCityDB.md).

#### Install UDV-server

[UDV-server](https://github.com/MEPP-team/UDV-server) is a collection of tools useful for our application. If you want to install them, follow the instructions described [here](https://github.com/MEPP-team/UDV-server/blob/master/API_Enhanced_City/INSTALL.md).

#### Install py3dtiles

[py3dtiles](https://github.com/MEPP-team/py3dtiles) ([forked from Oslandia](https://github.com/Oslandia/py3dtiles)) is a component allowing to compute a 3dtiles tileset from a directory or a database. More info [here](https://github.com/MEPP-team/py3dtiles/blob/3dtiles-temporal-v2/README.rst).

Install pre-requisite tools:
````
    sudo apt-get install python3
    sudo apt-get install python3-pip
    sudo pip3 install virtualenv      # Mind the sudos or the install will
                                      # happen in `$(HOME)/.local/...`
````

Open a terminal and run:

````
    git clone https://github.com/MEPP-team/py3dtiles.git
    cd py3dtiles
    git checkout 3dtiles-temporal-v2
````

Deploy a virtual environment (this step is not mandatory; it is useful for having local dependencies to the packages installed next.)
````
    virtualenv -p python3 venv
    source venv/bin/activate
````

Install python dependencies:

````
    pip install -e .
    python setup.py install
````

[Setuptools](https://pypi.python.org/pypi/setuptools) allows to "Easily download, build, install, upgrade, and uninstall Python packages".

`pip install -e .` gets the requirements from setup.py and install them automatically.

*Dev note: If you modify the core of py3dtiles (`py3dtiles/py3dtiles/` subdirectory), you will need to run `pip install -e` before running a script (e.g. export_tileset) for changes to be considered.*

Install the tiler specific dependency:

````
    pip install pyyaml
````

Configure `Tilers/CityTiler/CityTilerDBConfig.yml` (out of `Tilers/CityTiler/CityTilerDBConfigReference.yml`)

From the home directory of the git
    * in order to run the CityTiler
      ```
      python Tilers/CityTiler/CityTiler.py --with_BTH Tilers/CityTiler/CityTilerDBConfig.yml 
      ```
      that (by default) will create a `junk` ouput directory holding both the resulting tile set (with the .json extension) and a folder called `tiles` with `.b3dm` files in it.
      
#### Install a server for streaming 3dtiles tilesets to the client

If you want to run a local server for streaming a 3d-tiles tileset, you can use the node.js based server provided by 3d-tiles: [3d-tiles-samples](https://github.com/AnalyticalGraphicsInc/3d-tiles-samples)

Install:
````
    git clone https://github.com/AnalyticalGraphicsInc/3d-tiles-samples
    cd 3d-tiles-samples
    npm install
    npm start
````

The examples tilesets will then appear as hosted at `http://localhost:8003/tilesets/`

If you want to run a remote server for streaming a 3d-tiles tileset, you can use an Apache server see Step (6) of Install/InstallVilo3D for more informations on how to setup one).

### Client install

#### Install UDV web client and iTowns framework

 Follow the install notes described in https://github.com/MEPP-team/UDV/blob/master/install.md

## Using the above installed client/server

Now that you are done with all necessary installation, you can use these components with 3D or 3D+time data.

### Usecase with 3D data

##### Populate the database

If you followed the install step of 3DCityDB you already have 3D data uploaded into your database. If not, please refer to the end of [these install notes](Install/Install3DCityDB.md).

##### Create a materialized view of your data

In this step you will run `ExtractCityData` tool of `UDV-server`.

`cd UDV-server` and then follow [these instructions](https://github.com/MEPP-team/UDV-server#use).

*Note: run it without the -t option for this usecase*

##### Generate a 3d-tiles tileset

This steps allows to run `export_tileset` tool of py3dtiles component in order to generate a 3d-tiles tileset from the materialized view we just created.
`cd py3dtiles` and edit the `tools/export_tileset_conf.yml` to match your database configuration.

Activate venv and run `export_tileset` tool:
````
    . venv/bin/activate
    python tools/export_tileset -D tools/export_tileset_conf.yml
````

##### Launch a 3d-tiles-samples server for accessing your 3d-tiles tileset

Copy the tileset generated by py3dtiles into 3d-tiles-samples and run the server:
````
    cd path/to/3d-tiles-samples/tilesets
    mkdir 3DTileset
    cd path/to/py3dtiles/
    cp -a tiles/ tileset.json path/to/3d-tiles-samples/tilesets/3DTileset
    cd path/to/3d-tiles-samples/tilesets
    npm start
````

*Note: if you want your node server to be publicly accessible, you need to install install and run an Apache server as explained above.*

Check that your tileset is accessible by opening http://localhost:8003/tilesets/3DTileset/tileset.json in your web browser.

##### Launch UDV client

````
    cd UDV
````

(Optional section)
If you want to use UDV with your local tileset, then edit UDV building-server query: open `UDV/UDV-Core/examples/Demo.js` with your favorite editor and change the line `buildingServerRequest` to be http://localhost:8003/tilesets/3DTileset/tileset.json
(end of optional section)

````
    cd UDV-Core
    npm start
````

Launch your web browser and open http://localhost:8080/examples/Demo.html.

### Usecase with 3D+time data

##### Populate database

Insert 3D+time data to your 3DCityDB database. More information in
[these install notes](Install/Install3DCityDB.md).

##### Create a materialized view of your data

Run `ExtractCityData` tool of UDV-server with -t option:

`cd UDV-server` and then follow [these instructions](https://github.com/MEPP-team/UDV-server#use).

##### Generate a 3d-tiles tileset

This steps allows to run `export_tileset` tool of py3dtiles component in order to generate a 3d-tiles tileset extended for time data from the materialized view we just created.

`cd py3dtiles` and edit the `tools/export_tileset_conf.yml` to match your database configuration.

Activate venv and run `export_tileset` tool
````
    . venv/bin/activate
    python tools/export_tileset -D tools/export_tileset_conf.yml -t
````

##### Launch a 3d-tiles-samples server for accessing your 3d-tiles tileset

Copy the tileset generated by py3dtiles into 3d-tiles-samples and run the server:
````
    cd <path/to/3d-tiles-samples>/tilesets
    mkdir 4DTileset
    cd <path/to/py3dtiles/>
    cp -a tiles tileset.json <path/to/3d-tiles-samples>/tilesets/4DTileset
    cd <path/to/3d-tiles-samples>
    npm start
````

*Note: if you want your node server to be publicly accessible, you need to install install and run an Apache server as explained above.*

Check that your tileset is accessible by opening http://localhost:8003/tilesets/4DTileset/tileset.json in your web browser.

##### Launch UDV client

````
    cd UDV
````

(Optionnal) If you want to use UDV with your local tileset, then edit UDV building-server query:

open `UDV/UDV-Core/examples/Demo.js` with your favorite editor and change the
line `buildingServerRequest` to http://localhost:8003/tilesets/4DTileset/tileset.json

(end optionnal)

````
    cd UDV-Core
    npm start
````

Launch a web browser and open http://localhost:8080/examples/Demo.html .
