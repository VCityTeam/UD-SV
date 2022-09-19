# 3D Tiles Geometric Error

This document explain what is the _geometricError_ in 3D Tiles and how it should be used.

## Definition

According to the [3D Tiles spec](https://github.com/CesiumGS/3d-tiles/tree/main/specification#geometric-error):

"Tiles are structured into a tree incorporating Hierarchical Level of Detail (HLOD) so that at runtime a client implementation will need to determine if a tile is sufficiently detailed for rendering and if the content of tiles should be successively refined by children tiles of higher resolution. An implementation will consider a maximum allowed Screen-Space Error (SSE), the error measured in pixels.

A tile's geometric error defines the selection metric for that tile. Its value is a nonnegative number that specifies the error, in meters, of the tile's simplified representation of its source geometry. The root tile, being the most simplified version of the source geometry, will have the greatest geometric error. Then each successive level of children will have a lower geometric error than its parent, with leaf tiles having a geometric error of or close to 0.

In a client implementation, geometric error is used with other screen space metrics—e.g., distance from the tile to the camera, screen size, and resolution— to calculate the SSE introduced if this tile is rendered and its children are not. If the introduced SSE exceeds the maximum allowed, then the tile is refined and its children are considered for rendering.

The geometric error is formulated based on a metric like point density, tile size in meters, or another factor specific to that tileset. In general, a higher geometric error means a tile will be refined more aggressively, and children tiles will be loaded and rendered sooner."

Important points:

- The _geometricError_ is the metric used to refine the tiles.
- The greater is the _geometricError_, the sooner a tile will be refined.
- All the tiles must have a _geometricError_. The tileset itself must have a _geometricError_ too.
- The tileset should have the greatest _geometricError_. A tile should always have a lower _geometricError_ than its parent (or equal to its parent).
  - Tileset GE >= Root tile GE >= child tiles GE

## Choose the geometricError

The _geometricError_ values for each tile and for the tileset are __arbitrary__. There is no predefined algorithm to compute the _geometricError_. However, different strategies can be adopted to choose a _geometricError_.

### Cesium

Cesium's strategy to compute the _geometricError_ is explained in [this issue](https://github.com/CesiumGS/3d-tiles/issues/162):

"The geometric error can be computed however you like, but often a good estimate is finding the diagonal of the largest building/feature in the tile. In tileset.json a tile's geometric error will often equal the largest geometric error of its children. Typically leaf tiles have a geometric error of 0."

Explanation:

Leaf tiles (tiles without child tiles) should have a _geometricError_ close or equal to `0`, since those tiles won't be refined.

Parent tiles should have a _geometricError_ based on the geometries of their children. For example, if the largest building in a tile has a diagonal of `20 meters`, its parent should have a _geometricError_ equal to `20`.

This strategy can be really efficient in an [additive refinement](https://github.com/CesiumGS/3d-tiles/tree/main/specification#additive) hierarchy, where the tiles on the top of the hierarchy contain the biggest features and the leaf tiles the smallest ones.

### Py3DTilers

In [Py3DTilers](https://github.com/VCityTeam/py3dtilers), we've chosen a different strategy:

- both the tileset and the root tile have a _geometricError_ equal to `500`.
- each tile (except the root tile) has a _geometricError_ based on the [level of detail](https://github.com/VCityTeam/py3dtilers/tree/master/py3dtilers/Common#loa) (LoD) it represent (LoA, LoD1 or detailled).

`500` is used for the tileset and the root tile for a specific reason: with this value, we ensure the tileset is almost always displayed, even from afar. We also chose `500` for the root tile because this tile is always an "abstract" tile (a tile without content and with only a bounding box). Since we want that abstract tile to be almost always refined in order to display its children, we chose the same default _geometricError_ for the root tile as for the tileset.

For the tile (except the root tile), we use the following _geometricErrors_ by default:

- `1` for the detailled tiles (wich are always the leaf tiles).
- `5` for the LoD1 tiles.
- `20` for the LoA tiles.

[Those values can be customized when creating a tileset with Py3DTilers](https://github.com/VCityTeam/py3dtilers/tree/master/py3dtilers/Common#geometric-error).

By default, a tileset created with Py3DTilers will look like this:

```mermaid
graph TD;
    subgraph geometricError=500
    Tileset[Tileset]
    Root_Tile[Root Tile]
    end
    subgraph geometricError=20
    LOA_tile_1[LOA Tile 1];
    LOA_tile_2[LOA Tile 2];
    end
    subgraph geometricError=5
    LOD1_tile_1[LOD1 Tile 1];
    LOD1_tile_2[LOD1 Tile 2];
    end
    subgraph geometricError=1
    Detailled_tile_1[Detailled Tile 1];
    Detailled_tile_2[Detailled Tile 2];
    end
    Tileset-->Root_Tile
    Root_Tile-->LOA_tile_1-->LOD1_tile_1-->Detailled_tile_1;
    Root_Tile-->LOA_tile_2-->LOD1_tile_2-->Detailled_tile_2;
```

Chosing a _geometricError_ for each level of detail can be empirical, but certain guidelines should be respected:

- the more detailled is a tile, the less should be its _geometricError_.
- TODO
