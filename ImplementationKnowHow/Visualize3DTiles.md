# Visualize 3DTiles in Cesium ion, iTowns and UD-Viz

This tutorial explains how to visualize 3DTiles tilesets in Cesium ion, iTowns and UD-Viz. This tutorial assumes you already have produced 3DTiles.
If you want to produce 3DTiles from CityGML, GeoJSON, OBJ or IFC files, you can use [py3dtilers](https://github.com/VCityTeam/py3dtilers).

## Cesium Ion

Go to [Cesium ion](https://cesium.com/ion/) and sign in.

Then, go to `My Assets` and `Add data`.

Upload a zipped folder containing your tileset (the folder must contain a `.json` file and the tiles).

___Note__: your 3DTiles must be the [EPSG:4978](https://epsg.io/4978)_

Select `3D Tiles` in '_What kind of data is this?_' and select the main JSON of your tileset in the `3D Tiles options`.

![image](https://user-images.githubusercontent.com/32875283/152762780-6c02b30f-4cc2-4e32-9933-4197bb0e912c.png)

Click on `Upload` and, back to `My Assets`, select your 3DTiles.

![image](https://user-images.githubusercontent.com/32875283/152764557-0e29c224-e6e0-49fb-8e65-920a2d0de7e9.png)

Click on `Open complete code example` to open the full view.

![image](https://user-images.githubusercontent.com/32875283/152764817-905693e2-5ed9-407e-a530-f6b6dab65afd.png)

## iTowns

## UD-Viz

___Note 1__: Visualizing 3DTiles in UD-Viz requires [NodeJS](https://nodejs.org/en/download/)_  
___Note 2__: your 3DTiles must be the [EPSG:3946](https://epsg.io/3946)_

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
