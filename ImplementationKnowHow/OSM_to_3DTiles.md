# Open Street Map data to 3DTiles

This tutorial explains how to create 3DTiles from Open Street Map data. In this example, we create 3DTiles of the buildings of Lyon.

This tutorial is based on [Delft University of Technology's tutorial](https://tudelft3d.github.io/3dfier/building_footprints_from_openstreetmap.html).

## Download the data

Go on [OpenStreetMap](https://www.openstreetmap.org/export#map=14/45.7512/4.8409) website.

Click on `Export` (top left of the screen) to open the export panel.

![image](https://user-images.githubusercontent.com/32875283/154082425-7034e73c-e1e1-4105-ae49-1f66ac807f23.png)

Go on the area you want to download and export it by clicking on `Export` on the left.

![image](https://user-images.githubusercontent.com/32875283/154082854-d0d9b018-9d24-4c9f-ac89-9327538ac733.png)

If the area is to big to be downloaded by OpenStreetMap, select `Overpass API`. This will download the data from a miror of the database.

A file called `map` or `map.osm` should be downloaded.

## Export buildings as GeoJSON

In the previous step, you have downloaded an OSM file. To be able to create the 3DTiles, we need to extract the buildings as a GeoJSON file.

Open the OSM file in [QGIS](https://qgis.org/en/site/forusers/download.html#) (by drag&dropping it in a QGIS project or with `Layer > Add layer > Add vector layer`).

Import only the `Multipolygons` layer, this layer contains the buildings.

![image](https://user-images.githubusercontent.com/32875283/154085324-9164f7f3-9d38-44ff-93ec-6a126e6ae4d8.png)

Right click on the layer on the `Layers` panel and select `Filter`. Write the expression `"building" is not null` and click OK. This will keep only the buildings.

![image](https://user-images.githubusercontent.com/32875283/154084776-6d81a819-051d-4040-81ff-81bec44f7729.png)

![image](https://user-images.githubusercontent.com/32875283/154084975-e4200857-a4bc-4e78-b8ae-facd0ebef1c2.png)

Only the buildings should be present in your QGIS project now.

![image](https://user-images.githubusercontent.com/32875283/154084471-48bbbbfe-e5c2-4901-b271-72cff223ce29.png)

Export the buildings as GeoJSON and choose a name for your file.

![image](https://user-images.githubusercontent.com/32875283/154085658-7c2bcd71-621f-41ad-9795-05df72957254.png)

![image](https://user-images.githubusercontent.com/32875283/154085867-b915ef65-6cce-4dbf-80e8-235b926bb090.png)

A GeoJSON file of the choosen name will be downloaded.

## Create 3DTiles from GeoJSON

First, [install py3dtilers](https://github.com/VCityTeam/py3dtilers#installation-from-sources).
The [Geojson Tiler](https://github.com/VCityTeam/py3dtilers/tree/master/py3dtilers/GeojsonTiler#geojson-tiler) will be used to transform the GeoJSON file into 3DTiles.

Once the installation is completed, run the Geojson Tiler:

```bash
geojson-tiler --path path/to/osm_buildings.geojson --z 0 --height 6
```

* `--path` specifies the path to the file to transform.
* `--z` allows to choose the altitude of the features. Here, we choose 0 m.
* `--height` adds an height to the buildings. The height is 6 m in this case.

If you want to project your 3DTiles into another CRS, you can choose the input and output CRS with `--crs_in` and `--crs_out` flags:

```bash
geojson-tiler --path path/to/osm_buildings.geojson --z 0 --height 6 --crs_in EPSG:4326 --crs_out EPSG:4978
```

The 3DTiles are created in a directory called _geojson_tilesets_. To visualize this tileset in Cesium, iTowns or UD-Viz, see [__how to visualize 3DTiles__](Visualize3DTiles.md).
