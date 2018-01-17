# iTowns related documentation

This documents centralise documentation about iTowns produced by VCity team.

## iTowns internal organisation of 3d tiles data

iTowns supports [3d-tiles](https://github.com/AnalyticalGraphicsInc/3d-tiles).
It is possible to add a layer which contains 3d-tiles data. A 3d-tiles tileset
contains tiles which can have other tiles as children and which can point to data
in different format such as b3dm, i3dm, pnts, etc.).

Here we will only discuss the organisation within iTowns of a 3d-tiles tileset
which contains data in [b3dm](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/Batched3DModel/README.md)
format. Note that a b3dm file contains a [glTF](https://github.com/KhronosGroup/glTF) file.

The organisation is as follow:
 * There is a root which englobes the tileset and which is defined as an `Object3D`. [Object3D](https://threejs.org/docs/#api/core/Object3D) is a threejs class.
 * This root has children which are tiles and are also defined as `Object3D`.
 * Each tile can have:
    * A [batch table](https://github.com/AnalyticalGraphicsInc/3d-tiles/tree/master/TileFormats/BatchTable)
    * Several attributes (defined in 3d-tiles and b3dm documentation or specific
    to iTowns)
    * Other tiles as children (hence also defined as `Object3D`)
    * A glTF file which contains the features of the tiles. The organisation of a
    glTF file follows
    [this scheme](https://github.com/KhronosGroup/glTF/blob/master/specification/1.0/figures/dictionary-objects.png).
    The glTF file is loaded using the glTFLoader of threejs and is represented in
    iTowns by:
        * a `Scene` object of threejs which represents the scene of the glTF file.
        * one or multiple `Object3D` which represents one or multiple nodes of the
        glTF file.
        * a `Mesh` object of threejs which represents the mesh of the glTF file.       

Currently, the only way to know if an `Object3D` is a tile is by checking if it
has a `layer` attribute.

## Concerning the initialization/update of a layer data
[iTowns main loop](https://github.com/iTowns/itowns/blob/master/src/Core/MainLoop.js) deals/echanges (possibly indirectly) with the data of a layer with the following sequence of calls:
 * Initialization of the data set: `preprocessDataLayer` (e.g. the [preprocessDataLayer for 3DTiles](https://github.com/iTowns/itowns/blob/master/src/Core/Scheduler/Providers/3dTiles_Provider.js#L78)) that is 
    - defined within a Provider 
    - called only once per layer
    - pulls the data (e.g. a 3DTiles pointed to by some URL)
 * Initialization of the update mechanism: `pre-update()` 
    - called at each step of the Itowns engine (i.e. each time the screen must be refreshed)
    - acts at the level of the layer
    - technically defined as a callback 
 * Updating of the elements of a layer: `update()`  
    - each element of the layer (e.g. tiles of the geometry layer) must present an `update()` method 
    - `update()` realizes the update of the considered element and optionnaly returns all the children objects that must also be updated 
    - [Mainloop.js](https://github.com/iTowns/itowns/blob/master/src/Core/MainLoop.js) implements a recursion for updating the elements of a layer:
      - Mainloop.js calls `update()` on the gateway element of the layer, 
      - Mainloop.js collects the returned elements (in need of update) and in turn,
      - it calls `update()` on such returned elementss until the list of elements in need of update is empty
    - `update()` is technically defined as a callback    

Notes: 
  * layers linked to other layers only define their `update()` callback (i.e. they a devoid of `pre-update()`)
  * `preprocessDataLayer` parses the 3d-tiles' tiles in the function `$3dTilesIndex` which is called when creating the tileIndex of the layer. In `$3dTilesIndex`, the tile's attributes are parsed and especially the bounding volume attribute is parsed using the `getBox` function in which we added a switch allowing to parse the start_date and end_date of the tile when the layer is configured with `TemporalExtension=true` (see [this commit](https://github.com/jailln/itowns/commit/4ed8cd7e27d9af50e3a9c2b600f0371122b5f042))
  * `layer.whenReady` allows to now when a layer is configured and ready to be used
  
