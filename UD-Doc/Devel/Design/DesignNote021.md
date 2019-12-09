## Design note of [need 21](../Needs/Need021.md)


This is the client side design corresponding to [this server side design](DesignNote017.md).

![](images/PartieClient2.png)

To answer this need, we will contribute to [iTowns](https://github.com/iTowns/itowns) in the branch 3dtiles-temporal.

### The work we have to do in iTowns

#### Modify the reader of tilesets

After [modifying](DesignNote017.md#modify-the-api-of-building-server-to-retrieve-this-temporal-information-from-the-database) the tileset creation server-side to add a temporal interval of existence of each tile, we have to modify the reader of tilesets in iTowns to manage this temporal information. Once we have retrieved this temporal information, we have to modify the process that allows to display only the tiles in the frustrum of the camera. Indeed, we must also check if the display date is in the temporal interval of exstence of the tile or not.

#### Modify the parsing of the [the b3dm files](https://github.com/AnalyticalGraphicsInc/3d-tiles/tree/master/TileFormats/Batched3DModel)

The server [modifies](DesignNote017.md#add-the-temporal-information-into-the-tiles) the b3dm files by adding the temporal interval of existence of each city object in the attributes of the tiles. We thus need to parse  and store these temporal information in the client.

#### Modify [the pixel shader](https://en.wikipedia.org/wiki/Shader) 

In short, the pixel shader is used to color each pixel of an object. We will use this shader to check if an object should be displayed or not, regarding to its temporal interval of existence. Indeed, even if the display date is in the temporal existence of a tile, it might not be in the temporal existence of all its city objects. 
For example, let's consider a tile T with two buildings B1 with the temporal interval of existence [1800,1890] and B2 with the temporal interval of existence [1830,1920]. The temporal interval of existence of T will be [1800,1920]. If the display date (chosen by the user) is 1900, the tile will be displayed because the display date is in its temporal interval of existence and B1 will be displayed while B2 will be discarded in the pixel shader.
