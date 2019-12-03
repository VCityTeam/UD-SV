## Installation notes for Unix users

## For the impatient
 Links to demo install guides (using some components listed below)
 * [How to compute 3DTiles tileset and web visualize it](#how-to-compute-3dtiles-tileset-and-web-visualize-it)
 * [How to compute 3DTiles TEMPORAL tileset and web visualize it](#how-to-compute-3dtiles-temporal-tileset-and-web-visualize-it)
 
Links to components installation notes
 * Frontend 
[UDV](../Doc/Devel/Architecture/Components.md#ComponentUDV) web client: [install notes](https://github.com/MEPP-team/UDV/blob/master/install.md) ([associated demos](http://rict.liris.cnrs.fr/UDVDemo-2/UDV/UDV-Core/))
 * Backend
   - [3DCityDB](../Doc/Devel/Architecture/Components.md#ComponentUDS3DCityDB): [install notes](Install3DCityDB.md#top).
   - [CityTiler](../Doc/Devel/Architecture/Components.md#ComponentUDSCityTiler): [install notes](https://github.com/MEPP-team/py3dtiles/blob/Tiler/Tilers/CityTiler/Install.md) 
   - [UDS/API_Enhanced_City](../Doc/Devel/Architecture/Components.md#ComponentUDSAPIEnhancedCity): [install notes](https://github.com/MEPP-team/UDV-server/blob/master/API_Enhanced_City/INSTALL.md) 
   - [3DTiles Samples](../Doc/Devel/Architecture/Components.md#Component3DTilesSamples)(server): [DESKTOP developing context install notes](Install3dTilesNodeBasedWebServer.md) or [OPERATIONS (stable server) context install notes](InstallDebianApacheServer.md) ([Apache](https://en.wikipedia.org/wiki/Apache_HTTP_Server) http server based but you can use [Nginx](https://nginx.org/en/).

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

