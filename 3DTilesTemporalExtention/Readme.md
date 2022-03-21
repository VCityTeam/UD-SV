# 3DTiles Temporal Extention

* [py3dTileRs' CityTemporalTiler](https://github.com/VCityTeam/py3dtilers/blob/master/py3dtilers/CityTiler/CityTemporalTiler.py#L4) uses a
  [py3dTiles' TemporalTileSet](https://github.com/VCityTeam/py3dtiles/blob/Tiler/py3dtiles/temporal_extension_tileset.py#L8).
  
### Concerning the client side 
* The rendering style is hardcoded in the [TemporalProvider:: initCOStyles()](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/ViewModel/TemporalProvider.js#L67) function.

### Concerning the relationship between the slider position and the data
* A [TemporalView uses](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/View/TemporalView.js#L46) a [refreshCallback](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/View/TemporalView.js#L31) defined as the [TemporalView::currentTimeUpdated(...)](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/View/TemporalView.js#L25) function.
* In turn a [TemporalView::currentTimeUpdated(...)](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/View/TemporalView.js#L25) function uses a [provider](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/View/TemporalView.js#L18) handled over to the constructor.
* This provider is [defined in the TemporalModule constructor](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/TemporalModule.js#L23) and itself uses [model](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/TemporalModule.js#L24) that is typed as [$3DTemporalExtension](https://github.com/VCityTeam/UD-Viz/blob/master/src/Widgets/Temporal/TemporalModule.js#L21)  
