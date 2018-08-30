# Design note of [need 18](https://github.com/MEPP-team/RICT/blob/master/Doc/Devel/Needs/Need018.md)

## References
 * [Batch table hierarchy specification](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/BatchTable/README.md#hierarchy) (by Analytical Graphics)
 * Py3dtiles: [Oslandia reference repository](https://github.com/Oslandia/py3dtiles)
    * [VCity's fork](https://github.com/MEPP-team/py3dtiles): the [3dtiles-temporal-v2 branch](https://github.com/MEPP-team/py3dtiles/tree/3dtiles-temporal-v2) is the reference for working on temporal data
    * [Jeremy Gaillard's fork](https://github.com/Jeremy-Gaillard/py3dtiles): [JGA's fork](https://github.com/Jeremy-Gaillard/py3dtiles) holds some [WIP](https://en.wikipedia.org/wiki/Work_in_process) support for batch table hierarchy on the [batchtable_hierarchy branch](https://github.com/iTowns/itowns/tree/batchtable_hierarchy)
 * Schilling, A., Bolling, J., & Nagel, C. (2016, July). Using glTF for streaming CityGML 3D city models. In Proceedings of the 21st International Conference on Web3D Technology (pp. 109-116). ACM.
 * [Early design notes](DesignNote018-Early_notes.md) (now deprecated)

## Assumption
We suppose that 3DTiles temporal extension and the batchtable hierarchy extension are completely disjoint.

A consequence is the respective implementations of the extension support in Py3DTiles are also completely disjoint.

**Warning**: they are two distinguished processes for producing 3DTiles tilesets of a given city database
 * Extract_city_data.py together with export_tileset.py that produce a temporal tileset 
 * Extract_city_semantic.py (JGA) that produces a hierarchical tileset
Because we need hierarchical temporal tileset, the two processes cannot remain disjoint ! We need a single process for producing a hierarchical temporal tileset. Because the two processes have different architectures (one uses a 3DCityView view and not the other) we have to merge/fuse/blend the code of those two processes. 
 
## What needs to be developed to obtain a prototype
The high level view of the work can be summarized as: implement the [batch table hierarchy specification](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/BatchTable/README.md#hierarchy) support in the concerned components.

On the back-end side:
 * Finish the [py3dtiles support for batch table hierarchy](https://github.com/Jeremy-Gaillard/py3dtiles/tree/bt_hierarchy)
 * Use the resulting py3dtiles to realise an UDV-server script utility to extract data from a 3D City DB database and convert it to a B3dm tile while retaining the data's semantic hierarchy

On the front-end side  
* Finish the [iTowns support for batch table hierarchy](https://github.com/iTowns/itowns/tree/batchtable_hierarchy)

### Back end side work

**Important note**: elements for a prototype of an "UDV-server script" can be extracted from 
[extract_city_semantic.py](https://github.com/MEPP-team/UDV-server/blob/semantic_hierarchy/ExtractCityData/extract_city_semantic.py)

Realizing the UDV-server script requires some understanding of the 3D City DB data model. In my partial implementation, I only extract the surface data for LoD2 buildings (disclaimer: my method may not work for every CityGML file, since there seems to be multiple way of storing the same information). The data is organised in the following way:
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

### Front end side work
This consists in making finishing JGA's work in support of [batch table hierarchies](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/BatchTable/README.md#hierarchy) within iTowns. 
JGA's WIP sits on [iTowns' `batchtable_hierarchy`](https://github.com/iTowns/itowns/tree/batchtable_hierarchy) with unknown status.

