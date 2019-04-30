# Create 3D Tiles temporal representing Lyon city evolution in time

This document explains the steps to follow to compute the evolution of the city
of Lyon from 2009 to 2015 and to output the result as 3D Tiles + temporal
extension files.

*Note: The different processes are described inside the scripts.*

## Prerequisites

 * Install the
[EBO's working branch of 3DUSE](https://github.com/EricBoix/3DUSE/tree/ChangeDetection)
 in this directory by following this
[3DUSE install guide](https://github.com/EricBoix/3DUSE/blob/ChangeDetection/Install.md)

 * [Install 3DCityDB](https://github.com/MEPP-team/RICT/blob/master/Install/Install3DCityDB.md)

## Usage:

* Run the `createLyon3DTilesTemporal.sh` script which waits for an output folder
as parameter. Example: `createLyon3DTilesTemporal.sh outputTemporalGraph`. This
script ....
* Import Splitted citygml files
* run py3dtiles (script ?)
