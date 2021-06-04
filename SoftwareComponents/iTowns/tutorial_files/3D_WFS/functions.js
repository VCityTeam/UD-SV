function addElevationLayerFromConfig(config) {
  config.source = new itowns.WMTSSource(config.source);
  var layer = new itowns.ElevationLayer(config.id, config);
  view.addLayer(layer).then(menuGlobe.addLayerGUI.bind(menuGlobe));
}

function picking(event) {
    if(view.controls.isPaused()) {
        var htmlInfo = document.getElementById('info');
        var intersects = view.pickObjectsAt(event, 3, 'WFS Building');
        var properties;
        var info;
        var batchId;

        htmlInfo.innerHTML = ' ';

        if (intersects.length) {
            batchId = intersects[0].object.geometry.attributes.batchId.array[intersects[0].face.a];
            properties = intersects[0].object.feature.geometry[batchId].properties;

            Object.keys(properties).map(function (objectKey) {
                var value = properties[objectKey];
                var key = objectKey.toString();
                if (key[0] !== '_' && key !== 'geometry_name') {
                    info = value.toString();
                    htmlInfo.innerHTML +='<li><b>' + key + ': </b>' + info + '</li>';
                }
            });
        }
    }
}


function colorBuildings(properties) {
    if (properties.id.indexOf('bati_remarquable') === 0) {
        return color.set(0x5555ff);
    } else if (properties.id.indexOf('bati_industriel') === 0) {
        return color.set(0xff5555);
    }
    return color.set(0xeeeeee);
}

function altitudeBuildings(properties) {
    return properties.z_min - properties.hauteur;
}

function extrudeBuildings(properties) {
    return properties.hauteur;
}

function acceptFeature(properties) {
    return !!properties.hauteur;
}

function altitudeLine(properties, contour) {
    var result;
    var z = 0;
    if (contour) {
        result = itowns.DEMUtils.getElevationValueAt(view.tileLayer, contour, 0, tile);
        if (!result) {
            result = itowns.DEMUtils.getElevationValueAt(view.tileLayer, contour, 0);
        }
        tile = [result.tile];
        if (result) {
            z = result.z;
        }
        return z + 5;
    }
}

function colorLine(properties) {
    if (properties) {
        var rgb = properties.couleur.split(' ');
        return color.setRGB(rgb[0] / 255, rgb[1] / 255, rgb[2] / 255);
    }
}

function acceptFeatureBus(properties) {
    var line = properties.ligne + properties.sens;
    if (linesBus.indexOf(line) === -1) {
        linesBus.push(line);
        return true;
    }
    return false;
}

scaler = function update(/* dt */) {
    var i;
    var mesh;
    if (meshes.length) {
        view.notifyChange(view.camera.camera3D, true);
    }
    for (i = 0; i < meshes.length; i++) {
        mesh = meshes[i];
        if (mesh) {
            mesh.scale.z = Math.min(
                1.0, mesh.scale.z + 0.1);
            mesh.updateMatrixWorld(true);
        }
    }
    meshes = meshes.filter(function filter(m) { return m.scale.z < 1; });
};
