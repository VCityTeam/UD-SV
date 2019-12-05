## How to install demos out of their integrated components<a name="top"></a>
The [RICT web based online demos](http://rict.liris.cnrs.fr/index.html) regroup a set of specific demos that illustrate various visualizations/applications on top city related data. Each such demo is achieved by integrating some ad-hoc subset of [free and open available software components](../Doc/Devel/Architecture/Components.md) (refer to the [architecture](../Doc/Devel/Architecture/Readme.md)).

The following documentation considers each specific demo and for each one explains
  - **which required components** should be installed: **don't install all the components** but stick to the _SUBSET_ required for the demo you are trying to replicate (taken among [all the available components](../Doc/Devel/Architecture/Components.md))
  - **how to install such components** and
  - **how to assemble/integrate such components** in order to obtain a fully functionnal demo

Once your chosen demo is installed feel free to experiment with it, extend it and/or customize it to suit your needs.

## Installing demos
### <a name="install-demo-udv-front-end"></a>[UDV front end](../Doc/Devel/Architecture/Components.md#ComponentUDV) (and no back end component)
 * What you get: something similar to [this demo of the UDV front end](http://rict.liris.cnrs.fr/UDVDemo/UDV/UDV-Core/examples/DemoFull/Demo.html) that illustrates enables you to discover the front end features (e.g. [UDV/Geocoding](../Doc/Devel/Architecture/Components.md#ComponentUDVGeocoding)). However, because you are not (yet) installing any of server-side components, you will **not** be able to use the features requiring some server-side document management (e.g. [Guided Tour](../Doc/Devel/Architecture/Components.md#ComponentUDVGuidedTour) or [Authentication](./Doc/Devel/Architecture/Components.md#ComponentUDVAuthentication)).
  * [Installation notes](https://github.com/MEPP-team/UDV/blob/master/install.md)
  
### UDV (front end) together with [UDS/API_Enhanced_City](../Doc/Devel/Architecture/Components.md#ComponentUDSAPIEnhancedCity) (back-end)
 * What you get: you can [run demo this demo](http://rict.liris.cnrs.fr/UDVDemo/UDV/UDV-Core/examples/DemoFull/Demo.html) on your desktop
 * Installation: first [install UDV front end](#install-demo-udv-front-end") and then 

Once you have run the UDV demos, you can now follow [the UDV-server/API_Enhanced_City install notes](https://github.com/MEPP-team/RICT/blob/master/Install.md#backend-udv-serverapi_enhanced_city-install-notes) that enable you to install one of the server-side components on your computer. 
You will then be able to run the full client-side/server-side demo locally (on your computer) as opposed to the previous stage where only the client-side was deployed locally (and the the server side was running on the laboratory remote server).

The server-side component contains a [PostGreSQL](https://en.wikipedia.org/wiki/PostgreSQL) and is only required if you want to be able to access to _all_ the features of the app and then run the full demo of UDV.
Indeed, the features provided by this component are _Consult documentation, Guided Tour, Authentification, Documents to validate and Document Links._ [This file](https://github.com/MEPP-team/UDV-server/blob/master/API_Enhanced_City/doc/OpenAPI2/swagger.yaml) provides the technical specification of the API following the standard [Open API 2](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/2.0.md).

The server-side component contains a [PostGreSQL](https://en.wikipedia.org/wiki/PostgreSQL)  database used for some functionalities of the web app.

### Computing 3DTiles tilesets and web visualize them: 
[installation notes](Install/InstallDemo3dTilesLyonViewer.md)
### Computing 3DTiles **temporal** tilesets and web visualize them:
[installation notes](Install/InstallDemo3dTilesTemporalLyonViewer.md)
### [TBD](https://en.wikipedia.org/wiki/TBD_(disambiguation))
How to install (document) Enhanced City demo

## Installing components 
 * Frontend 
   - [UDV](../Doc/Devel/Architecture/Components.md#ComponentUDV) web client: [install notes](https://github.com/MEPP-team/UDV/blob/master/install.md) ([associated demos](http://rict.liris.cnrs.fr/UDVDemo-2/UDV/UDV-Core/))
 * Backend
   - [3DCityDB](../Doc/Devel/Architecture/Components.md#ComponentUDS3DCityDB): [install notes](Install3DCityDB.md#top).
   - [CityTiler](../Doc/Devel/Architecture/Components.md#ComponentUDSCityTiler): [install notes](https://github.com/MEPP-team/py3dtiles/blob/Tiler/Tilers/CityTiler/Install.md) 
   - [UDS/API_Enhanced_City](../Doc/Devel/Architecture/Components.md#ComponentUDSAPIEnhancedCity): [install notes](https://github.com/MEPP-team/UDV-server/blob/master/API_Enhanced_City/INSTALL.md) 
   - [3DTiles Samples](../Doc/Devel/Architecture/Components.md#Component3DTilesSamples)(server): [DESKTOP developing context install notes](Install3dTilesNodeBasedWebServer.md) or [OPERATIONS (stable server) context install notes](InstallDebianApacheServer.md) ([Apache](https://en.wikipedia.org/wiki/Apache_HTTP_Server) http server based install notes).

