### 3DTiles Compression 

3D Tiles compression can be achieved through gltf compression and texture compression.
To compress gltf file, some tools are displayed in this [PR](https://github.com/iTowns/itowns/pull/1425#issuecomment-654104601).

Globally, it takes down to use [Draco Compression](https://google.github.io/draco/) on the generated compression. After testing it, it greatly reduce geometry **but**
we lose both batch and feature table.

Looking at the [KHR_draco_mesh_compression](https://github.com/KhronosGroup/glTF/blob/master/extensions/2.0/Khronos/KHR_draco_mesh_compression/README.md) extension for GLTF
may resolve this problem.

Look at those [advices](https://github.com/iTowns/itowns/wiki/3D-Tiles#advices-for-generating-small-gltf-files) from Itowns to generate small gltf file.

### Texture compression

It exists two type of compressed texture :
- one that aims to reduce the image size while trying to keep quality, such as [jpeg](https://en.wikipedia.org/wiki/JPEG)
- the others aims to be efficient on graphic card, such as [DDS](https://en.wikipedia.org/wiki/DirectDraw_Surface)

As our solution aims to be working on the web, the priority must be to reduce the texture size. 

- [DXT](https://en.wikipedia.org/wiki/S3_Texture_Compression) compression need to be tested (may have been used by JGA)
- [KTX](https://github.com/KhronosGroup/KTX-Software) compression is developped by Khronos, next to gltf
  - Can be added in itowns, using the three.js [KTX2Loader](https://threejs.org/docs/#examples/en/loaders/KTX2Loader), using a similar way as the
[draco loader](https://github.com/iTowns/itowns/blob/6953e0119c35a550621aa792a204c352731aca97/src/Parser/B3dmParser.js#L60) in Itowns.
  - Tools to convert jpeg to ktx : 
    - [gltf transform tool](https://gltf-transform.donmccurdy.com/cli.html) : CLI with nodejs not tested yet
    - [KTXTools](https://github.com/KhronosGroup/3D-Formats-Guidelines/blob/main/KTXTools.md) : CLI, binary to install, appears to be working fine.
  - There is a need of tools to display and debug ktx files


Texture can be also added on lower LOD of a dataset, in order to load them only when close to a building.

## [gltf-pipeline](https://github.com/CesiumGS/gltf-pipeline)

Compress `.gltf` or `.glb` files  
Problem: not working with .b3dm files (used in 3D Tiles)

To install:

```bash
npm install -g gltf-pipeline
```

## [gltf-transform](https://gltf-transform.donmccurdy.com/)

Same, it seems it can't compress tilesets or .b3dm files

## [3dTiles validator](https://github.com/CesiumGS/3d-tiles-validator)

Allows to validate 3DTiles tilesets.  
To install, clone the repo. Then:

```bash
cd <PATH>/3d-tiles-validator/validator
npm install
```

From `validator` folder:

Validates the input tileset.

```bash
node ./bin/3d-tiles-validator.js -i path/to/Tileset/tileset.json
```

Validates a single tile.

```bash
node ./bin/3d-tiles-validator.js -i path/to/Tiles/tile.b3dm
```

## [3dTiles tools](https://github.com/engineerhe/3d-tiles-tools)

Various tools for 3DTiles. It can transform glb in b3dm and b3dm into glb.  
To install, clone the repo. Then:

```bash
cd <PATH>/3d-tiles-tools/tools
npm install
```

From `tools` subfolder:
glb to b3dm:

```bash
node ./bin/3d-tiles-tools.js glbToB3dm -i ./model.glb -o ./model.b3dm
```

b3dm to glb:

```bash
node ./bin/3d-tiles-tools.js b3dmToGlb -i ./model.glb -o ./model.b3dm
```

## Compress 3DTiles

[This comment](https://gitmemory.com/issue/Geodan/pg2b3dm/21/510384357) suggests to use 3DTiles tools to transform b3dm into gltf, compress gltf with gltf-pipeline, then transform gltf to b3dm.

First, install gltf-pipeline and 3d-tiles-tools.

Then, from `3d-tiles-tools\tools\`:

```bash
node ./bin/3d-tiles-tools.js b3dmToGlb -i ..\..\3DTiles\tiles\0.b3dm -o 0.glb

gltf-pipeline -i .\0.glb -o .\compressed.glb -d -b

node ./bin/3d-tiles-tools.js glbToB3dm .\compressed.glb ..\..\3DTiles\tiles\0-compressed.b3dm
```

\+ : Compression is a factor of 10 (like 100kb -> 10kb).

\- : Batch table data might get lost using this method.

### Load in UD-Viz

Problem: THREE needs a draco loader to load compressed files in UD-Viz.  
--> copy the [draco folder](https://github.com/mrdoob/three.js/tree/dev/examples/js/libs/draco) in your `assets`

You can enable the draco loader with:

```
itowns.enableDracoLoader('./assets/draco/');
```

--> An error occurs because the batch table content is missing
