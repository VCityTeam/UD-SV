# 3DTiles Temporal Extention
Within the UD-SV project several data models, tools, and components are used to create 3DTiles with a temporal extention.

## Extention Specification
The original documentation for the specification of these 3DTiles can be found in [chapter 3.2 of the thesis of Vincent Jaillot](./Jaillot2020Extract.md) 

The JSON schemas for the 3DTiles Temporal extension can be found on [Zenodo](https://zenodo.org/record/3596881) 

## Tileset Creation
A dockerized version of the tileset creation data pipeline can be found in the [cityGMLto3DTiles](https://github.com/VCityTeam/cityGMLto3DTiles) repository.

To construct a tileset with the temporal extention, first the differences between each city snapshot must be created using the `demo_extract_building_dates.py` script in the [cityGMLto3DTiles temporal workflow](https://github.com/VCityTeam/cityGMLto3DTiles/tree/master/PythonCallingDocker#running-the-temporal-tiler-workflow).

Once the differences files are created the [CityTemporalTiler of py3dTileRs](https://github.com/VCityTeam/py3dtilers/blob/master/py3dtilers/CityTiler/CityTemporalTiler.py#L4) can be used to create a tileset with the temporal extention. Here, the CityTemporalTiler uses the [TemporalTileSet class of py3dTiles](https://github.com/VCityTeam/py3dtiles/blob/Tiler/py3dtiles/temporal_extension_tileset.py#L8).

* [Py3DTilers CityTemporalTiler CLI documentation](https://github.com/VCityTeam/py3dtilers/tree/master/py3dtilers/CityTiler#citytemporaltiler-features)

## Tileset Visualization

### Concerning the client side 
* The rendering style is hardcoded in the [TemporalProvider:: initCOStyles()](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L67) function.

### Concerning the relationship between the slider position and the data
* A [TemporalView uses](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/View/TemporalView.js#L46) a [refreshCallback](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/View/TemporalView.js#L31) defined as the [TemporalView::currentTimeUpdated(...)](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/View/TemporalView.js#L25) function.
  * Within TemporalView, this refreshCallback is used to [construct a TemporalSliderWindow](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/View/TemporalView.js#L46).
  * Eventually the callback is [invoked by the TemporalSliderWindow](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/View/TemporalSliderWindow.js#L88) when e.g. the slider is acted upon the user.
* In order to get the proper slide-bar refresh, the [TemporalView::currentTimeUpdated(...)](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/View/TemporalView.js#L25) callback function uses a [provider](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/View/TemporalView.js#L18) (that is handled over to the constructor) that triggers a [provider.changeVisibleTilesStates()](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/View/TemporalView.js#L29).
* In turn the [TemporalProvider::changeVisibleTilesStates() function](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L333) (FIXME THERE IS SOME MAGIC HERE: what is the link between the the layer and the tiles ?) uses [a TileManager](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L334) ([provided to the constructor](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L29)) to retrieve the visible tiles.
* FIXME: the tiles seem to come from the [model](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/TemporalModule.js#L24) that is typed as [$3DTemporalExtension](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/TemporalModule.js#L21)
* The TemporalProvider::constuctor() is [instanciated in the TemporalModule constructor](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/TemporalModule.js#L23).
