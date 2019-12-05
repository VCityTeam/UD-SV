<a name="top"></a>
<img src="Diagrams/ComponentDiagram-macro-components-with-notes.png"
     align=center
     alt="ComponentDiagram-macro-components-with-notes.png" 
     width="600"
     border="0">

## Components (quick) description
### Client side
<a name="ComponentUDV"></a>[Urban Data Viewer (UDV)](https://github.com/MEPP-team/UDV) is a repository gathering [WebGL](https://en.wikipedia.org/wiki/WebGL), [iTowns](https://github.com/iTowns/itowns), javascript components dedicated to Uban Data (respecting the city specific [_CityGML_](http://www.citygml.org/) data model and as such with a 3D geospatial description) visualisation. The UDV sub-components are regrouped in [UDV/UDV-Core](https://github.com/MEPP-team/UDV/tree/master/UDV-Core) and include
 - <a name="ComponentUDVGuidedTour"></a>[UDV/Guided Tour](https://github.com/MEPP-team/UDV/tree/master/UDV-Core/src/Modules/GuidedTour)
 - <a name="ComponentUDVTemporal"></a>[UDV/Temporal](https://github.com/MEPP-team/UDV/tree/master/UDV-Core/src/Modules/Temporal)
 - <a name="ComponentUDVDocuments"></a>[UDV/Documents](https://github.com/MEPP-team/UDV/tree/master/UDV-Core/src/Modules/Documents), [UDV/DocumentComments](https://github.com/MEPP-team/UDV/tree/master/UDV-Core/src/Extensions/DocumentComments), [UDV/DocumentValidation](https://github.com/MEPP-team/UDV/tree/master/UDV-Core/src/Extensions/DocumentValidation)
 - <a name="ComponentUDVContribute"></a>[UDV/Crontibute](https://github.com/MEPP-team/UDV/tree/master/UDV-Core/src/Extensions/Contribute)
 - <a name="ComponentUDVAuthentication"></a>[UDV/Authentication](https://github.com/MEPP-team/UDV/tree/master/UDV-Core/src/Extensions/Authentication)
 - <a name="ComponentUDVLinks"></a>[UDV/Links](https://github.com/MEPP-team/UDV/tree/master/UDV-Core/src/Modules/Links)
 - <a name="ComponentUDVGeocoding"></a>[UDV/Geocoding](https://github.com/MEPP-team/UDV/tree/master/UDV-Core/src/Extensions/Geocoding)

Third party components:<br>
 - [iTowns](https://github.com/iTowns/itowns)
      
### Backend 
 - <a name="ComponentUDS"></a>[Urban Data Server (UDS)](https://github.com/MEPP-team/UDV-server)(aka UDV-Server) is a repository gathering backend support features and utilities
   * <a name="ComponentUDSAPIEnhancedCity"></a>[UDS/API_Enhanced_City](https://github.com/MEPP-team/UDV-server/tree/master/API_Enhanced_City): enables to attach/serve various types of documents to urban data e.g.
     - "Documents" (file and metadata), 
     - Guided tours (sequences of documents with additional texts),
     - User accounts and associated rights,
     - "Links" (between documents and some city objects)
   * [UDS/CityGML2Stripper](https://github.com/MEPP-team/UDV-server/tree/master/Utils/CityGML2Stripper): a utility that strips a CityGML 2.0 (XML) file from its appearences and generic attributes features
   * [UDS/CityGMLBuildingBlender](https://github.com/MEPP-team/UDV-server/tree/master/Utils/CityGMLBuildingBlender): a utility that merges a set of CityGML into a single CityGML resulting file
 - <a name="ComponentUDSCityTilers"></a>[City Tilers](https://github.com/MEPP-team/py3dtiles/tree/Tiler/Tilers/CityTiler): various algorithms computing [3dTiles tilesets](https://github.com/AnalyticalGraphicsInc/3d-tiles) (e.g. [City Temporal Tiler](https://github.com/MEPP-team/py3dtiles/blob/Tiler/Tilers/CityTiler/CityTemporalTiler.py))
 - LibCityProcess: a library [repackaging 3DUse filters](https://github.com/MEPP-team/3DUSE/issues/39) as a separate component
   * <a name="ComponentUDSSplitBuilding"></a>[SplitBuilding](https://github.com/EricBoix/3DUSE/blob/master/src/utils/cmdline/splitCityGMLBuildings.cxx)
   * <a name="ComponentUDSChangeDetection"></a>[ChangeDetection](https://github.com/EricBoix/3DUSE/blob/master/src/utils/cmdline/extractBuildingsConstructionDemolitionDates.cxx)
      
Third party components:<br>

 - <a name="ComponentUDSPy3DTiles"></a>[py3dtiles](https://github.com/MEPP-Team/py3dtiles/) : a fork of [Oslandia's py3dtiles](https://github.com/Oslandia/py3dtiles/) that is a [Python](https://en.wikipedia.org/wiki/Python_(programming_language)) implementation of the [3DTiles data model](https://github.com/AnalyticalGraphicsInc/3d-tiles) the tiled interchange format for city geometrical data.
 - <a name="ComponentUDS3DCityDB"></a>[3DCityDB](https://www.3dcitydb.org/3dcitydb/) (provided by [TUM](https://www.lrg.tum.de/gis/startseite/)): a geographical database based on the CityGML conceptual model
 - <a name="Component3DTilesSamples"></a>[3DTiles samples](https://github.com/AnalyticalGraphicsInc/3d-tiles-samples): a [node.js](https://nodejs.org/en/) based simple file server (by Analytical Graphics Inc) used to web deliver [3dTiles tilesets](https://github.com/AnalyticalGraphicsInc/3d-tiles) (developing context)
 - [Apache](https://en.wikipedia.org/wiki/Apache_HTTP_Server) or [nginx](https://nginx.org/en/) http servers: used to web deliver [3dTiles tilesers](https://github.com/AnalyticalGraphicsInc/3d-tiles) (demo context)
 
Data servers:<br>
  - <a name="data-metropole-lyon-orthophotographie-2009"></a> [Lyon Metropole open data "ortho-photo" (2009)](https://data.beta.grandlyon.com/fr/jeux-de-donnees/orthophotographie-2009-metropole-lyon/donnees): [WMS](https://en.wikipedia.org/wiki/Web_Map_Service), serving e.g. [such request](https://download.data.grandlyon.com/wms/grandlyon?SERVICE=WMS&REQUEST=GetMap&LAYERS=Ortho2009_vue_ensemble_16cm_CC46&VERSION=1.3.0&STYLES=&FORMAT=image/jpeg&TRANSPARENT=false&BBOX=1841306.75,5174961.00,1843030.13,5176364.50&CRS=EPSG:3946&WIDTH=256&HEIGHT=256)
  - <a name="data-metropole-lyon-orthophotographie-2009"></a> [Lyon Metropole open data elevation (2012)](https://data.beta.grandlyon.com/fr/jeux-de-donnees/image-relief-2012-metropole-lyon/donnees): [WMS](https://en.wikipedia.org/wiki/Web_Map_Service), serving e.g. [such request](https://download.data.grandlyon.com/wms/grandlyon?SERVICE=WMS&REQUEST=GetMap&LAYERS=MNT2012_Altitude_10m_CC46&VERSION=1.3.0&STYLES=&FORMAT=image/jpeg&TRANSPARENT=false&BBOX=1843030.13,5176364.50,1844753.50,5177768.00&CRS=EPSG:3946&WIDTH=256&HEIGHT=256)
  - <a name="rict-3dtiles-sample-server-lyon"></a> RICT's 3DTiles samples server: serving e.g. [such request](http://rict.liris.cnrs.fr/DataStore/TileSet_LyonFull_Villeurbanne_Bron_2015/tileset.json)

<img src="Diagrams/ComponentDiagram-macro-components-and-subcomponents.png"
     align=center
     alt="ComponentDiagram-macro-components-and-subcomponents.png"
     width="400"
     border="0">
       
## Historical notes
Here is a list of aging/deprecated components
### Client side
 - [UDV/EarlyPrototype](https://github.com/MEPP-team/UDV/tree/master/EarlyPrototype) holds the first prototype version
 - Vilo3D: refers to an ancient [UDV release tag](https://github.com/MEPP-team/UDV/releases/tag/Vilo3D-Demo-1.0) used in the context of [Vilo3D project](http://imu.universite-lyon.fr/projet/vilo-3d-la-fabrique-urbaine-des-processus-a-leurs-representations-3d/) )
### Backend      
 - [building-server](https://github.com/MEPP-team/building-server/): a fork of [Oslandia's building-server](https://github.com/Oslandia/building-server/) that can be seen as API delivering 3DTiles (build with [py3dtiles](https://github.com/MEPP-Team/py3dtiles/)) and using a pre-computed index.
