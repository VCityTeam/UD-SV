
## Display a file .Las in iTowns with lopocs

  This diagram shows how the communication between iTowns and lopocs works:
  
  <img src="../Image/diapo2Sevimg26.png" width="900" height="175" />

  In a first step we put our file (.las here) on the lopocs's server, then lopocs gives us a tileset, the tileset is used by iTowns's server, and both servers communicate when iTowns needs files.

  <img src="../Image/Lopocs Schema1.png" width="900" height="175" />
  
### [Lopocs](https://github.com/Oslandia/lopocs#installation)

  When you install Lopocs ([here](https://github.com/Oslandia/lopocs#installation)) you have to install PDAL, take the branch lopocs [here](https://github.com/pblottiere/PDAL/tree/lopocs) (download and cmake, make, sudo make install).

  You should have this when you write ````lopocs check````
  
  <img src="../Image/LopocsValidation.png" width="643" height="180" /> 
    
### file .las in tileset

  You have lopocs installed, so now take your .las (if you don't have take it [here](https://oslandia.github.io/lopocs/)).
  
  ````cd demos```` 
  
  ````lopocs load --work-dir . nameFile.las --table lopocs````
  
  <img src="../Image/tutolopocs.png" width="1007" height="257" /> 
  
 

### Display on iTowns

  Now you have 3 files: your .las, the .json pipeline and the .json:
  
  <img src="../Image/tutolopocs2.png" width="443" height="118" /> 
  
  Put the tileset-public.lopocs.points.json on your server of iTowns, for me the path 3d-tiles-samples/tilesets ... 
  
  Now in this [example](https://github.com/iTowns/itowns2/blob/master/examples/3dtiles.html) replace the url with the name of your tileset.
  
  And it's done, you can view your .las in Itown.
 
  Example: 
   <img src="../Image/screenLopocs2.png" width="1616" height="805" />
  
### Optimisation 

  Right now we can't read multiple .las in the same time just one by one, we expect PDAL to optimize that.
  
  For iTowns when you have a lot of point, there is some lag, we can optimize that too.
  
### References

 * The git [lopocs](https://github.com/Oslandia/lopocs#installation)  
  
  
  
