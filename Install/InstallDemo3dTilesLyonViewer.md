# Demo install guide : how to compute 3DTiles tileset and web visualize it 
The goal of this demo is to set up [this visualization](http://rict.liris.cnrs.fr/iTownsPlanar3DTiles/itowns/examples/planar_3dtiles.html) i.e. to be able to navigate in 3D among the buildings of a City (at the city scale)

Proceed with the following install guides
 - [Install a 3DCityDB database and populate it with data](Install/Install3DCityDB.md) (follow the full install doc)
 - [Install the CityTiler component](https://github.com/MEPP-team/py3dtiles/blob/Tiler/Tilers/CityTiler/Install.md) and [generate the 3dTiles tileset](https://github.com/MEPP-team/py3dtiles/blob/Tiler/Tilers/CityTiler/Install.md#5a-running-the-citytiler) (that follow stage 5a but OMIT stage 5b)
 - Install a 3DTiles web server: depending on your context use
   * [3dtiles web server: DESKTOP developing context](#backend-3dtiles-web-server-desktop-developing-context)
   * [3dtiles web server: OPERATIONAL (stable server) context](#backend-3dtiles-web-server-operational-stable-server-context)
 -  Intall and run the [UDV web client](#frontend-udv-web-client-install-notes)
