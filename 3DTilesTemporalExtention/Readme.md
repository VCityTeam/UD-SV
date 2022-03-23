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

## 3dTiles-temporal tileset examples

* A dataset, representing of the city of Lyon between 2009 and 2015 is openly
  available online at https://doi.org/10.5281/zenodo.3596861 (and 
  [hosted at Zenodo](https://zenodo.org/record/3596861)) 
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

To construct a tileset with the temporal extention, first the differences between each city snapshot must be created using the `demo_extract_building_dates.py` script in the [cityGMLto3DTiles temporal workflow](https://github.com/VCityTeam/cityGMLto3DTiles/tree/master/PythonCallingDocker#running-the-temporal-tiler-workflow).

Once the differences files are created the [CityTemporalTiler of py3dTileRs](https://github.com/VCityTeam/py3dtilers/blob/master/py3dtilers/CityTiler/CityTemporalTiler.py#L4) can be used to create a tileset with the temporal extention. Here, the CityTemporalTiler uses the [TemporalTileSet class of py3dTiles](https://github.com/VCityTeam/py3dtiles/blob/Tiler/py3dtiles/temporal_extension_tileset.py#L8).

* [Py3DTilers CityTemporalTiler CLI documentation](https://github.com/VCityTeam/py3dtilers/tree/master/py3dtilers/CityTiler#citytemporaltiler-features)

## Tileset Visualization
**[UD-Viz Temporal Widget Documentation](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/Docs/configuration_temporalGraphOption.md).**

For more details on how the functionality and code of this implementation, please see below.

### Concerning the relationship between the slider position and the data
A [TemporalView calls](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/View/TemporalView.js#L46) a [refreshCallback](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/View/TemporalView.js#L31) function every time the slider is moved.
* The refreshCallback is defined as the [TemporalView::currentTimeUpdated(...)](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/View/TemporalView.js#L25) function.
* The TemporalView passes this refreshCallback to the [TemporalSliderWindow constructor](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/View/TemporalView.js#L46) .
* Eventually the callback is [invoked by the TemporalSliderWindow](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/View/TemporalSliderWindow.js#L88) when e.g. the slider is acted upon the user.

In order to get the proper slide-bar refresh, the [TemporalView::currentTimeUpdated(...)](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/View/TemporalView.js#L25) callback function uses a [provider](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/View/TemporalView.js#L18) (that is [handled over to the constructor](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/TemporalModule.js#L29)) that triggers a [provider.changeVisibleTilesStates()](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/View/TemporalView.js#L29).
* In turn the [TemporalProvider::changeVisibleTilesStates() function](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L333) uses 
  * a [TileManager](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L334) ([provided to the constructor](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L29)) to retrieve the visible tiles,
  * a [`$3DTemporalExtension` model](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/TemporalModule.js#L21) (also [provided to the constructor](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L27))  
* Both those `TileManager` and `model` are [provided to the TemporalProvider at instantiation](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/TemporalModule.js#L24) and it is this instantiantion context that instantiates the [`$3DTemporalExtension` model](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/TemporalModule.js#L21)

Now, [TemporalProvider::changeVisibleTilesStates() function](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L333) calls [TemporalProvider::computeTileState()](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L336) for each `tiles[i].tileId` that [is visible](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L334)
[TemporalProvider::computeTileState()](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L336) 
  uses the [`TemporalProvider.COStyles`](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L39)
  optimization data structure that `computeTileState()`
* [initializes on first traversal](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L296)
* updates/set the [features rendering style on further traveral](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L287)

In order to [set the rendering mode (display styles)](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L336) of the features of tile (for a given currentTime), `TemporalProvider::computeTileState()` calls [TemporalProvider::culling()](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L178) that 
* If the feature exists at the currentTime, [displays it in gray](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L188),
* If there is a transaction between the feature and another feature at the currentTime AND
  * if the currentTime lies within the first half duration of the transaction THEN [displayed geometry is the one of the old feature](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L211) and [set the color](https://github.com/VCityTeam/UD-Viz/blob/86ff907a5d00b944de895a735fe4c42162d2251c/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L211)
  * if the currentTime lies within the second half of the duration THEN [the displayed geometry is the one of the new feature](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L229) and [set the color](https://github.com/VCityTeam/UD-Viz/blob/86ff907a5d00b944de895a735fe4c42162d2251c/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L229)
* If there is no existing feature or transaction at the currentTime :
  * If there a feature that exists in the next vintage, [display it as green (construction)](https://github.com/VCityTeam/UD-Viz/blob/86ff907a5d00b944de895a735fe4c42162d2251c/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L253)
  * If there a feature that exists in the previous vintage, [display it as red (destruction)](https://github.com/VCityTeam/UD-Viz/blob/86ff907a5d00b944de895a735fe4c42162d2251c/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L253)
  * Otherwise [hide the feature](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L264)

### Concerning the client side color rendering 
* The rendering style is hardcoded in the [TemporalProvider:: initCOStyles()](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L67) function.

### Concerning the client side temporal tileset model
* The code for parsing and storing the temporal tileset can be found in the [model](https://github.com/VCityTeam/UD-Viz/tree/master/src/Widgets/Temporal/Model) 
