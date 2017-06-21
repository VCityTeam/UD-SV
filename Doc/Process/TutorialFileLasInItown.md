
## Display a file .Las in Itowns with lopocs

Schema 1 

         [O]      ===========>   [O]   =============>   [O]
        Lopocs                 .las                    Display
        Install               in .json                on Itowns
        
### [Lopocs](https://github.com/Oslandia/lopocs#installation)

  When you install Lopocs ([here](https://github.com/Oslandia/lopocs#installation)) you have to install PDAL, take the branch lopocs [here](https://github.com/pblottiere/PDAL/tree/lopocs) (download and cmake, make, sudo make install).

  You should have that when you write 
  ````lopocs check````
  
  <img src="../Image/LopocsValidation.png" width="643" height="180" /> 
    
### .las in .json

  You have lopocs installed, so now take your .las if you don't have take it [here](https://oslandia.github.io/lopocs/).
  
  ````cd demos```` 
  
  ````lopocs load --work-dir . nameFile.las --table lopocs````
  
  <img src="../Image/lopocs2.png" width="1007" height="257" /> 
  
 

### Display on Itowns

  Now you have 3 files: your .las, the .json pipeline and the .json:
  
  
  Put the ....json on your server of itowns, me it's 3d-tiles-samples/tilesets ... 
  
  Now in this [example]() replace the url with your name of your tileset.
  
  And it's done.
  
  
  
  
  
