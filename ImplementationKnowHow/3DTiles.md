## Notes

### Concerning CRS (Coordinates Reference System)
3dTiles does not allow to specify a (geographical) projection system. Most often it 
implicitly uses [WGS84](https://docs.ogc.org/cs/18-053r2/18-053r2.html#25) but the
responsability of tracking the CRS belongs to the user and is carried as metadata
(has to be stored outside of a 3DTiles file).

For examle Cesium conventionaly considers that all the 3DTiles it uses should be 
implicitely refer to [EPSG4978](https://epsg.io/4978). 

## Links
- [iTowns and 3DTiles](iTowns3Dtiles.md): quick noes on what you'll need to 
  know when working-with/using 3DTiles in an [iTowns context](http://www.itowns-project.org/)
- [Compression within 3Dtiles](3DTilesCompression.md): quick notes on how compression is
  supported/used within 3DTiles.
- [Geomtric error within 3DTiles](3DTiles_GeometricError.md): quick notes on how geometric
  error can be dealt with when using 3DTiles.
- [Visualize 3DTiles](Visualize3DTiles.md)

## References:


- OGC's 3D Data Container and Tiles API Pilot initiative issued a 
  [3D Data Container Engineering Report]( https://docs.ogc.org/per/20-029.html)
  that includes a draft specification for a 3D GeoVolumes API.
