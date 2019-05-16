# Compute Lyon city evolution in time

The entry point is the script `computeLyonCityEvolution.sh`. It allows for the
computation of the evolution of the city of Lyon from 2009 to 2015.

Expected output:
  * graphML-JSON files describing the transactions between features
  of the vintages. There is four graphML-JSON per borrough (two for 2009-2012:
  buildings and two for 2012-2015: buildings)

*Note: The different processes are described inside the scripts.*
*Disclaimer: Remarkable buildings are not considered*

## Prerequisites

 * Install the
[EBO's ChangeDetection branch of 3DUSE](https://github.com/EricBoix/3DUSE/tree/ChangeDetection)
 in this directory by following this
[3DUSE install guide](https://github.com/EricBoix/3DUSE/blob/ChangeDetection/Install.md)

  * [Install 3DCityDB](https://github.com/MEPP-team/RICT/blob/master/Install/Install3DCityDB.md)

## Usage:

Run the `computeLyonCityEvolution.sh` script which waits for an output folder
and for the path to 3DUSE Build folder.
Example: `computeLyonCityEvolution.sh LyonTemporalEvolution ./3DUSE/Build`
