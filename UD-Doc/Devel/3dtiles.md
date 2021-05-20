 As stated on [Cesium's introductory page for 3DTiles](https://cesium.com/blog/2015/08/10/introducing-3d-tiles/)
 ```
 3D Tiles are an open specification for streaming massive heterogeneous
 3D geospatial datasets.
 ```

### 3DTiles documentation
A recommended 3DTiles entry point is the [3DTiles overview](https://github.com/CesiumGS/3d-tiles/blob/master/3d-tiles-overview.pdf) (made by Cesium). Note that this documentation assumes that some general notions of geometry/visualization are already known.

When browsing this document first focus on the following salient 3DTiles notions:
  * Bounding volume
  * Geometric error (utile pour les tuiles enfants qui sont des LOD d'une tuile parent)
  * Refinement of a Tile: either replacement or (detail) addition
  * Tile content:
    - Batched 3D model (B3DM), Instanced 3D Model (i3DM), Point Cloud (PC)
    - Composite Tile (one can Mix b3dm and i3DM)
  * Feature table: information concerning globally the Tile 
  * Batched table: information that is attached to each object of the tile
  * Outlook: Visalization Styling
  * Tile format: the header (un JSON: structural and easy to parse) and the body
       (in binary and generally for the geometry)
  * Extensions
  * The relationship between 3DTiles and GLTF (presented as the jpeg for 3D):
     - 3DTiles adds the hierarchy, the combination and the geographic coordinates
     - B3DM tiles usually

#### For more in depth documentation
Refer to the [3DTiles Specifications](https://github.com/CesiumGS/3d-tiles/tree/master/specification) on github, which also contains the official OGC [3D Tiles Specification 1.0](https://github.com/CesiumGS/3d-tiles/blob/master/specification/specification.pdf) document

### 3DTiles samples/example files
  * [3Dtiles samples](https://github.com/CesiumGS/3d-tiles/tree/master/examples)
  * [Cesium sample data](https://github.com/CesiumGS/cesium/tree/master/Apps/SampleData/Cesium3DTiles)
  * [3d-tiles-validator examples](https://github.com/CesiumGS/3d-tiles-validator/tree/master/samples-generator)
  * Checkout [VCity's sample data](https://github.com/VCityTeam/UD-Sample-data/tree/master/3DTiles)

### Tools to authoring/analysing B3dm:
  * Please let us know !
  * py3dTiles: that is able to read 3Dtile-sets using glTF version1, yet
   writes 3DTile-sets using glTF version2
  * Extract a GLTF from B3DM using [tools](https://github.com/CesiumGS/3d-tiles-validator/tree/master/tools#b3dmtoglb) from 3d-tiles-validator 
     
### glTF
Because 3DTiles uses/embeds [flTF](https://en.wikipedia.org/wiki/GlTF), 
you might need at some point to get acquainted with GlTF.
Here are some recommandable readinds/docs
 * [the GLTF overview graphic](https://github.com/KhronosGroup/glTF/blob/master/specification/2.0/figures/gltfOverview-2.0.0b.png)
 * The [full specifications are heavy to read](https://www.khronos.org/gltf/)
 * Format used for Web visualization (and the format hinges on the WebGL visualization library)
 
Tools for authoring/analysing glTF data
 * Check out [GLTF](https://github.com/KhronosGroup/glTF#for-developers)
 * [Gestaltor](https://gestaltor.io/) is a GLTF viewer and editor 
 * [glTF Tools](https://marketplace.visualstudio.com/items?itemName=cesium.gltf-vscode) for Visual Studio Code allows to validate a gltf, create a glb and binary data file, visualize the geometry and look at the buffers 
 


