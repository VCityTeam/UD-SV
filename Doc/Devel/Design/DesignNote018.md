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
2. Modify py3dtiles to add this identifier next to the geometries

### Modifification of the API of building-server



#### Modification of py3dtiles

In the 3d-tiles standard, a tile can represent different type of geometries and be in different formats (more information [here](https://github.com/AnalyticalGraphicsInc/3d-tiles#spec-status)). In our application, we mainly need stream geometries that will be converted into [Batched 3D Model](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/Batched3DModel/README.md) (*.b3dm) files to form tiles. Thus, we will only modify the creation of b3dm tiles for adding the identifier of the geometries in the tiles for now. We will deal with the other tiles formats later if needed.

Important information from the [b3dm doc](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/Batched3DModel/README.md):

* [b3dm Layout](https://github.com/AnalyticalGraphicsInc/3d-tiles/tree/master/TileFormats/Batched3DModel#layout)
* Each geometry has a batchId attribute in the glTF section of the b3dm file which is an integer with values in [0, number of models in the batch - 1]. It is not very clear what "model" means here but it seems to be the same as what we call "geometry" in this document.
* Each b3dm file has a [batch table](https://github.com/AnalyticalGraphicsInc/3d-tiles/tree/master/TileFormats/Batched3DModel#batch-table) which contains per-model application-specific metadata, indexable by batchId.

We thus propose to put the identifier of the geometries from the database in this batch table.





