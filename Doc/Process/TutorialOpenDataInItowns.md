## Install iTowns
 
After you install iTowns go on the file pointsCloud.js

## How to import data in iTowns

We take an example the island of Zanzibar, data from a drone.
you can download this [here](www.google.com]

We have 3 types of data 
 - Points Cloud in multiple [.las](http://desktop.arcgis.com/en/arcmap/10.3/manage-data/las-dataset/what-is-a-las-dataset-.htm) 
 - Orthophoto in one big image in png 
 - Elevation in Geotiff 
 

#### Points Cloud 

  You have to install [Potree Converter](https://github.com/potree/PotreeConverter), when you have this 
create a new folder, put the folder point_cloud from Zanzibar file (*.las) .

Write this in the new folder in your console:
```` PotreeConverter Zanzibar/Las/* -o Zanzibar/ --material RGB ````
(It can take time like ~2 3 min)

Now in your folder you should have that:


#### Orthophoto 

#### Elevation 
