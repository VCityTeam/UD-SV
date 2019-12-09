## Task accomplished 

  * **3DTiles**: 
    * Bounding volume implementation for regions and sphere
    * The option [Viewer request Volume](https://github.com/AnalyticalGraphicsInc/3d-tiles#spec-status): done
    * Add early support for 3Dtiles [point cloud](https://github.com/AnalyticalGraphicsInc/3d-tiles#spec-status) format.
    * [RTC manage](../Process/iTowns3Dtiles.md) for b3dm and pnts
    * Manage the Batch ID in iTowns and GLTF
    * Manage the [Batch table](https://github.com/AnalyticalGraphicsInc/3d-tiles) and the picking (when you selection a building you have the information about them)    
    
  * **iTowns**
    * Fix some bug with transformation
    * UI for example 3DTiles
 
  * **Temporel** 
    * Creation of [Need](../Needs)
    * Creation of [designNote](../Design/DesignNote017.md) and [this](../Design/DesignNote021.md) for implementation.  
    * Early implementation both side (server and client)
  
  * **Data from [UAV](https://en.wikipedia.org/wiki/Unmanned_aerial_vehicle)** ( Unmanned_aerial_vehicle ): Find a solution for read [the heterogeneous data](../Process/TutorialOpenDataInItowns.md)
    * Read the points cloud from drone data in iTowns
    * Read the orthophoto from drone data in iTowns
    * Read the elevation from drone data in iTowns
    * Try Geoserver for hosting the ortho and elevation

## Global

  * Documentation 
    * [3DTiles](../Process/iTowns3Dtiles.md): pnts in iTowns and other feature.
    * [Lopocs](../Process/TutorialFileLasInItown.md): tutorial for how the server Lopocs works in iTowns
    * [Data From drone](../Process/TutorialOpenDataInItowns.md) in iTowns

  * [Needs](https://github.com/MEPP-team/RICT/tree/master/Doc/Devel/Needs)

  * Some issue fix or contribute in iTowns ([issue 414](https://github.com/iTowns/itowns/issues/414), [issue 185](https://github.com/iTowns/itowns/issues/185),...)

  * Some help to the temporal implementation. 
