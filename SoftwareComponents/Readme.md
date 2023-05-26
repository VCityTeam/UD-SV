# Software components used in the UD-SV context

<a name="top"></a>
<img src="Diagrams/ComponentDiagram-macro-components-with-notes.png"
     align=center
     alt="ComponentDiagram-macro-components-with-notes.png"
     width="600"
     border="0">

Main [component diagram](https://www.uml-diagrams.org/component-diagrams.html)

## Visualization (client side)

<a name="ComponentUD-Viz"></a>[Urban Data Vizualisation (UD-Viz)](https://github.com/VCityTeam/UD-Viz)
is an npm (javascript) package based on [iTowns](https://github.com/iTowns/itowns) (in turn based on [ThreeJS](https://threejs.org/)
itself based on [WebGL](https://en.wikipedia.org/wiki/WebGL) dedicated to the visualization of Urban Data).

## Data Processing

- <a name="Componentpy3dtilers"></a>[py3dtilers](https://github.com/VCityTeam/py3dtilers): various algorithms computing [3dTiles tilesets](https://github.com/AnalyticalGraphicsInc/3d-tiles)
- [CityGML2Stripper](https://github.com/VCityTeam/UD-Serv/tree/master/Utils/CityGML2Stripper): a utility that strips a CityGML 2.0 (XML) file from its appearances and generic attributes features
- [CityGMLBuildingBlender](https://github.com/VCityTeam/UD-Serv/tree/master/Utils/CityGMLBuildingBlender): a utility that merges a set of CityGML into a single CityGML resulting file
- LibCityProcess: a library [repackaging 3DUse filters](https://github.com/VCityTeam/3DUSE/issues/39) as a separate component

  - <a name="ComponentUD-ServSplitBuilding"></a>[SplitBuilding](https://github.com/VCityTeam/3DUSE/blob/master/src/utils/cmdline/splitCityGMLBuildings.cxx)
  - <a name="ComponentUD-ServChangeDetection"></a>[ChangeDetection](https://github.com/VCityTeam/3DUSE/blob/master/src/utils/cmdline/extractBuildingsConstructionDemolitionDates.cxx)

Third party components:

- <a name="ComponentUD-ServPy3DTiles"></a>[py3dtiles](https://github.com/VCityTeam/py3dtiles/) : a fork of [Oslandia's py3dtiles](https://github.com/Oslandia/py3dtiles/) that is a [Python](https://en.wikipedia.org/wiki/Python_(programming_language)) implementation of the [3DTiles data model](https://github.com/AnalyticalGraphicsInc/3d-tiles) the tiled interchange format for city geometrical data.

### Data servers (software)

- <a name="ComponentSpatial-Multimedia-DB"></a>[Spatial-Multimedia-DB](https://github.com/VCityTeam/Spatial-Multimedia-DB):
  enables to attach/serve various types of documents to urban data e.g.
  - "Documents" (file and metadata),
  - Guided tours (sequences of documents with additional texts),
  - User accounts and associated rights,
  - "Links" (between documents and some city objects)
- <a name="ComponentUD-Serv3DCityDB"></a>[3DCityDB](https://www.3dcitydb.org/3dcitydb/) (provided by [TUM](https://www.lrg.tum.de/gis/startseite/)): a geographical database based on the CityGML conceptual model
- <a name="ComponentUD-SimpleServer"></a>[UD-SimpleServer](https://github.com/VCityTeam/UD-SimpleServer): a [node.js](https://nodejs.org/en/) based simple file server (used to serv JS client code/assets)
- <a name="Component3DTilesSamples"></a>[3DTiles samples](https://github.com/AnalyticalGraphicsInc/3d-tiles-samples): a [node.js](https://nodejs.org/en/) based simple file server (provide by by [Analytical Graphics Inc](https://github.com/AnalyticalGraphicsInc)) used to web deliver [3dTiles tilesets](https://github.com/AnalyticalGraphicsInc/3d-tiles) (developing context)
- [Apache](https://en.wikipedia.org/wiki/Apache_HTTP_Server) or [nginx](https://nginx.org/en/) http servers: used to web deliver [3dTiles tilesets](https://github.com/AnalyticalGraphicsInc/3d-tiles) (demo context)

<img src="Diagrams/ComponentDiagram-macro-components-and-subcomponents.png"
     align=center
     alt="ComponentDiagram-macro-components-and-subcomponents.png"
     width="400"
     border="0">
