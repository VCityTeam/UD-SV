# Compute Lyon city evolution in time

The entry point is the script `computeLyonCityEvolution.sh`. It allows for the
computation of the evolution of the city of Lyon from 2009 to 2015.

Expected output:
  * graphML-JSON files describing the transactions between features
  of the vintages. There is four graphML-JSON per borrough (two for 2009-2012:
  buildings and two for 2012-2015: buildings)

*Note: The different processes are described inside the scripts.*

## Prerequisites
Install [3DUSE](https://github.com/MEPP-team/3DUSE/blob/master/Install.md).

Note: if you fail on installing 3DUSE on your desktop,
[building the docker image](https://github.com/MEPP-team/3DUSE/blob/master/Docker/Readme.md) might be a plan B.

Note that the `buildingBlender` script installs [UD-Serv](https://github.com/MEPP-team/UD-Serv/)
and uses its `CityGMLBuildingBlender` util to integrate the remarkable buildings (see section usage).

## Usage:

Run the `computeLyonCityEvolution.sh` script which waits for an output folder,
for the path to 3DUSE Build folder and for a boolean which indicates if you
want to integrate remarkable buildings (true = with remarkable buildings and
false = without remarkable buildings).
Example: `computeLyonCityEvolution.sh LyonTemporalEvolution ./3DUSE/Build false`

*Note that integrating remarkable buildings still produces some undesirable
effects because they have specific geometric properties (such as holes) that are
poorly managed by the GDAL library used by extract_building_dates script...*
