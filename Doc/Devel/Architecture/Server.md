# Server Architecture 

The server is currently (09/2017) composed of two components ([building-server](https://github.com/MEPP-Team/building-server) and [py3dtiles](https://github.com/MEPP-team/py3dtiles).

The current organisation with these two components will change as explained [here](https://github.com/MEPP-team/RICT/wiki/2017_10_09_-_Building_server_revolution). In brief, it will be separated in two distinct parts:
   * One static version (Bs-py3dtiles) which is a script containing py3dtiles + non dynamic building-server features. This version will allow to generate a 3dtiles tileset.json and the associated b3dm files from data in a DB.
   * One dynamic version (BSV2) which keeps the dynamic parts of the current building-server plus some new features which makes use of the dynamic possibility of the server. This BSV2 will use current py3dtiles features and construct the tileset and b3dm files on the fly when asked by the client.

Independantly from building-server and py3dtiles, a new component called libCityProcess will be created. It will contain the processes (filters) of our application. (e.g. [this filter](https://github.com/MEPP-team/RICT/issues/30)).

## Building-server

### Services

Building-server is composed of the following services:

  * __ProcessDB:__
    * Ins:
      * A configuration file containing a list of cities and some related information: name of the city, three output tables names (tile: contains the tiles and their bounding boxes, hierarchytable: contains the hierarchy of the tiles, featuretable: matches the features (i.e. the geometries) to the tiles), the name of the table containing the geometries (geometrytable), the extent of the data set, the max size of a tile in meters (square tiles), the srs (spatial reference system) and the number of features per tile.
    * Outs:
      * Three new tables (specified in inputs) containing the tiles, their hierarchy and the features they contains. Basically it is a representation in the DB of a 3dtiles tileset constructed from the geometries of the DB. 
  * __GetCity:__
    * Ins: 
      * City Name: reffers to a city in the database.
      * Format (optionnal): format of the tiles of the returned tileset. Default value is "b3dm".
    * Outs: 
      * A 3d-tiles tileset: Only contains the tiled hierarchy representing the city but not the geometry of the city. The tileset is a json file.

  * __GetGeometry:__
    * Ins: 
      * City Name: reffers to a city in the database.
      * Tile: tile identifier contained in the tileset.
      * Attributes (optionnal): an attribute linked to a geometry and to be retrieved from the DB along with the geometry. Only works when format value is geojson.
      * Format (optionnal): Format of the returned tile's geometries. Default value is "b3dm". Possible values: geojson, b3dm.
    * Outs: 
      * A file in input format containing the geometry of the input tile and optionnaly its linked attributes.
      
  * __GetCities:__
    * Ins: None
    * Outs: json file listing the cities and their attributes from the configuration file of the server.
    
  * __GetAttribute:__



