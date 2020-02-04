// Globe view
var viewerDiv = document.getElementById('viewerDiv');
var position = new itowns.Coordinates('WGS84', 0.089, 42.8989, 80000);
var view = new itowns.GlobeView(viewerDiv, position);
var menuGlobe = new GuiTools('menuDiv', view);

var promises = [];
var promises2 = [];
var tileLayer1;
var tileLayer2;
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


promises2.push(itowns.Fetcher.xml('https://raw.githubusercontent.com/iTowns/iTowns2-sample-data/master/ULTRA2009.gpx')
            .then(function _(gpx) {
                var gpxSource = new itowns.FileSource({
                    fetchedData: gpx,
                    projection: 'EPSG:4326',
                    parser: itowns.GpxParser.parse,
                });

                var gpxLayer = new itowns.ColorLayer('Gpx', {
                    name: 'Ultra 2009',
                    transparent: true,
                    source: gpxSource,
                    style: {
                        stroke: {
                            color: 'red',
                        },
                        point: {
                            color: 'white',
                            line: 'red',
                        }
                    },
                });

                return view.addLayer(gpxLayer)
                  .then(function _() {
                      menuGlobe.addLayerGUI.bind(menuGlobe);
                      itowns.ColorLayersOrdering.moveLayerToIndex(view, gpxLayer.id, 2);
                  })
                  .then(function _(l) { gpxLayer = l; });
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
