## How to install demos out of their integrated components<a name="top"></a>
The [UD-SV web based online demos](http://rict.liris.cnrs.fr/index.html) regroup a set of specific demos that illustrate various visualizations/applications on top city related data. Each such demo is achieved by integrating some ad-hoc subset of [free and open available software components](../Tools/) (refer to the [architecture](../Architecture/Readme.md)).

The following documentation considers each specific demo and for each one explains
  - **which required components** should be installed: **don't install all the components** but stick to the _SUBSET_ required for the demo you are trying to replicate (taken among [all the available components](../Tools/))
  - **how to install such components** and
  - **how to assemble/integrate such components** in order to obtain a fully functionnal demo

Once your chosen demo is installed feel free to experiment with it, extend it and/or customize it to suit your needs.

## Installing demos
### <a name="install-demo-udv-front-end"></a>[UD-Viz-demo](https://github.com/VCityTeam/UD-Viz-demo) (just the front end)
 * What you get: something similar to [this demo of the UD-Viz front end](http://rict.liris.cnrs.fr/UDVDemo/UDV/UDV-Core/examples/DemoFull/Demo.html) that illustrates enables you to discover the front end features (e.g. [UD-Viz/Geocoding](../Tools/)). However, because you are not (yet) installing any of server-side components, you will **not** be able to use the features requiring some server-side document management (e.g. [Guided Tour](../Tools/) or [Authentication](../Tools/)).
  * [Installation notes](https://github.com/VCityTeam/UD-Viz-demo/blob/master/README.md)

### UD-Viz-demo (front end) together with [UD-Serv/API_Enhanced_City](../Tools/) (back-end)
 * What you get:
   - you can [run demo this demo](http://rict.liris.cnrs.fr/UDVDemo/UDV/UDV-Core/examples/DemoFull/Demo.html) on your desktop i.e. you will be able to run **both client-side and server-side locally** (on your desktop) as opposed to the [UD-Viz front end previous install demo](#installing-components) where only the client-side was deployed locally (and the server side was running online on UD-SV's demo server)
   - note that the server-side component uses a [PostGreSQL database](https://en.wikipedia.org/wiki/PostgreSQL) used to power components like Consult documentation, Guided Tour, Authentification, Documents to validate and Document Links_.
 * Installation:
    - first follow [UD-Viz front end install notes](#installing-components)
    - then [UD-Serv/API_Enhanced_City install notes](https://github.com/MEPP-team/UD-Serv/blob/master/API_Enhanced_City/INSTALL.md) that enable you to install some of the server-side components on your computer.

### Computing 3DTiles **temporal** tilesets and web visualize them:
[installation notes](https://github.com/VCityTeam/UD-Reproducibility/tree/master/Demos/Temporal-LyonMetropole)
### [TBD](https://en.wikipedia.org/wiki/TBD_(disambiguation))
How to install (document) Enhanced City demo

## Installing [components](../Tools/)
 * Frontend
   - [UD-Viz](../Tools/) web client: [install notes](https://github.com/VCityTeam/UD-Viz/blob/master/Readme.md) ([associated demos](http://rict.liris.cnrs.fr/UDVDemo-2/UDV/UDV-Core/))
 * Backend
   - [3DCityDB](../Tools/): refer to the [install notes](Install3DCityDB.md).
   - [CityTiler](../Tools/): refer to the [install notes](https://github.com/VCityTeam/py3dtiles/tree/Tiler)
   - [UD-Serv/API_Enhanced_City](../Tools/): refer to the [install notes](https://github.com/VCityTeam/UD-Serv/blob/master/API_Enhanced_City/INSTALL.md)
   - [3DTiles Samples](../Tools/)(server):
     * <a name="backend-3dtiles-web-server-desktop-developing-context"></a>[DESKTOP developing context install notes](https://github.com/VCityTeam/UD-Reproducibility/tree/master/Computations/3DTiles/LyonTemporal/PythonCallingDocker#readme) or
