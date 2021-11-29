
## LASzip
LASzip is part of [LAStools](http://lastools.org/) (edited by [Rapidlasso](http://rapidlasso.de/) which has
an exotic history (with his original developer 
[deported from the US](https://gis.stackexchange.com/questions/306418/difference-between-lastools-liblas-and-pdal) and 
[prematurly dead in 2021]([Rapidlasso](http://rapidlasso.de/))
  
Installation
  - On [Un*x](https://laszip.org/)
  - on OSX: start from [LASTools](https://lastools.github.io/):
       ```bash
       wget https://lastools.github.io/download/LAStools.zip
       unzip LAStools.zip
       cd LAStools
       make                               # Reported to work with clang version 11.0.0 on OSX 10.4.6 (Mojave)
       cp bin/laszip /usr/local/bin       # For example
       ```
    2. the longer way with [pdal](http://pdal.io/): `brew install pdal`
