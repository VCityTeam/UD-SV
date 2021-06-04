// Globe view
var viewerDiv = document.getElementById('viewerDiv');
var position = new itowns.Coordinates('WGS84', 2.35, 48.8, 25e6);
var view = new itowns.GlobeView(viewerDiv, position);
var menuGlobe = new GuiTools('menuDiv', view);

var promises = [];
var promises2 = [];
var tileLayer1;
var tileLayer2;
var ariegeLayer;
var moreThanOne = 0

// Add two imagery layers to the scene
// This layer is defined in a json file but it could be defined as a plain js
// object. See Layer* for more info.
function addColorLayerFromConfig(config) {
    var layer = new itowns.ColorLayer(config.id, config)
    if (moreThanOne > 0){layer.visible = false;}
    else {layer.visible = true;};
    moreThanOne++;

    return view.addLayer(layer).then(function _() {
                    menuGlobe.addLayerGUI.bind(menuGlobe);
                    itowns.ColorLayersOrdering.moveLayerToIndex(view, config.id, 0);
                });
};
promises.push(itowns.Fetcher.json('./JSON_layers/OSM_stamen_terrain.json')
    .then(function _(c) {
        c.source = new itowns.TMSSource(c.source);
        return c;
    })
    .then(addColorLayerFromConfig)
    .then(function _(l) { tileLayer1 = l; }));

promises.push(itowns.Fetcher.json('./JSON_layers/OSM_cartodb_dark.json')
    .then(function _(c) {
        c.source = new itowns.TMSSource(c.source);
        return c;
    })
    .then(addColorLayerFromConfig)
    .then(function _(l) { tileLayer2 = l; }));

promises2.push(itowns.Fetcher.json('https://raw.githubusercontent.com/gregoiredavid/france-geojson/master/departements/09-ariege/departement-09-ariege.geojson')
      .then(function _(geojson) {
          return itowns.GeoJsonParser.parse(geojson, {
              buildExtent: true,
              crsIn: 'EPSG:4326',
              crsOut: view.tileLayer.extent.crs,
              mergeFeatures: true,
              withNormal: false,
              withAltitude: false,
          });
      }).then(function _(parsedData) {
          var ariegeSource = new itowns.FileSource({
              parsedData,
          });

          ariegeLayer = new itowns.ColorLayer('Ariege', {
              name: 'ariege',
              transparent: true,
              style: {
                  fill: 'orange',
                  fillOpacity: 0.5,
                  stroke: 'white',
              },
              source: ariegeSource,
          });
          // return ariegeLayer;
          return view.addLayer(ariegeLayer)
                      .then(function _() {
                          menuGlobe.addLayerGUI.bind(menuGlobe);
                          itowns.ColorLayersOrdering.moveLayerToIndex(view, ariegeLayer.id, 2);
                      })
                      .then(function _(l) { ariegeLayer = l; });
      })
    );

// Add two elevation layers.
// These will deform iTowns globe geometry to represent terrain elevation.
function addElevationLayerFromConfig(config) {
    config.source = new itowns.WMTSSource(config.source);
    var layer = new itowns.ElevationLayer(config.id, config);
    view.addLayer(layer).then(menuGlobe.addLayerGUI.bind(menuGlobe));
}
itowns.Fetcher.json('../examples/layers/JSONLayers/WORLD_DTM.json').then(addElevationLayerFromConfig);
itowns.Fetcher.json('../examples/layers/JSONLayers/IGN_MNT_HIGHRES.json').then(addElevationLayerFromConfig);

// Listen for globe full initialisation event
view.addEventListener(itowns.VIEW_EVENTS.LAYERS_INITIALIZED, function _() {
      Promise.all(promises)
      .then(Promise.all(promises2))
      .then(new ToolTip(view,
        document.getElementById('viewerDiv'),
        document.getElementById('tooltipDiv')))
});
