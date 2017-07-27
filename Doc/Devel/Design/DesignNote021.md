## Design note of [need 21](https://github.com/MEPP-team/RICT/blob/master/Doc/Devel/Needs/Need021.md)


This is the part of client of this [design note](https://github.com/MEPP-team/RICT/blob/master/Doc/Devel/Design/DesignNote017.md)


### The work we have to do in iTowns, the client part.

![](images/Partie client.png)

#### Modify the reader of tileset

After the [server modify the tileset with temporal information from database](https://github.com/MEPP-team/RICT/blob/master/Doc/Devel/Design/DesignNote017.md#modify-the-api-of-building-server-to-retrieve-this-temporal-information-from-the-database), we have to modify in iTowns the reader of tileset for manage the temporal information. When we do that, we can know if we display the city object inside the bounding.

#### Recover/ Parse [the b3dm file](https://github.com/AnalyticalGraphicsInc/3d-tiles/tree/master/TileFormats/Batched3DModel)

[The server modify the b3dm file for add the temporal information for each tiles](https://github.com/MEPP-team/RICT/blob/master/Doc/Devel/Design/DesignNote017.md#add-the-temporal-information-into-the-tiles), so we need to parse that in iTowns for recover the temporal interval and add to the structure of iTowns.

#### Modify [the pixel shader](https://en.wikipedia.org/wiki/Shader) 

To explain simply, the pixel shader is used to color each pixel of an object. We use this shader for display or not the object with the temporal information. 
For example if the date choose the user are 1900 and the date of one object are 1800 - 1890 the shader compare this and return don't display this object.
