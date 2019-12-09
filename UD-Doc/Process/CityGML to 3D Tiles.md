# CityGML to 3D Tiles

This document presents the pipeline we use to transform a CityGML file into 3D Tiles files in order to visualize and interact with it in a Web environment.

## Pipeline overview

We use several third-party applications and modules in this pipeline:
* [PostgreSQL](https://www.postgresql.org/) and [PostGIS](http://postgis.net/): a relationship database and its geospatial extension
* [3D City DB](https://www.3dcitydb.org/3dcitydb/3dcitydbhomepage/): an application that allows importing CityGML files in a database, using a database schema that preserves the CityGML structure
* [py3dtiles](https://github.com/Oslandia/py3dtiles/): a python library that converts 3D data to 3D Tiles formats

![Pipeline](images/pipeline.png)

There are two stages in our pipeline:
* Importing the CityGML into PostGIS so it can be properly analysed
* Exporting the data into 3D Tiles files by organizing it into a set of tiles and generating the tileset (3D Tiles scene graph) and tiles (3D Tiles geometries)

"Processing and organisation" is a varying part of this pipeline: depending on the use case and the nature of the data, we may want to organize the data differently, or process it to generate level of details.

## Importing CityGML files

Once a PostGIS database has been created, this stage of the pipeline is entirely done by 3D City DB.

## Exporting the data

To export the data in the 3D Tiles format, we need to organize the city objects in a set of tiles, store this organisation in a tileset file, and export the geometries in tile files.

Note that py3dtiles offers a [tool](https://github.com/Oslandia/py3dtiles/blob/master/tools/export_tileset) to export meshes to 3D Tiles files, provided the data is stored in a certain way in the database.

### Organizing the city objects

The goal of this step is to organize the city objects in a tree of tiles, to define which objects goes in which tile. There are various ways of organizing the city objects depending on the nature of the data and the use cases.

Usually, we will start by selecting the relevant metadata for each city object (bounding box principally, but also 2D footprint area or height) from the database and create a hierarchy based on it. [This article](https://hal.archives-ouvertes.fr/hal-01420117) presents a way of organizing this kind of data in a quadtree (the algorithm used in the py3dtiles export tool is based on this article). Other data organizations are presented in this [Cesium blog post](https://cesium.com/blog/2017/03/30/spatial-subdivision/).

### Generating the tiles

Once we have our data organization and know which city object must be batched together into the same tile, we can generate these tiles.

First, we select all the city objects of the tile to create in the database. Each tuple retrieved from the database will ultimately be a selectable element in the viewing application, so the SQL request has to be carefully crafted to allow the necessary granularity.

Afterwards, we use py3dtiles to generate the tile files. py3dtiles offers functions to convert data from a geospatial database to a 3D Tiles formats.

Additional details on our implementation of this step, especially what we do to retain the original semantic structure, is available [here](Devel/Design/DesignNote018.md).
