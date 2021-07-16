### 3DTiles Compression 

3D Tiles compression can be achieved through gltf compression and texture compression.
To compress gltf file, some tools are displayed in this [PR](https://github.com/iTowns/itowns/pull/1425#issuecomment-654104601).

Globally, it takes down to use [Draco Compression](https://google.github.io/draco/) on the generated compression. After testing it, it greatly reduce geometry **but**
we lose both batch and feature table.

Looking at the [KHR_draco_mesh_compression](https://github.com/KhronosGroup/glTF/blob/master/extensions/2.0/Khronos/KHR_draco_mesh_compression/README.md) extension for GLTF
may resolve this problem.

Look at those [advices]https://github.com/iTowns/itowns/wiki/3D-Tiles#advices-for-generating-small-gltf-files) from Itowns to generate small gltf file.

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
