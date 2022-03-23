# 3DTiles Temporal Extention

## Introduction
[3DTiles](https://github.com/CesiumGS/3d-tiles/blob/main/README.md) is an open specification for sharing, visualizing, fusing, and interacting with massive heterogenous 3D geospatial content. Yet 3DTiles is restricted to __static__ geometrical features as opposed to __dynamic__ features that is
features changing/evolving with time.
3DTiles-temporal is a [3Dtiles extention](https://github.com/CesiumGS/3d-tiles/tree/main/extensions#about) dedicated to 
the **representation of temporal (dynamic) 3dTiles tilesets**.

This extension allows to, for example: 

* add dates of existence to [(3dTiles) features](https://github.com/CesiumGS/3d-tiles/tree/main/specification#readme),
* define transitions between two features, called transactions (e.g. `creation`, `modification`,
  `demolition`, `union`, `division` or compositions of these transactions),
* describe versions of the city (an aggregation of city objects for a given
  period of time),
* version transitions (transitions between two versions together with
  an aggregation of transactions between two versions).

## Extention Specification
In addition, the [JSON schemas](https://json-schema.org/) of the 3DTiles-temporal extension currently
constitute a concrete format specification of the 3DTiles-temporal extention.
Those 3dTiles-temporal JSON schemas can currently be found 

* at [Zenodo](https://zenodo.org/record/3596881) for the schemas per se,
* embedded within the 
  [py3dTiles](https://github.com/VCityTeam/py3dtiles/tree/Tiler/py3dtiles/jsonschemas))
  [python](https://en.wikipedia.org/wiki/Python_(programming_language)) based implementation
  of the (memory) representation of the 3DTiles-temporal extention,
* or within the 
  [Temporal Widget](https://github.com/VCityTeam/UD-Viz/tree/master/src/Widgets/Temporal/Model/jsonSchemas)
  of the [UD-Viz](https://github.com/VCityTeam/UD-Viz) visualization package.
  
<a href="./Jaillot2020Extract.md">
    <img src="https://user-images.githubusercontent.com/23373264/159284795-f6f7b5a7-364c-4f4e-9cdd-4197237f5166.png"
       align=center  
       alt="UML conceptual model of 3DTiles-temporal extension"
       width="800"
       border="0">
</a>

## 3dTiles-temporal tileset examples

* A dataset, representing of the city of Lyon between 2009 and 2015 is openly
  available online ([hosted at Zenodo](https://zenodo.org/record/3596861)) at  
     https://doi.org/10.5281/zenodo.3596861
* Several 3dTiles-temporal tileset examples are hosted at
  [LIRIS lab online dataset](https://dataset-dl.liris.cnrs.fr/three-d-tiles-lyon-metropolis/):
  look for tilesets containing Temporal within their name. 

## References

The theoretical work, backing this specification of 3DTiles-temporal, is described
in the article

   ```
   Jaillot, Vincent, Sylvie Servigne, and Gilles Gesquière. “Delivering
   Time-Evolving 3D City Models for Web Visualization.” International Journal of
   Geographical Information Science 34, no. 10 (October 2, 2020): 2030–52.
   ```

and is avaible online at https://doi.org/10.1080/13658816.2020.1749637.

Further material can be found in [Vincent Jaillot's Phd](https://tel.archives-ouvertes.fr/tel-03228436).
The following [Phd extracts/snipets](./Jaillot2020Extract.md) (mainly taken from chapter 3.2 [Vincent Jaillot's Phd](https://tel.archives-ouvertes.fr/tel-03228436)) document further the extension design process as well as the central notions of the 3DTiles-temporal specification.


## Tileset Creation
A dockerized version of the tileset creation data pipeline can be found in the [cityGMLto3DTiles](https://github.com/VCityTeam/cityGMLto3DTiles) repository.

<a href="./https://github.com/VCityTeam/cityGMLto3DTiles">
    <img src="https://raw.githubusercontent.com/VCityTeam/cityGMLto3DTiles/master/Images/TilerActivityDiagramWithoutRendering.png"
       align=center  
       alt="3dTiles-temporal tileset creation pipeline"
       width="800"
       border="0">
</a>

In order to construct a 3dTiles-temporal tileset, a succession/pipeline (illustrated above) of treatments must be realized, mainly:

* sanitize each snapshot/vintage data and respectively host them [3DCityDB databases](https://3dcitydb-docs.readthedocs.io/en/version-2021.1/),
* then compute the differences between each city snapshot/vintage and its succeeding vintage data 
  using e.g. the `demo_extract_building_dates.py` script in the 
  [cityGMLto3DTiles temporal workflow](https://github.com/VCityTeam/cityGMLto3DTiles/tree/master/PythonCallingDocker#running-the-temporal-tiler-workflow),
* once the differences files are created use the [CityTemporalTiler of py3dTileRs](https://github.com/VCityTeam/py3dtilers/blob/master/py3dtilers/CityTiler/CityTemporalTiler.py#L4) to create a tileset with the temporal extention (for this the CityTemporalTiler uses the [TemporalTileSet class of py3dTiles](https://github.com/VCityTeam/py3dtiles/blob/Tiler/py3dtiles/temporal_extension_tileset.py#L8)).

Refer to [Py3DTilers CityTemporalTiler CLI documentation](https://github.com/VCityTeam/py3dtilers/tree/master/py3dtilers/CityTiler#citytemporaltiler-features) for usage documentation.

## Tileset Visualization

Visualizing and interacting with 3dTiles-temporal tilesets, can be done through the
**[UD-Viz Temporal Widget](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/Docs/Readme.md)**
software component.

This widget proposes to render the transactions diffently according to the position of the temporal slider
as illustrated by the following illustration

<a href="https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/Docs/Readme.md">
    <img src="https://raw.githubusercontent.com/VCityTeam/UD-Viz/master/src/Widgets/Temporal/Docs/visu-transactions.png"
       align=center  
       alt="Tansaction rendering with UD-Viz Temporal Widget"
       width="800"
       border="0">
</a>
