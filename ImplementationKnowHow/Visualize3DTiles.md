# Visualize 3DTiles in Cesium ion, iTowns and UD-Viz

This tutorial explains how to visualize 3DTiles tilesets in Cesium ion, iTowns and UD-Viz. This tutorial assumes you already have produced 3DTiles.
If you want to produce 3DTiles from CityGML, GeoJSON, OBJ or IFC files, you can use [py3dtilers](https://github.com/VCityTeam/py3dtilers).

## Cesium Ion

___Note__: your 3DTiles must be in the [EPSG:4978](https://epsg.io/4978)_

Go to [Cesium ion](https://cesium.com/ion/) and sign in.

Then, go to `My Assets` and `Add data`.

Upload a zipped folder containing your tileset (the folder must contain a `.json` file and the tiles).

Select `3D Tiles` in '_What kind of data is this?_' and select the main JSON of your tileset in the `3D Tiles options`.

![image](https://user-images.githubusercontent.com/32875283/152762780-6c02b30f-4cc2-4e32-9933-4197bb0e912c.png)

Click on `Upload` and, back to `My Assets`, select your 3DTiles.

![image](https://user-images.githubusercontent.com/32875283/152764557-0e29c224-e6e0-49fb-8e65-920a2d0de7e9.png)

Click on `Open complete code example` to open the full view.

![image](https://user-images.githubusercontent.com/32875283/152764817-905693e2-5ed9-407e-a530-f6b6dab65afd.png)

## iTowns

___Note 1__: Visualizing 3DTiles in iTowns requires [NodeJS](https://nodejs.org/en/download/)_  
___Note 2__: your 3DTiles must be in the [EPSG:3946](https://epsg.io/3946)_

Download the [bundle.zip](https://github.com/iTowns/itowns/releases/download/v2.36.2/bundles.zip) of iTowns.

Create a folder and, in this folder, create a `itowns.html` file and a `js` folder. In the `js` folder, extract the content of the `bundle.zip`.

![image](https://user-images.githubusercontent.com/32875283/152770304-e75e261a-1a1a-4d35-a86a-fbb3aac35bad.png)

![image](https://user-images.githubusercontent.com/32875283/152770332-b4782e37-7ace-4f3b-a9eb-a00b9ecc1ba9.png)

Open `itowns.html` in a code editor and create an empty view:

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>3D-tiles mesh data</title>
    <style>
      html {
        height: 100%;
      }
      body {
        margin: 0;
        overflow: hidden;
        height: 100%;
      }
      #viewerDiv {
        margin: auto;
        height: 100%;
        width: 100%;
        padding: 0;
      }
      canvas {
        display: block;
      }
    </style>
  </head>
  <body>
    <div id="viewerDiv"></div>
    <script src="js/itowns.js"></script>
    <script type="text/javascript">
      // Retrieve the view container
      const viewerDiv = document.getElementById('viewerDiv');

      // Define the view geographic extent
      itowns.proj4.defs(
        'EPSG:3946',
        '+proj=lcc +lat_1=45.25 +lat_2=46.75 +lat_0=46 +lon_0=3 +x_0=1700000 +y_0=5200000 +ellps=GRS80 ' +
          '+towgs84=0,0,0,0,0,0,0 +units=m +no_defs'
      );
      const viewExtent = new itowns.Extent(
        'EPSG:3946', 1837816.94334, 1847692.32501, 5170036.4587, 5178412.82698
      );

      // Define the camera initial placement
      const placement = {
        coord: viewExtent.center(), tilt: 12, heading: 40, range: 6200,
      };

      // Create the planar view
      const view = new itowns.PlanarView(viewerDiv, viewExtent, {
        placement: placement,
      });
    </script>
  </body>
</html>
```

To add a 3DTiles tileset, create a 3DTiles layer:

```javascript
      // Define the source of our 3d-tiles data
      const buildingsSource = new itowns.C3DTilesSource({
        url:
          'https://raw.githubusercontent.com/iTowns/iTowns2-sample-data/master/3DTiles/' +
          'dataset-dl.liris.cnrs.fr/three-d-tiles-lyon-metropolis/Lyon_2015_TileSet/tileset.json',
      });

      // Create a layer to display our 3d-tiles data and add it to the view
      const buildingsLayer = new itowns.C3DTilesLayer(
        'buildings',
        { source: buildingsSource },
        view
      );
      itowns.View.prototype.addLayer.call(view, buildingsLayer);
```

Add a directional light in the view:

```javascript
      // Add directional light effect to the view
      const directionalLight = new itowns.THREE.DirectionalLight(0xffffff, 1);
      directionalLight.position.set(-0.9, 0.3, 1);
      directionalLight.updateMatrixWorld();
      view.scene.add(directionalLight);
```

Save your file and open it in a browser.

![image](https://user-images.githubusercontent.com/32875283/152789884-b2c1a0a8-de9b-4b3b-9db0-d396e36b7a72.png)

To add other layers (elevation, ortho-images, etc) see the [full iTowns tutorial](https://mgermerie.github.io/itowns/docs/out/#tutorials/3dTiles-mesh-data).

## UD-Viz

___Note 1__: Visualizing 3DTiles in UD-Viz requires [NodeJS](https://nodejs.org/en/download/)_  
___Note 2__: your 3DTiles must be in the [EPSG:3946](https://epsg.io/3946)_

Clone [UD-Viz-Template](https://github.com/VCityTeam/UD-Viz-Template) on your computer.

Copy the folder containing your tileset into the `./assets` folder of UD-Viz-Template.

![image](https://user-images.githubusercontent.com/32875283/152767193-ac183cd0-6dee-490a-87dc-79a862810320.png)

Open the [`./assets/config/config.json`](https://github.com/VCityTeam/UD-Viz-Template/blob/master/assets/config/config.json) and add an entry in `3DTilesLayers`:

```json
  "3DTilesLayers": [
    {
      "id": "Lyon-1",
      "url": "./assets/lyon1/tileset.json"
    }
  ],
```

The `url` should be the path to the `.json` file of your tileset. You can delete the other entries of `3DTilesLayers` to view only your tileset.

Open a shell and go into the `UD-Viz-Template` folder and run UD-Viz with the following commands:

```bash
cd UD-Viz-Template
npm install
npm run debug
```

Open your favorite browser and go to `http://localhost:8000/`.

![image](https://user-images.githubusercontent.com/32875283/152768164-33d9b2e4-df50-46eb-b9d0-333384fd530f.png)
