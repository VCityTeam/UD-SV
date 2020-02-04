// Set global variables
var color = new itowns.THREE.Color();
var tile;
var meshes = [];
var linesBus = [];
var scaler;
////////////////////////

// Set initial parameters
//// Define initial camera position
var positionOnGlobe = { longitude: 4.818, latitude: 45.7354, altitude: 3000 };

//// `viewerDiv` will contain iTowns' rendering area (`<canvas>`)
var viewerDiv = document.getElementById('viewerDiv');

//// Instanciate iTowns GlobeView*
var view = new itowns.GlobeView(viewerDiv, positionOnGlobe);
setupLoadingScreen(viewerDiv, view);

var menuGlobe = new GuiTools('menuDiv', view);
////////////////////////

// Add one imagery layer to the scene
// This layer is defined in a json file but it could be defined as a plain js
// object. See Layer* for more info.
itowns.Fetcher.json('../examples/layers/JSONLayers/Ortho.json').then(function _(config) {
    config.source = new itowns.WMTSSource(config.source);
    var layer = new itowns.ColorLayer('Ortho', config);
    view.addLayer(layer).then(menuGlobe.addLayerGUI.bind(menuGlobe));
});

// Add two elevation layers.
// These will deform iTowns globe geometry to represent terrain elevation.
itowns.Fetcher.json('../examples/layers/JSONLayers/WORLD_DTM.json').then(addElevationLayerFromConfig);
itowns.Fetcher.json('../examples/layers/JSONLayers/IGN_MNT_HIGHRES.json').then(addElevationLayerFromConfig);

// Add WFS Lyon Bus Lines
var lyonTclBusSource = new itowns.WFSSource({
    protocol: 'wfs',
    url: 'https://download.data.grandlyon.com/wfs/rdata?',
    version: '2.0.0',
    typeName: 'tcl_sytral.tcllignebus',
    projection: 'EPSG:3946',
    extent: {
        west: 1822174.60,
        east: 1868247.07,
        south: 5138876.75,
        north: 5205890.19,
    },
    zoom: { min: 9, max: 9 },
    format: 'geojson',
});

var lyonTclBusLayer = new itowns.GeometryLayer('WFS Bus lines', new itowns.THREE.Group(), {
    name: 'lyon_tcl_bus',
    update: itowns.FeatureProcessing.update,
    convert: itowns.Feature2Mesh.convert({
        color: colorLine,
        altitude: altitudeLine }),
    linewidth: 5,
    filter: acceptFeatureBus,
    source: lyonTclBusSource
});
view.addLayer(lyonTclBusLayer);

view.addFrameRequester(itowns.MAIN_LOOP_EVENTS.BEFORE_RENDER, scaler);

var wfsBuildingSource = new itowns.WFSSource({
    url: 'https://wxs.ign.fr/choisirgeoportail/geoportail/wfs?',
    version: '2.0.0',
    typeName: 'BDTOPO_BDD_WLD_WGS84G:bati_remarquable,BDTOPO_BDD_WLD_WGS84G:bati_indifferencie,BDTOPO_BDD_WLD_WGS84G:bati_industriel',
    projection: 'EPSG:4326',
    ipr: 'IGN',
    format: 'application/json',
    zoom: { min: 14, max: 14 },
    extent: {
        west: 4.568,
        east: 5.18,
        south: 45.437,
        north: 46.03,
    },
});

var wfsBuildingLayer = new itowns.GeometryLayer('WFS Building', new itowns.THREE.Group(), {
    update: itowns.FeatureProcessing.update,
    convert: itowns.Feature2Mesh.convert({
        color: colorBuildings,
        batchId: function (property, featureId) { return featureId; },
        altitude: altitudeBuildings,
        extrude: extrudeBuildings }),
    onMeshCreated: function scaleZ(mesh) {
        mesh.scale.z = 0.01;
        meshes.push(mesh);
    },
    filter: acceptFeature,
    overrideAltitudeInToZero: true,
    source: wfsBuildingSource
});
view.addLayer(wfsBuildingLayer);

// Listen for globe full initialisation event
view.addEventListener(itowns.GLOBE_VIEW_EVENTS.GLOBE_INITIALIZED, function () {
    // eslint-disable-next-line no-console
    console.info('Globe initialized');
    view.controls.setTilt(45);
});
var d = new debug.Debug(view, menuGlobe.gui);
debug.createTileDebugUI(menuGlobe.gui, view, view.tileLayer, d);

// Add GUI
for (var layer of view.getLayers()) {
    if (layer.id === 'WFS Bus lines') {
        layer.whenReady.then( function _(layer) {
            var gui = debug.GeometryDebug.createGeometryDebugUI(menuGlobe.gui, view, layer);
            debug.GeometryDebug.addMaterialLineWidth(gui, view, layer, 1, 10);
        });
    }
    if (layer.id === 'WFS Building') {
        layer.whenReady.then( function _(layer) {
            var gui = debug.GeometryDebug.createGeometryDebugUI(menuGlobe.gui, view, layer);
            debug.GeometryDebug.addWireFrameCheckbox(gui, view, layer);
            window.addEventListener('mousemove', picking, false);
        });
    }
    if (layer.id === 'WFS Route points') {
        layer.whenReady.then( function _(layer) {
            var gui = debug.GeometryDebug.createGeometryDebugUI(menuGlobe.gui, view, layer);
            debug.GeometryDebug.addMaterialSize(gui, view, layer, 1, 200);
        });
    }
}
