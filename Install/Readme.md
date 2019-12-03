## Introduction: how to install demos out of their integrated components
The [RICT web based online demos](http://rict.liris.cnrs.fr/index.html) regroup a set of specific demos that illustrate various visualizations/applications on top city related data. Each such demo is achieved by integrating some ad-hoc subset of [free and open available software components](../Doc/Devel/Architecture/Components.md) (refer to the [architecture](../Doc/Devel/Architecture/Readme.md)).

The following documentation considers each specific demo and for each one explains
  - **which required components** should be installed**: **don't install all the components** but stick to the _SUBSET_ required for the demo you are trying to replicate (taken among [all the available components](../Doc/Devel/Architecture/Components.d)
  - **how to install such components** and
  - **how to assemble/integrate such components** in order to obtain a fully functionnal demo

Once your chosen demo is installed feel free to experiment with it, extend it and/or customize it to suit your needs. 


## Installing components 
 * Frontend 
[UDV](../Doc/Devel/Architecture/Components.md#ComponentUDV) web client: [install notes](https://github.com/MEPP-team/UDV/blob/master/install.md) ([associated demos](http://rict.liris.cnrs.fr/UDVDemo-2/UDV/UDV-Core/))
 * Backend
   - [3DCityDB](../Doc/Devel/Architecture/Components.md#ComponentUDS3DCityDB): [install notes](Install3DCityDB.md#top).
   - [CityTiler](../Doc/Devel/Architecture/Components.md#ComponentUDSCityTiler): [install notes](https://github.com/MEPP-team/py3dtiles/blob/Tiler/Tilers/CityTiler/Install.md) 
   - [UDS/API_Enhanced_City](../Doc/Devel/Architecture/Components.md#ComponentUDSAPIEnhancedCity): [install notes](https://github.com/MEPP-team/UDV-server/blob/master/API_Enhanced_City/INSTALL.md) 
   - [3DTiles Samples](../Doc/Devel/Architecture/Components.md#Component3DTilesSamples)(server): [DESKTOP developing context install notes](Install3dTilesNodeBasedWebServer.md) or [OPERATIONS (stable server) context install notes](InstallDebianApacheServer.md) ([Apache](https://en.wikipedia.org/wiki/Apache_HTTP_Server) http server based but you can use [Nginx](https://nginx.org/en/).

## Installing demos
 * Computing 3DTiles tilesets and web visualize them: [installation notes](Install/InstallDemo3dTilesLyonViewer.md
 * [TBD](https://en.wikipedia.org/wiki/TBD_(disambiguation)) How to install (document) Enhanced City demo





### How to compute 3DTiles TEMPORAL tileset and web visualize it
Refer to the [installation notes](Install/InstallDemo3dTilesTemporalLyonViewer.md) 

