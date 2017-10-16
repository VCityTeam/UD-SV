# Itowns architecture and related

## Ressources

[iTowns documentation](https://github.com/iTowns/itowns/blob/1f748406ba1213ee50e941876c3134686ae7e998/README.md)

## iTwons2 general presentation
### Structure
 * Based on Three.js
 * Used tools: 
   * npm (package manager for the dependencies), 
   * webpack (for packaging), 
   * babel (for ES6 compliance)

### Architecture of the client side(based on this [PR](https://github.com/iTowns/itowns2/pull/239) soon to be accepted)
 * `index.html` (taken a gateway)
   - will describe layers e.g. 
      * protocol:WMS
      * id: ...
      * culling: some_function()
      * initialization: another_funciton()
      * url:
   - such a layer is added to the scene (of the client):
      * a scene accepts various types of providers e.g. 3Dtiles is a provider ([example](https://github.com/iTowns/itowns2/blob/d660d9f3922de1cc279074ae4316c0fcfde51fd3/examples/layers/JSONLayers/Region.json)

 * Adding a layer object requires to define the above described attributes
 * There can be hierarchies of layers i.e. a layer that depends on another one

## Architecture

Software architecture schema:

![](Pictures/iTownsInternalArchitecture.jpg)

## Services

  * __Display a city__
    * Ins:
      * Several information about the data set (e.g. name, URL, protocol, srs, etc.)
      * Camera position
    * Outs:
      * 3D Rendering of the visible part of the given data set
   
  * __Display a city at a given date__
    * Ins:
      * Several information about the data set (e.g. name, URL, protocol, srs, etc.)
      * Camera position
      * Display date
    * Outs:
      * 3D Rendering of the visible part of the given data set at the display date

