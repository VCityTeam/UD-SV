// Globe view
var viewerDiv = document.getElementById('viewerDiv');
var position = new itowns.Coordinates('WGS84', 4.22, 44.844, 1500);
var view = new itowns.GlobeView(viewerDiv, position);
var menuGlobe = new GuiTools('menuDiv', view);

var promises = [];
var tileLayer1;
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

// Add mesh to the scene
function addMeshToScene() {
        // creation of the new mesh (a cylinder)
        var THREE = itowns.THREE;
        var geometry = new THREE.CylinderGeometry(0, 10, 60, 8);
        var material = new THREE.MeshBasicMaterial({ color: 0xff0000 });
        var mesh = new THREE.Mesh(geometry, material);

        // get the position on the globe, from the camera
        var cameraTargetPosition = view.controls.getLookAtCoordinate();

        // position of the mesh
        var meshCoord = cameraTargetPosition;
        meshCoord.setAltitude(cameraTargetPosition.altitude() + 30);

        // position and orientation of the mesh
        mesh.position.copy(meshCoord.as(view.referenceCrs).xyz());
        mesh.lookAt(new THREE.Vector3(0, 0, 0));
        mesh.rotateX(Math.PI / 2);

        // update coordinate of the mesh
        mesh.updateMatrixWorld();

        // add the mesh to the scene
        view.scene.add(mesh);

        // make the object usable from outside of the function
        view.mesh = mesh;
        view.notifyChange();
    }

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
      .then(addMeshToScene())
      .then(view.controls.setTilt(20, true))
      .then(new ToolTip(view,
        document.getElementById('viewerDiv'),
        document.getElementById('tooltipDiv')))
});
