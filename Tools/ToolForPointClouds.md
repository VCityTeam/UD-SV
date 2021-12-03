# Tools for working on point clouds

## External references

 * [Lyon Métropole tutorial]( https://data.grandlyon.com/actualites/traitement-du-nuage-de-points-avec-des-outils-libres) (in french)

## Online tools

### Plas
[Plas.io](https://plas.io/)

### Lidarview
[Lidarview](http://lidarview.com/)

## Softwares

### [Entwine](https://entwine.io/)
[Entwine](https://entwine.io/) is self defined as "a data organization library for massive point clouds".

### LASzip
LASzip is part of [LAStools](http://lastools.org/) edited by [Rapidlasso](http://rapidlasso.de/) 
(Historical note: LAStools [original author Martin Isenbug](https://lidarmag.com/2021/10/30/in-memoriam-martin-isenburg-1972-2021/)
had quite
[an interesting history](https://gis.stackexchange.com/questions/306418/difference-between-lastools-liblas-and-pdal))
  
#### Installation
  - On [Un*x](https://laszip.org/)
  - on OSX: start from [LASTools](https://lastools.github.io/):
       ```bash
       wget https://lastools.github.io/download/LAStools.zip
       unzip LAStools.zip
       cd LAStools
       make                               # Reported to work with clang version 11.0.0 on OSX 10.4.6 (Mojave)
       cp bin/laszip /usr/local/bin       # For example
       ```

### [pdal](http://pdal.io/)

#### Installation
 - on OSX: alas `brew install pdal` is reported to fail on lang version 11.0.0 on OSX 10.4.6 (Mojave)


