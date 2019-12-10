The following are early (2017 and beginning of 2018) design notes for [need 18](../Needs/Need018.md).
These notes should be considered deprecated since the context evolved and they are no longer relevant.

## General informations

### Related software components

This need will be answered by modifying Oslandia's [building-server](https://github.com/Oslandia/building-server) and [py3dtiles](https://github.com/Oslandia/py3dtiles) components. We will first work on the forks of MEPP-Team organization of these components.

The current process for streaming the geometries to the server is:
* building-server receive a request from the client
* building-server fetches the requested geometries from the database
* building-server creates a [3d-tiles](https://github.com/AnalyticalGraphicsInc/3d-tiles) tileset
* py3dtiles creates each tile of the tileset

### Useful information about 3d-tiles and b3dm

In the 3d-tiles standard, a tile can represent different type of geometries and be in different formats (more information [here](https://github.com/AnalyticalGraphicsInc/3d-tiles#spec-status)). In our application, we mainly need stream geometries that will be converted into [Batched 3D Model](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/Batched3DModel/README.md) (*.b3dm) files to form tiles. Thus, we first focus on this format for adding the identifier of the geometries in the tiles. 

Important information from the [b3dm doc](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/Batched3DModel/README.md):

* [b3dm Layout](https://github.com/AnalyticalGraphicsInc/3d-tiles/tree/master/TileFormats/Batched3DModel#layout)
* Each geometry has a batchId attribute in the glTF section of the b3dm file which is an integer with values in [0, number of models in the batch - 1]. Here model is the same as what we call "geometry" in this document (it is also called "feature" in a b3dm file).
* Each b3dm file has a [batch table](https://github.com/AnalyticalGraphicsInc/3d-tiles/tree/master/TileFormats/Batched3DModel#batch-table) which contains per-model application-specific metadata, indexable by batchId.

We thus propose to use this batch table to stream the identifier of the geometries of the database from the database server to the client.

Additional documentation about the batch table can be found [here](https://github.com/AnalyticalGraphicsInc/3d-tiles/tree/master/TileFormats/BatchTable).

This documentation teaches us that:

* b3dm is not the only format using a batch table. There is also [Instanced 3D Model](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/Instanced3DModel/README.md) (i3dm), [Point Cloud](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/PointCloud/README.md) (pnts) and [Vector](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/VectorData/README.md) (vctr) which are formats supported by 3d-tiles standard. Using the batch table to transfer information linked to the geometry is thus not format dependant.

* [Different ways to use the batch table](https://github.com/AnalyticalGraphicsInc/3d-tiles/tree/master/TileFormats/BatchTable#layout). 

* There is an example with what we want to do (transfer an id). Related to design note 17, there is also examples with temporal information streamed this way. In [this example](https://github.com/AnalyticalGraphicsInc/3d-tiles/tree/master/TileFormats/BatchTable#json-header) it seems possible to stream a lot of semantic information which could be another way of doing this step: instead of only streaming the id of the geometries, we could stream all the semantic information in this batched table which would avoid more queries on the server. This is a design choice that needs to be discussed (maybe with JGA ?). How do other applications using 3d-tiles do ?

* There is the possibility of creating a [hierarchy in the metadata of the batch table](https://github.com/AnalyticalGraphicsInc/3d-tiles/tree/master/TileFormats/BatchTable#json-header) for complex cases. This might be useful in our case ?

## Proposition and Discussions

In order to provide access to semantic and hierarchical information of cityobjects client-side, there are two choices:
  * __Solution n°1:__ We transfer the id of the geometries of the database in the batch table, we store it on the client side and when some semantic or hierarchical information is needed on the client-side, we run queries in the database using this id.
  * __Solution n°2:__ We transfer all the semantic and hierarchical information of city objects to the client by using the method described in [Schi16] and we store it in the client so we don't have to run queries every time we need semantic or hierarchical information.
  
### Solution n°1 description:

If we choose this solution, we need to:

1. Modify the API of building-server in order to get the identifier of the geometries when fetching them.
2. Modify py3dtiles to add this identifier next to the geometries.
3. Modify the API of building-server to provide methods to retrieve semantic information from a list of geometries' ids.   

### Solution n°2 description:
1. Modify the API of building-server: when a geometry is requested add the ability to retrieve
   * the back-link to 3DCityDB (just as for solution 1): the identifier of the geometry within the 3DCityDB database
   * the hierachical information: the identifier of its parent within the geometrical hierarchy (the id is still the one the 3DCityDB)
2. Modify py3dtiles to add this identifier **together with the hierachical identifier** asside to the geometries
3. Nothing ! This is precisely what is avoided by pre-sending all the required information to the client

Note:
  - On step 2., when sending the hierarchical information, there is the additional difficulty of having to represent semantic nodes (e.g. Building) for which the geometry is not present but defined as the sum of the geometries of its semantic sub-nodes (Wall, Roof). Note that [Schi16] uses the trick of extending the Batch Table beyond the number of Geometric batches in order to store entries without geometries. An alternative is to defined such nodes as having a batch id but an empty (null) geometry.
     
     
### Inputs for choosing between the two solutions:

 There is the technical freedom to leave any information associated to a geometry within the server (hierarchy, attributes, ADE...) or to transmsit it to the client. 
 
   * Is there additionnal criteria enabling to make a decision concerning the "optimal" tradeof ? Are there:
     * some use cases that will add some criteria ? (note that the experimental handling of hierarchies as done in [Schi16] does not add any constraint: when queried about a hierarchy of a geometrical object, we can request this hierarchy from the server)
     * some communication constraints ? (the server sends the information once and no further request shall be made)
     * some delay constraints ? (having to handle server querries when dealing with end-user interaction would introduce a delay that is not compatible with the expected fluidity of contemporary GUI)
     * ...
  * Search for feedback regarding the proposition of Schilling et al. in [Schi16]. (maybe from the 3d-tiles community or in other articles citing it).
  * Search for general criteria of decision in similar problems.
  * How does NSA manage the picking of one building or one roof or one wall from a tile ? [video](https://sendvid.com/9cl7253z#)
In order to do that, in each tile, every building has a batch_id. This is done on the server when building the tiles. Client-side, three.js propose a gltf loader function. However, it does not implement the functionnality to retrieve the batch_id from a gltf file. This functionnality has been added by NSA in iTowns and JGA asked three.js to add it to their gltf loader. After parsing the gltf file, a three.js object containing the b3dm + batch_ids + gltf information is created (and this object is potentially linked to the tile of the tileset stored client side). Then, when the user picks something in the scene, the batch_ids are transmistted to the shaders next to the geometries and a test allow to know all the triangles having the same batch_id as the one selected.
  * Look if other people had the same problem and justified their choices

In conclusion, the choice between the two solutions is linked to thick-client vs thin-client server strategy. What we need to do next is to clearly define the use of the semantic information client-side. This will allow to choose if we need to send all the information to the client or if we should leave it in the database.

Another remaining question is how to transfer the hierarchical information to the client. This is currently difficult using 3d-tiles as explained in [Schi16]. Indeed, the semantic information can easily transfered using the attributes of b3dm but there is nothing yet that is implemented to efficiently transfer the hierarchy of city objects. [Schi16] make a proposition but what are the feedbacks from the 3d-tiles comunity and how is it done in other applications ?

### Notes (04/01/2018):

* A solution seems to be proposed [here](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/BatchTable/README.md)
* There is elements in the 3DCityDB documentation as well about how the hierarchy and the semantic are stored (especially in the part dealing with the database model).
* Currently, before running py3dtiles we preprocess the database in order to output a materialized view containing the ids, geometries and dates of the features of interrest. We only do it on buildings currently as they are the only ones having temporal informations. If other city objects have temporal information, we can extend it to all city objects. However, problems will arise when we will want to handle different type of city objects and their semantic attributes: they won't all have the same semantic informations so outputing the results in only one table will be problematic. Possible solutions: 
    * Create a table containing semantic information for each type of city object
    * Add a column `semantic` containing an array or a list encoded in a string
More problem will come when we will want to add the hierarchical information of city objects. In addition, 3DCityDB allows to store all these information quite well so we don't need to do it again... I think a better way would be to get back to the "on the fly" calculation of the 3d-tiles tileset or to interface py3dtiles with 3DCityDB.

### Notes on the 22/03/18

To answer this need, one needs to:
  * Change the [ExtractCityData script](https://github.com/MEPP-team/UD-Serv/tree/master/ExtractCityData) of UD-Viz server to extract semantic and hierarchy between city objects informations from the database into the view
  * Modify [Py3DTiles](https://github.com/MEPP-team/py3dtiles) to include these semantic and hierarchy information into 3D Tiles, following the method proposed by (Schilling et al, 2016)
  * Modify iTowns/UD-Viz to 
     * Read these information from Py3DTiles
     * Provides GUI means to select city objects (e.g. building, wall, roof) and see their attributes 
     
### Work during iTowns code sprint (27/03/2018)

Client side modifications to read a hierarchical batch table and display hierarchy and properties: https://github.com/iTowns/itowns/tree/batch_table_hierarchy . Not tested yet; waiting for a test tileset.

## References

[Schi16] Schilling, A., Bolling, J., & Nagel, C. (2016, July). Using glTF for streaming CityGML 3D city models. In Proceedings of the 21st International Conference on Web3D Technology (pp. 109-116). ACM.
