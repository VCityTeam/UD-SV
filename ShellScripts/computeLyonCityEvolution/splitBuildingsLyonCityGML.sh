# !/bin/sh

# This script splits the buildings of Lyon for a given year.
# It waits for the following parameters:
# $1: input-folder: a folder containing the CityGML data of all the borough
# of the city of Lyon for a given year like the one produced by the script
# ../data/downloadPatchLyonCityGML.sh
# $2 : year: year of the city of Lyon represented by the CityGML files.
# $3 : output-folder: the folder containing the output splitted files.
# $4 : Path to 3DUSE Build folder

# This script only works when invocated where it stands...
cd "$(dirname "$0")" || exit

# Check that parameters are correctly provided
if [ $# != 4 ]
  then
	  echo "Four parameters must be provided to this script: input folder (a folder containing the CityGML data of all the borough of the city of Lyon for a given year like the one produced by the script ../data/downloadPatchLyonCityGML.sh), year (of the city of Lyon represented by the CityGML files), the output folder and the path to 3DUSE build folder"
    exit 1
fi

mkdir $3

# Split buildings of all Lyon Borrough
${4}/src/utils/cmdline/splitCityGMLBuildings --input-file ${1}/LYON_1ER_${2}/LYON_1ER_BATI_${2}.gml --output-file LYON_1ER_BATI_${2}.gml --output-dir ${3}
${4}/src/utils/cmdline/splitCityGMLBuildings --input-file ${1}/LYON_2EME_${2}/LYON_2EME_BATI_${2}.gml --output-file LYON_2EME_BATI_${2}.gml --output-dir ${3}
${4}/src/utils/cmdline/splitCityGMLBuildings --input-file ${1}/LYON_3EME_${2}/LYON_3EME_BATI_${2}.gml --output-file LYON_3EME_BATI_${2}.gml --output-dir ${3}
${4}/src/utils/cmdline/splitCityGMLBuildings --input-file ${1}/LYON_4EME_${2}/LYON_4EME_BATI_${2}.gml --output-file LYON_4EME_BATI_${2}.gml --output-dir ${3}
${4}/src/utils/cmdline/splitCityGMLBuildings --input-file ${1}/LYON_5EME_${2}/LYON_5EME_BATI_${2}.gml --output-file LYON_5EME_BATI_${2}.gml --output-dir ${3}
${4}/src/utils/cmdline/splitCityGMLBuildings --input-file ${1}/LYON_6EME_${2}/LYON_6EME_BATI_${2}.gml --output-file LYON_6EME_BATI_${2}.gml --output-dir ${3}
${4}/src/utils/cmdline/splitCityGMLBuildings --input-file ${1}/LYON_7EME_${2}/LYON_7EME_BATI_${2}.gml --output-file LYON_7EME_BATI_${2}.gml --output-dir ${3}
${4}/src/utils/cmdline/splitCityGMLBuildings --input-file ${1}/LYON_8EME_${2}/LYON_8EME_BATI_${2}.gml --output-file LYON_8EME_BATI_${2}.gml --output-dir ${3}
${4}/src/utils/cmdline/splitCityGMLBuildings --input-file ${1}/LYON_9EME_${2}/LYON_9EME_BATI_${2}.gml --output-file LYON_9EME_BATI_${2}.gml --output-dir ${3}
