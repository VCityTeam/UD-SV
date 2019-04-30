# !/bin/sh

# This script :
# * detects the changes between CityGML files representing the
# buildings and remarkable buildings of the city of Lyon at two different
# vintages and outputs the changes as graphML-JSON files.
# * Create three empty 3DcityDB databases

# Awaited parameter: output folder.

# Compute Lyon compute Lyon evolution from 2009 to 2015
./../computeLyonCityEvolution/computeLyonCityEvolution.sh ${1}

# Create three 3DCityDB databases (one for each year)
# Note: What happens if the databases already exists ?
./../3DCityDB/create_3DCityDB.sh Lyon_2009 citydb_user
./../3DCityDB/create_3DCityDB.sh Lyon_2012 citydb_user
./../3DCityDB/create_3DCityDB.sh Lyon_2015 citydb_user
