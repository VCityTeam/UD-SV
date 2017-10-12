# Itowns architecture and related

## Ressources

[iTowns documentation](https://github.com/iTowns/itowns/blob/1f748406ba1213ee50e941876c3134686ae7e998/README.md)

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

