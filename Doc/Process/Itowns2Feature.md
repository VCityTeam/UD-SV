![](http://imgur.com/r1ew3zs.png)

## Introduction:

In 3D-Tiles, a tileset is a set of tiles organized in a spatial data structure, the <i>tree</i>.
Each tile has a bounding volume completely enclosing its contents. 
The <i>tree</i> has spatial coherence; the content for child tiles are completely inside the parent's bounding volume.
To allow flexibility, the <i>tree</i> can be any spatial data structure with spatial coherence,
including k-d trees, quadtrees, octrees, and grids.

<img src="../Image/tree.png" width="645" height="611" />

Here is an example of tileset: 

````
{
  "boundingVolume": {
    "region": [
      -1.2419052957251926,
      0.7395016240301894,
      -1.2415404171917719,
      0.7396563300150859,
      0,
      20.4
    ]
  },
  "geometricError": 43.88464075650763,
  "content": {
    "boundingVolume": {
      "region": [
        -1.2418882438584018,
        0.7395016240301894,
        -1.2415422846940714,
        0.7396461198389616,
        0,
        19.4
      ]
    },
    "url": "2/0/0.b3dm"
  },
  "children": [...]
}
````

We have 3 types of bounding volume: 

Box, region and sphere. Box are already read and show but the region and Sphere not yet. 

<img src="../Image/tile.png" width="483" height="600" />

````
   "region": [
        -1.2418882438584018,
        0.7395016240301894,
        -1.2415422846940714,
        0.7396461198389616,
        0,
        19.4
      ]
````

Here for regions we have six number they correspond to geographic coordonate with the order ````[west, south , east, north, min  height, max height]```` 

We have a ````geometricError````  property is a nonnegative number that defines the error, 
in meters, introduced if this tile is rendered and its children are not. At runtime,
the geometric error is used to compute Screen-Space Error (SSE), i.e., the error measured in pixels.
The SSE determines Hierarchical Level of Detail (HLOD) refinement, i.e.,
if a tile is sufficiently detailed for the current view or if its children should be considered.

An optional ````viewerRequestVolume```` property (not shown above) defines a volume,
using the same schema as boundingVolume,that the viewer must be inside of before the tile's content will be
requested and before the tile will be refined based on geometricError.

Then we have several file type of data: the .b3dm, the .pnts, the .i3dm, the .vctr...

The b3dm are already loaded and read in part but the other not yet.

## Work

This work about this issue [Itown2 - 185](https://github.com/iTowns/itowns2/issues/185)

### Bounding volumes
   
  <table>
  <tr>
    <td>     </td>
    <td><b>Loader</b></td>
    <td><b>View</b></td>
    <td><b>Visible for Camera</b></td>
    <td><b><a href="https://github.com/AnalyticalGraphicsInc/3d-tiles-samples/tree/master/tilesets/TilesetWithDiscreteLOD">Geometric error</a></b></td>
    <td><b><a href="https://github.com/AnalyticalGraphicsInc/3d-tiles-samples/tree/master/tilesets/TilesetWithRequestVolume">Viewer request volume</a></b></td>
    <td><b>Example</b></td>
  </tr>
  <tr>
    <td>Box</td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/2705.png" width="32" height="32" /></td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/2705.png" width="32" height="32" /></td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/2705.png" width="32" height="32" /></td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/2705.png" width="32" height="32" /></td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f534.png?v5" width="32" height="32" /></td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/2705.png" width="32" height="32" /></td>
  </tr>
   <tr>
    <td>Region</td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/2705.png" width="32" height="32" /></td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/2705.png" width="32" height="32" /></td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/2705.png" width="32" height="32" /></td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/2705.png" width="32" height="32" /></td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f534.png?v5" width="32" height="32" /></td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/2705.png" width="32" height="32" /></td>
  </tr>
   <tr>
    <td>Sphere</td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/2705.png" width="32" height="32" /></td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/2705.png" width="32" height="32" /></td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/2705.png" width="32" height="32" /></td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/2705.png" width="32" height="32" /></td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/2705.png" width="32" height="32" />  It's missing the fact: if it's not visible we don't load the file</td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/2705.png" width="32" height="32" /></td>
  </tr>
</table>
  
  #### Visible for Camera
  * We check if the frustum of camera is intersect by the object (box, region or sphere). We use the program intersect of [Three.js](https://threejs.org/docs/index.html#api/math/Frustum).
  * For the regions we transform this form into box to simplify intersection calculations, [In getBox function](https://github.com/iTowns/itowns2/blob/master/src/Core/Scheduler/Providers/3dTiles_Provider.js).
  
  <img src="../Image/regionBox.png" width="450" height="100" />
  
  #### [Geometric error](https://github.com/AnalyticalGraphicsInc/3d-tiles-samples/tree/master/tilesets/TilesetWithDiscreteLOD)
  * We calcul the distance between the frustum of the camera and the center of the object in world location, and we compare this with the geometrieError.
  [In computeNodeSSE function](https://github.com/iTowns/itowns2/blob/master/src/Process/3dTilesProcessing.js).
  
  #### [Viewer request volume](https://github.com/AnalyticalGraphicsInc/3d-tiles-samples/tree/master/tilesets/TilesetWithRequestVolume) for sphere 
  * For Sphere, we test if the radius is smaller than the distance between the camera and the object if yes: we display the object else no.[In $3dtilesCulling function](https://github.com/iTowns/itowns2/blob/master/src/Process/3dTilesProcessing.js).
  
  <img src="../Image/schemaViewer1.jpg" width="512" height="384" /> <img src="../Image/schemaViewer2.jpg" width="512" height="384" />
  
### The file .Pnts [PointsCloud](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/PointCloud/README.md)

The Point Cloud tile format enables efficient streaming of massive point clouds for 3D visualization. 
Each point is defined by a position and optional properties used to define its appearance,
such as color and normal, and optional properties that define application-specific metadata.

<table>
  <tr>
    <td><b>Semantic</b></td>
    <td><b>Description</b></td>
    <td><b>Status<b></td>
  </tr>
  <tr>
    <td>POSITION</td>
    <td>A 3-component array of numbers containing x, y, and z Cartesian coordinates for the position of the point.</td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/2705.png" width="32" height="32" /></td>
  </tr>
  <tr>
    <td>POSITION_QUANTIZED</td>
    <td>A 3-component array of numbers containing x, y, and z in quantized Cartesian coordinates for the position of the point.</td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f534.png?v5" width="32" height="32" /></td>
  </tr>
  <tr>
    <td>RGBA</td>
    <td>A 4-component array of values containing the RGBA color of the point.</td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f534.png?v5" width="32" height="32" /></td>
  </tr>
  <tr>
    <td>RGB</td>
    <td>A 3-component array of values containing the RGB color of the point.</td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/2705.png" width="32" height="32" /></td>
  </tr>
  <tr>
    <td>RGB565</td>
    <td>A lossy compressed color format that packs the RGB color into 16 bits, providing 5 bits for red, 6 bits for green, and 5 bits for blue.</td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f534.png?v5" width="32" height="32" /></td>
  </tr>
  <tr>
    <td>NORMAL</td>
    <td>A unit vector defining the normal of the point.</td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f534.png?v5" width="32" height="32" /></td>
  </tr>
  <tr>
    <td>NORMAL_OCT16P</td>
    <td>An oct-encoded unit vector with 16-bits of precision defining the normal of the point.</td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f534.png?v5" width="32" height="32" /></td>
  </tr>
  <tr>
    <td>BATCH_ID</td>
    <td>The batchId of the point that can be used to retrieve metadata from the Batch Table.</td>
    <td><img src="https://assets-cdn.github.com/images/icons/emoji/unicode/1f534.png?v5" width="32" height="32" /></td>
  </tr>
</table>

We read this file with the layout [here](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/PointCloud/README.md), we selectionne what we need 
and we send the information for display that.
The code is [pntsLoader](https://github.com/iTowns/itowns2/tree/master/src/Renderer/ThreeExtended)

## Example 

* We build some example with differente tileset [here](https://github.com/iTowns/itowns2/blob/master/examples/3dtiles.html).
This is the new interface for select the tileset you want to see: 
<img src="../Image/interface3dTiles.png" width="253" height="78" />

we have 2 example for now the DiscreteLOD and the RequestVolume 

* For create a new example (layer) you can copy this program:
````
const $3dTilesLayerDiscreteLOD = new itowns.GeometryLayer('3d-tiles');
$3dTilesLayerDiscreteLOD.preUpdate = preUpdateGeo;
$3dTilesLayerDiscreteLOD.update = itowns.process3dTilesNode(
    itowns.$3dTilesCulling,
    itowns.$3dTilesSubdivisionControl
);
$3dTilesLayerDiscreteLOD.name = 'DiscreteLOD';
$3dTilesLayerDiscreteLOD.url = 'http://localhost:8003/tilesets/TilesetWithDiscreteLOD/tileset.json';
$3dTilesLayerDiscreteLOD.protocol = '3d-tiles'
$3dTilesLayerDiscreteLOD.overrideMaterials = true;  // custom cesium shaders are not functional
$3dTilesLayerDiscreteLOD.type = 'geometry';
$3dTilesLayerDiscreteLOD.visible = false;

itowns.View.prototype.addLayer.call(globe, $3dTilesLayerDiscreteLOD);

// debug for DiscreteLOD
const debug3dt = new itowns.GeometryLayer('debug-3d-tiles');
debug3dt.type = 'debug';
debug3dt.update = updateDebug;

// for have the same bool for visible
debug3dt.visible = $3dTilesLayerDiscreteLOD.visible;
itowns.View.prototype.addLayer.call(globe, debug3dt, $3dTilesLayerDiscreteLOD);
````

* We use the [helper box](https://threejs.org/docs/#api/helpers/BoxHelper) (It is an object that serves to show the world-axis-aligned bounding box around an object) for show the box arround object (box, region).
<img src="../Image/boxHelper.png" width="959" height="456" />

## References 
 * Some image and much part of my introduction: [3d-tiles](https://github.com/AnalyticalGraphicsInc/3d-tiles).
 
 * For the part of [PointsCloud](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/PointCloud/README.md).
 
