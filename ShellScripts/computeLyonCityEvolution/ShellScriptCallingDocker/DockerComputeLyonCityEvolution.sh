# !/bin/sh

# This script detects the changes between CityGML files representing the
# buildings of the city of Lyon at two different vintages and outputs the
# changes as graphML-JSON files.

# Awaited parameters:
# * output folder for the intermdiate data and for the final result.

# This script only works when invocated where it stands...
cd "$(dirname "$0")" || exit

# Check that parameters are correctly provided
if [ $# != 1 ]
  then
	  echo "Awaited parameters: output folder."
    exit 1
fi

# Create output directory
mkdir ${1}

pushd ../Docker/
docker build -t liris:collect_lyon_data Collect-DockerContext
docker build -t liris:3DUse 3DUse-DockerContext
popd

if false; then
# Download the data of the city of Lyon in 2009, 2012 and 2015 from the
# [Data Grand Lyon open portal](https://data.grandlyon.com/) and patch the
# errors in the files (e.g. buildings with empty geometry and textures with
# wrong coordinates).
./DockerDownloadPatchLyonCityGML.sh 2009 ${1}/Lyon_2009
./DockerDownloadPatchLyonCityGML.sh 2012 ${1}/Lyon_2012
./DockerDownloadPatchLyonCityGML.sh 2015 ${1}/Lyon_2015

# Split the buildings of 2009 and 2012 (2015 don't need splitting as the
# original buildings are already "splitted")
./DockerSplitBuildingsLyonCityGML.sh ${1}/Lyon_2009 2009 ${1}/Lyon_2009_Splitted
./DockerSplitBuildingsLyonCityGML.sh ${1}/Lyon_2012 2012 ${1}/Lyon_2012_Splitted

# Extract buildings of 2015 from original GrandLyon folders organization
mkdir ${1}/Lyon_2015_Splitted
cp ${1}/Lyon_2015/LYON_1ER_2015/LYON_1ER_BATI_2015.gml ${1}/Lyon_2015_Splitted
cp ${1}/Lyon_2015/LYON_2EME_2015/LYON_2EME_BATI_2015.gml ${1}/Lyon_2015_Splitted
cp ${1}/Lyon_2015/LYON_3EME_2015/LYON_3EME_BATI_2015.gml ${1}/Lyon_2015_Splitted
cp ${1}/Lyon_2015/LYON_4EME_2015/LYON_4EME_BATI_2015.gml ${1}/Lyon_2015_Splitted
cp ${1}/Lyon_2015/LYON_5EME_2015/LYON_5EME_BATI_2015.gml ${1}/Lyon_2015_Splitted
cp ${1}/Lyon_2015/LYON_6EME_2015/LYON_6EME_BATI_2015.gml ${1}/Lyon_2015_Splitted
cp ${1}/Lyon_2015/LYON_7EME_2015/LYON_7_BATI_2015.gml ${1}/Lyon_2015_Splitted/LYON_7EME_BATI_2015.gml
cp ${1}/Lyon_2015/LYON_8EME_2015/LYON_8EME_BATI_2015.gml ${1}/Lyon_2015_Splitted
cp ${1}/Lyon_2015/LYON_9EME_2015/LYON_9EME_BATI_2015.gml ${1}/Lyon_2015_Splitted

# DockerExtractBuildingDates detects changes between two vintages of the city
./DockerExtractBuildingDates.sh 2009 ${1}/Lyon_2009_Splitted 2012 ${1}/Lyon_2012_Splitted ${1}/final_output
fi
./DockerExtractBuildingDates.sh 2012 ${1}/Lyon_2012_Splitted 2015 ${1}/Lyon_2015_Splitted ${1}/final_output
