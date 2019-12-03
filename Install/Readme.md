## Installation notes for Unix users

## For the impatient
 Links to demo install guides (using some components listed below)
 * [How to compute 3DTiles tileset and web visualize it](#how-to-compute-3dtiles-tileset-and-web-visualize-it)
 * [How to compute 3DTiles TEMPORAL tileset and web visualize it](#how-to-compute-3dtiles-temporal-tileset-and-web-visualize-it)
 
Links to components installation notes
 * Frontend 
[UDV](../Doc/Devel/Architecture/Components.md#ComponentUDV) web client: [install notes](https://github.com/MEPP-team/UDV/blob/master/install.md)([associated demos](http://rict.liris.cnrs.fr/UDVDemo-2/UDV/UDV-Core/))
 * Backend
   - [3DCityDB](../Doc/Devel/Architecture/Components.md#ComponentUDS3DCityDB): [install notes](Install3DCityDB.md).
   - [CityTiler](../Doc/Devel/Architecture/Components.md#ComponentUDSCityTiler): [install notes](https://github.com/MEPP-team/py3dtiles/blob/Tiler/Tilers/CityTiler/Install.md) 
   - [UDS/API_Enhanced_City](../Doc/Devel/Architecture/Components.md#ComponentUDSAPIEnhancedCity): [install notes](https://github.com/MEPP-team/UDV-server/blob/master/API_Enhanced_City/INSTALL.md) 
  
 
 *WIP
   * [(Backend) UDV-server/API_Enhanced_City install notes](#backend-udv-serverapi_enhanced_city-install-notes)
   * [(Backend) CityTiler install notes](#backend-citytiler-install-notes)
   * [(Backend) 3dtiles web server: DESKTOP developing context](#backend-3dtiles-web-server-desktop-developing-context)
   * [(Backend) 3dtiles web server: OPERATIONS (stable server) context](#backend-3dtiles-web-server-operations-stable-server-context)
  
## General description
RICT offers a [set of web based online demos](http://rict.liris.cnrs.fr/UDVDemo-2/UDV/UDV-Core/) that illustrate various visualizations/applications on top city related data. Each such demo is achieved by quickly integrating some of the [free and open available software components](Doc/Devel/Architecture#components-names) (front or backend sides). The general architectural diagram goes (refer to the [architecture section](Doc/Devel/Architecture) for further details)

![](Install/Images/FourTierArchitectureRICT.png)

The [RICT web based online demos](http://rict.liris.cnrs.fr/index.html) regroup a set of specific demos each of which being based on a subset of shared components. The following documentation explains how to install each specific demo that is **how to install the respective required components** and **how to assemble/integrate such components** in order to obtain a fully functionnal demo
 * [How to compute 3DTiles tileset and web visualize it](#how-to-compute-3dtiles-tileset-and-web-visualize-it)
 * [How to compute 3DTiles TEMPORAL tileset and web visualize it](#how-to-compute-3dtiles-temporal-tileset-and-web-visualize-it)
 * [TBD](https://en.wikipedia.org/wiki/TBD_(disambiguation)) How to install (document) Enhanced City demo

Warning: please notice that each demo you are trying to replicate (that you can then extend and customize to suit your needs) **only requires a SUBSET of [all components](#component-quick-description)**.

## Integrated demos based on following components

### How to compute 3DTiles tileset and web visualize it
Refer to the [installation notes](Install/InstallDemo3dTilesLyonViewer.md)

### How to compute 3DTiles TEMPORAL tileset and web visualize it
Refer to the [installation notes](Install/InstallDemo3dTilesTemporalLyonViewer.md) 

## Component quick description
      
### (Backend) 3dtiles web server: DESKTOP developing context
In the context of development and if you need to handle over [3DTiles tilesets](https://github.com/AnalyticalGraphicsInc/3d-tiles) for your client to display then you can deploy a local (on your desktop computer) web server (the [node.js](https://nodejs.org/en/) based [3d-tiles-samples](https://github.com/AnalyticalGraphicsInc/3d-tiles-samples)): follow [these install notes](Install/Install3dTilesNodeBasedWebServer.md).

### (Backend) 3dtiles web server: OPERATIONS (stable server) context
In case you want to run a remote and stable web server (as opposed to the above described desktop deployment option) in order to handle over your [3DTiles tilesets](https://github.com/AnalyticalGraphicsInc/3d-tiles) you can use an [Apache](https://en.wikipedia.org/wiki/Apache_HTTP_Server) or an [Nginx](https://nginx.org/en/) http server.

In the [RICT](..) context, you can [quickly deploy an Apache web server on Debian](InstallDebianApacheServer.md).
