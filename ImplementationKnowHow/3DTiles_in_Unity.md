# 3D Tiles in Unity

Clone [Unity3DTiles](https://github.com/NASA-AMMOS/Unity3DTiles).

The project uses __Unity 2020.1.17f1__.

## Display a tileset

- Open the project in Unity
- In `Assets/Examples/Scenes` select the scene `MainWeb`
- In the scene, select the `Tileset`
- In `Tileset Behaviour (Script)`, change the `Url` in `Tileset Options` (the URL should be the URL of the `tileset.json`)
  - If you want to use a local tileset, copy the tileset in the Unity project in `Assets/StreamingAssets` and use `data://my_tileset/tileset.json` as URL
  - To add another tileset, create an empty object in the scene and add the `Tileset Behavior (Script)`. Then set the URL as explained above
- Save and play
  - If the tileset isn't displayed when you are playing, try to move/rotate the camera 

![image](https://user-images.githubusercontent.com/32875283/207844715-67825c05-bf0e-45b3-9ebe-10208249c2b8.png)

## Create a tileset with Py3DTilers

If you want to produce the tileset with [Py3DTilers](https://github.com/VCityTeam/py3dtilers):

- Follow the [installation notes of Py3DTilers](https://github.com/VCityTeam/py3dtilers#installation-from-sources)

If your input is CityGML:

- [Host CityGML data in 3DCityDB](https://github.com/VCityTeam/UD-SV/blob/master/ImplementationKnowHow/PostgreSQL_for_cityGML.md)
- Copy and customize the config file as explained [here](https://github.com/VCityTeam/py3dtilers/tree/master/py3dtilers/CityTiler#run-the-citytiler)

Unity3DTiles doesn't support standard 3D Tiles, so we must make some modifications in Py3DTilers before producing the 3D Tiles:

- In [tileset_creation.py L78](https://github.com/VCityTeam/py3dtilers/blob/master/py3dtilers/Common/tileset_creation.py#L78):  
  Replace  
  ```python
  feature_list.translate_features(-feature_list.get_centroid())
  ```
  by
    ```python
  feature_list.translate_features(-tree_centroid)
  ```
- In [tileset_creation.py L84](https://github.com/VCityTeam/py3dtilers/blob/master/py3dtilers/Common/tileset_creation.py#L84):  
  Replace  
  ```python
  return distance if user_args.offset[0] == 'centroid' else offset
  ```
  by
    ```python
  return np.array([0, 0, 0])
  ```
- In [tileset_creation.py L201](https://github.com/VCityTeam/py3dtilers/blob/master/py3dtilers/Common/tileset_creation.py#L201):  
  Replace  
  ```python
  return B3dm.from_glTF(gltf, bt=bt)
  ```
  by
  ```python
  ft = BatchTable()
  batch_length = 0
  ft.add_property_from_array("BATCH_LENGTH",batch_length)
  return B3dm.from_glTF(gltf, ft)
  ```

Once those modifications are made, [run the Tiler](https://github.com/VCityTeam/py3dtilers#usage) of your choice with the  option `--offset centroid`

Examples:

With the [CityTiler](https://github.com/VCityTeam/py3dtilers/blob/master/py3dtilers/CityTiler/README.md#city-tiler):
```bash
citygml-tiler -i config.yml -o my_tileset --offset centroid
```

With the [GeojsonTiler](https://github.com/VCityTeam/py3dtilers/blob/master/py3dtilers/GeojsonTiler/README.md#geojson-tiler):
```bash
geojson-tiler -i buildings.geojson -o my_tileset --offset centroid
```
