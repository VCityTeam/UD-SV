# Demo install guide : how to compute 3DTiles tileset and web visualize it

![3dTiles Lyon Demo](Images/Demo3dTilesLyon.png)
FIXME: provide a more recent image

The goal of this demo is to set up [this visualization](http://rict.liris.cnrs.fr/iTownsPlanar3DTiles/itowns/examples/planar_3dtiles.html) (FIXME provide an update of the online demo) i.e. to be able to navigate in 3D and ACROSS TIME among the buildings of a City (at the city scale)

Proceed with the following install guides
 - [Install a 3DCityDB database and populate it with data](Install3DCityDB.md) (follow the full install doc)
 - [Install the CityTiler component](https://github.com/MEPP-team/py3dtiles/blob/Tiler/Tilers/CityTiler/Install.md) and [generate the 3dTiles TEMPORAL tileset](https://github.com/MEPP-team/py3dtiles/blob/Tiler/Tilers/CityTiler/Install.md#5b-running-the-temporal-version-citytemporaltiler) (that is follow stage 5b but OMIT stage 5a)
 - Install a 3DTiles web server: depending on your context use
   * [3dtiles web server: DESKTOP developing context](Readme.md#backend-3dtiles-web-server-desktop-developing-context)
   * [3dtiles web server: OPERATIONS (stable server) context](Readme.md#backend-3dtiles-web-server-operations-stable-server-context)
 -  Intall and run the [UDV web client](Readme.md#frontend-udv-web-client-install-notes)
