## Design note of [need 18](https://github.com/MEPP-team/RICT/blob/master/Doc/Devel/Needs/Need018.md)

### General process

This need will be answered by modifying Oslandia's [building-server](https://github.com/Oslandia/building-server) and [py3dtiles](https://github.com/Oslandia/py3dtiles) components. We will first work on the forks of MEPP-Team organization of these components.

We want to be provide a way of accessing semantic information linked to the geometries of the city objectcs on the client-side. In order to do so, we could stream all this information to the client along with the geometries. We choose not to do that because it would slow down a lot the streaming to the web client. Instead, we choose to stream an identifier of each geometry in the database in order to be able to retrieve all needed semantic information from the database when needed. This also allows us to get only the semantic information needed when some are and not all of them.

The current process for streaming the geometries to the server is:
* building-server receive a request from the client
* building-server fetches the requested geometries from the database
* building-server creates a [3d-tiles](https://github.com/AnalyticalGraphicsInc/3d-tiles) tileset
* py3dtiles creates each tile of the tileset

We thus need to:

1. Modify the API of building-server in order to get the identifier of the geometries when fetching them.
2. Modify py3dtiles to add this identifier next to the geometries.
3. Modify the API of building-server to provide methods to retrieve semantic information from a list of geometries' ids.

We will detail these 3 steps below

### 1. First modifification of the API of building-server 



### 2. Modification of py3dtiles

In the 3d-tiles standard, a tile can represent different type of geometries and be in different formats (more information [here](https://github.com/AnalyticalGraphicsInc/3d-tiles#spec-status)). In our application, we mainly need stream geometries that will be converted into [Batched 3D Model](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/Batched3DModel/README.md) (*.b3dm) files to form tiles. Thus, we first focus on this format for adding the identifier of the geometries in the tiles. 

Important information from the [b3dm doc](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/Batched3DModel/README.md):

* [b3dm Layout](https://github.com/AnalyticalGraphicsInc/3d-tiles/tree/master/TileFormats/Batched3DModel#layout)
* Each geometry has a batchId attribute in the glTF section of the b3dm file which is an integer with values in [0, number of models in the batch - 1]. Here model is the same as what we call "geometry" in this document (it is also called "feature" in a b3dm file).
* Each b3dm file has a [batch table](https://github.com/AnalyticalGraphicsInc/3d-tiles/tree/master/TileFormats/Batched3DModel#batch-table) which contains per-model application-specific metadata, indexable by batchId.

We thus propose to use this batch table to stream the identifier of the geometries from the database to the client.

Additional documentation about the batch table can be found [here](https://github.com/AnalyticalGraphicsInc/3d-tiles/tree/master/TileFormats/BatchTable).

This documentation teaches us that:

* b3dm is not the only format using a batch table. There is also [Instanced 3D Model](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/Instanced3DModel/README.md) (i3dm), [Point Cloud](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/PointCloud/README.md) (pnts) and [Vector](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/VectorData/README.md) (vctr) which are formats supported by 3d-tiles standard. Using the batch table to transfer information linked to the geometry is thus not format dependant.

* [Different ways to use the batch table](https://github.com/AnalyticalGraphicsInc/3d-tiles/tree/master/TileFormats/BatchTable#layout). 

* There is an example with what we want to do (transfer an id). Related to design note 17, there is also examples with temporal information streamed this way. In [this example](https://github.com/AnalyticalGraphicsInc/3d-tiles/tree/master/TileFormats/BatchTable#json-header) it seems possible to stream a lot of semantic information which could be another way of doing this step: instead of only streaming the id of the geometries, we could stream all the semantic information in this batched table which would avoid more queries on the server. This is a design choice that needs to be discussed (maybe with JGA ?). How do other applications using 3d-tiles do ?

* There is the possibility of creating a [hierarchy in the metadata of the batch table](https://github.com/AnalyticalGraphicsInc/3d-tiles/tree/master/TileFormats/BatchTable#json-header) for complex cases. This might be useful in our case ?

### 3. Second Modification of the API of building-server 


