# Design note of [need 18](https://github.com/MEPP-team/RICT/blob/master/Doc/Devel/Needs/Need018.md)

## References
 * [Batch table hierarchy specification](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/BatchTable/README.md#hierarchy) (by Analytical Graphics)
 * Py3dtiles: [Oslandia reference repository](https://github.com/Oslandia/py3dtiles)
    * [VCity's fork](https://github.com/MEPP-team/py3dtiles): the [3dtiles-temporal-v2 branch](https://github.com/MEPP-team/py3dtiles/tree/3dtiles-temporal-v2) is the reference for working on temporal data
    * [Jeremy Gaillard's fork](https://github.com/Jeremy-Gaillard/py3dtiles): the [](https://github.com/Jeremy-Gaillard/py3dtiles/tree/bt_hierarchy) holds some [WIP](https://en.wikipedia.org/wiki/Work_in_process) support for batch table hierarchy
 * Schilling, A., Bolling, J., & Nagel, C. (2016, July). Using glTF for streaming CityGML 3D city models. In Proceedings of the 21st International Conference on Web3D Technology (pp. 109-116). ACM.
 * [Early deprecated design notes](DesignNote018-Early_notes.md)

## What needs to be developed to obtain a prototype
* [py3dtiles support for batch table hierarchy](https://github.com/Jeremy-Gaillard/py3dtiles/tree/bt_hierarchy)
* [iTowns support for batch table hierarchy](https://github.com/iTowns/itowns/tree/batchtable_hierarchy)
* [UDV-server script](https://github.com/MEPP-team/UDV-server/blob/semantic_hierarchy/ExtractCityData/extract_city_semantic.py) to extract data from a 3D City DB database and convert it to a B3dm tile while retaining the data's semantic hierarchy

The two first items are straightforward, they are just the implementation of the [batch table hierarchy specification](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/BatchTable/README.md#hierarchy).

The third item is a bit more tricky, since it requires an understanding of the 3D City DB data model. In my partial implementation, I only extract the surface data for LoD2 buildings (disclaimer: my method may not work for every CityGML file, since there seems to be multiple way of storing the same information). The data is organised in the following way:
* The building table contains the "abstract" building subdivisions (building, building part)
* The thematic_surface table contains all the surface objects (wall, roof, floor), with links to the building object it belongs to and the geometric data in the surface_geometry table
* The surface_geometry table contains the geometry of the surface (and volumic for some reason) objects
* The cityobject table contains both the thematic_surface and the building objects

Starting with the ids of the building we want to export, we select the abstract building objects that are descendant of the buildings.
```sql
cursor.execute("SELECT building.id, building_parent_id, cityobject.gmlid, cityobject.objectclass_id FROM building
JOIN cityobject ON building.id=cityobject.id WHERE building_root_id IN %s", (buildingIds,))
```
Then, using the ids of all the abstract building parts, we select all the surface objects that are linked to these building parts. Since the geometric surfaces are also organised in a hierarchy (to each thematic surface corresponds a tree of surface geometries), we need to group them into a single geometry.
```sql
cursor.execute("SELECT cityobject.id, cityobject.gmlid, thematic_surface.building_id,
thematic_surface.objectclass_id, ST_AsBinary(ST_Multi(ST_Collect(ST_Translate(
surface_geometry.geometry, -1845500, -5176100, 0)))) FROM surface_geometry
JOIN thematic_surface ON surface_geometry.root_id=thematic_surface.lod2_multi_surface_id
JOIN cityobject ON thematic_surface.id=cityobject.id WHERE thematic_surface.building_id
IN %s GROUP BY surface_geometry.root_id, cityobject.id, cityobject.gmlid,
thematic_surface.building_id, thematic_surface.objectclass_id", (subBuildingIds,))
```
In more readable pseudocode: 
```sql
SELECT id, gmlid, building_id, objectclass_id, group(geometry) FROM surface_geometry 
JOIN thematic_surface ON root_id=lod2_multi_surface_id # lod2_multi_surface_id only points on the root of the geometry tree
JOIN cityobject ON id
WHERE building_id IN [abstract building parts list]
GROUP BY root_id
```
Once we have all this information, we just need to put it in a batch table using py3dtiles.
