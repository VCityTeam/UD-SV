#!/bin/bash
# This script downloads the designated CityGML archive files from Lyon
# Metropole open data repository, extracts the files of the form 
# *BATI*.gml and when necessary applies some  ad-hoc fixes on well
# known inconsistancies.
# $1: the filename to retrieved
# $2: the resulting directory where to place the retrieved files

if [ ! -d ${2} ]
then
   mkdir ${2}
fi
cd ${2}

repository="https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/"
filename=${repository}${1}
echo "Fetching file: ${filename}"
wget -q ${filename}
echo "Fetching done."
echo "Unziping archive:"
unzip -q ${1} *BATI*.gml
echo "Unziping done."
rm ${1}

# Patch the files to remove inconsistencies, allowing to avoir problems to any
# geometric post-treatments. Patches include removal of buildings having an
# empty geometry and change of invalid texture coordinates values.
if [ ${1} == "LYON_4EME_2009.zip" ]
then
  # Rename buildings files for consistency with other borroughs
  echo "Renaming file LYON_4_BATI_2009.gml"
  mv LYON_4EME_2009/LYON_4_BATI_2009.gml LYON_4EME_2009/LYON_4EME_BATI_2009.gml
fi

if [ ${1} == "LYON_5EME_2009.zip" ]
then
  echo "Renaming file LYON_5_BATI_2009.gml"
  mv LYON_5EME_2009/LYON_5_BATI_2009.gml LYON_5EME_2009/LYON_5EME_BATI_2009.gml
fi

if [ ${1} == "LYON_7EME_2009.zip" ]
then
  # Remove the full block describing the building
  # <bldg:Building gml:id="LYON_7EME_00110">
  echo "Patching file LYON_7EME_BATI_2009.gml"
  sed -e '3065366,3065392d' -i LYON_7EME_2009/LYON_7EME_BATI_2009.gml
  echo "Patching done."
fi

if [ ${1} == "LYON_8EME_2009.zip" ]
then
  # Remove the full blocks describing the buildings
  # <bldg:Building gml:id="LYON_8_00166"> and
  # <bldg:Building gml:id="LYON_8_00177">
  echo "Patching file LYON_8EME_2009.gml"
  sed -e '1202763,1202789d' -e '1202791,1202817d' -i LYON_8EME_2009/LYON_8EME_BATI_2009.gml
  echo "Patching done."
fi

if [ ${1} == "LYON_7EME_2012.zip" ]
then
  # remove the full block describing the building
  # <bldg:Building gml:id="LYON_7EME_00215">
  echo "Patching file LYON_7EME_2012.gml"
  sed -e '2752390,2752416d' -i LYON_7EME_2012/LYON_7EME_BATI_2012.gml
  echo "Patching done."
fi

if [ ${1} == "LYON_8EME_2012.zip" ]
then
  # Replace occurences of -1.#IND00 in line 1099147
  # (they do not represent a valide double) with a
  # valid double e.g. -1.00
  echo "Patching file LYON_8EME_2012.gml"
  sed -e '1099147s/#IND00/00/g' -i LYON_8EME_2012/LYON_8EME_BATI_2012.gml
  echo "Patching done."
fi

echo "Collect_data.sh done."
