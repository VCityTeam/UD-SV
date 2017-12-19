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
