## Install iTowns
 
After you install [iTowns](https://github.com/iTowns/itowns) go on this [fork and branch](https://github.com/NikoSaul/itowns2/tree/dataZanzibar)

for start the server, run with this command (for iTowns)

not: ```` npm start ```` == but ==> ```` npm start -- --port 7070````

## How to import data in iTowns

We take an example the island of Zanzibar, data from a drone.
you can download this [here](www.google.com)

Thanks to the ZMI project (Zanzibar Mapping Initiative) 

We have 3 types of data 
 - Points Cloud: multiple [.las](http://desktop.arcgis.com/en/arcmap/10.3/manage-data/las-dataset/what-is-a-las-dataset-.htm) 
 - Orthophoto: multiple image in .tif with .tfw for information
 - Elevation: multiple image in .tif with .tfw for information
 

### Points Cloud 

  You have to install [Potree Converter](https://github.com/potree/PotreeConverter), when you have this 
create a new folder and put the folder point_cloud from Zanzibar file (*.las) in.

In your console go on the new folder and:

```` PotreeConverter Zanzibar/Las/* -o Zanzibar/ --material RGB ````
(It can take time like ~2 3 min)

Now in your folder you should have that: (the format potree) 

<img src="../Image/tutoOpenData_folder.png" width="645" height="100" />

Copy the folder **data temp cloud.js and sources.json** in 3d-tiles-sample/tileset/Zanzibar/

In iTowns: 

**If you use the data from Zanzibar you don't have to do this. Only if you use other data...** 

Open the pointcloud.html, change the url [here](https://github.com/iTowns/itowns/blob/master/examples/pointcloud.html#L105)
with

````http://localhost:8003/tilesets/Zanzibar/cloud.js ````

Now you should have that: 

<img src="../Image/ZanzibarPointCloud.png"/>

### Orthophoto

#### Geoserver 

[install geoserver](http://docs.geoserver.org/stable/en/user/installation/linux.html) 

After that, go on this file /usr/share/geoserver/geoserver-2.11.2/webapps/geoserver/WEB-INF/
you should have web.xml, open this and uncomment this: 

````
<!-- Uncomment following filter to enable CORS -->
<filter>
  <filter-name>cross-origin</filter-name>
     <filter-class>org.eclipse.jetty.servlets.CrossOriginFilter</filter-class>
  </filter>
````

and

````
<!-- Uncomment following filter to enable CORS -->
<filter-mapping>
    <filter-name>cross-origin</filter-name>
    <url-pattern>/*</url-pattern>
</filter-mapping>
````
 
Next, 
download [this](http://repo1.maven.org/maven2/org/eclipse/jetty/jetty-servlets/9.2.13.v20150730/jetty-servlets-9.2.13.v20150730.jar)
and put it on this folder: /usr/share/geoserver/geoserver-2.11.2/webapps/geoserver/WEB-INF/lib/

Now go [**Geoserver**](http://localhost:8080/geoserver).

login : admin

mdp: geoserver

Check the [documentation](http://docs.geoserver.org/) if you want to understand each menu.

<img src="../Image/data.png" width="200" height="150" />

To begin, add a new workspace

<img src="../Image/workspace.png" width="514" height="216" />

And submit... then click on Zanzibar and check the boxes for WMS and WMTS

Go on Disk Quota on your left and complet like that:

<img src="../Image/diskquota.png" width="500" height="300" />

And go on Gridsets just above Disk quota,
Create a new gridset...

<img src="../Image/gridset2.0.png" width="627" height="437" />

Then click on Caching Defaults just above gridsets,
like this: 

<img src="../Image/cachingDefaults.png" width="750" height="450" />

Don't forget to add the gridset EPSG:32737 on the bottom.

Click on BlobStores and add new.

<img src="../Image/blob.png" width="500" height="400" />

Now add new Store, 
take the imageMosaic, and do this:

<img src="../Image/stores.png" width="500" height="400" />

And save.

Now you should have the page 'Edit Layer',
Change the name and the title (like Zanzibar_Layer_orthophoto), then check the Native SRS is correct.

If you have other data you have to change that [here](https://github.com/NikoSaul/itowns2/blob/dataZanzibar/examples/pointcloud.js#L20) in iTowns, pointsCloud.js file.
(this values can be find [here](http://spatialreference.org/) you search your EPSG and you click on Proj4js format) 
the EPSG: and the [values](https://github.com/NikoSaul/itowns2/blob/dataZanzibar/examples/pointcloud.js#L26) with the native bounding box, you can see it on the geoserver.

[here](https://github.com/NikoSaul/itowns2/blob/dataZanzibar/examples/pointcloud.js#L113) you have to change the name with the name of your layer same for the projection: [EPSG](https://github.com/NikoSaul/itowns2/blob/dataZanzibar/examples/pointcloud.js#L114). 

Click on Publishing on the top.
Add Raster like that : 

<img src="../Image/raster.png" width="650" height="200" />

Then click on the top **Tile Caching**:

<img src="../Image/blobLayer.png" width="522" height="701" />

and add your grid subset on the bottom of this page
- - - - - - -
You should have in the **Tile Layers**, Zanzibar:Zanzibar_Layer.

Click on seed/Truncate: 

<img src="../Image/taskgwc.png" width="501" height="366" />

and submit.

It can take quite some time... like 5 minute.

and you have this result: 

<img src="../Image/pointcloudOrtho.png" width="1213" height="914" />

### Elevation

It's the same process as for the orthophoto (i use the big file .tif here /Zanzibar/001_final/3_dsm_ortho/1_dsm/)

But you should resize the .tif with [gdalwarp](http://www.gdal.org/gdalwarp.html) like that :

````gdalwarp -tr 0.25 0.25 001_final_dsm.tif zanziReduce.tif````


#### [video](https://www.dropbox.com/s/aer9t0x4db744s2/videotestGeoserver.mp4?dl=0)

#### Problem and Conclusion

Like you see in this video, they have some lag, i think it's because the wmts are not managed. 
We have probleme with the elevation because when you remove the pointcloud you see this: 

<img src="../Image/problemEleve.png" width="1213" height="914" />

This is a problem of interpolation but i don't why.

So for the orthophoto the problem solve with the wmts probaly.
For the elevation maybe when we reduce the image the problem appears (but it's not working with the big image).


