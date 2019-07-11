# !/bin/sh

# This script downloads the CityGML data representing the whole city of Lyon in
# the year provided in the first argument and removes errors present in the downloaded
# files.
# It waits for two parameters:
#    $1: the year when to load the data. Valid values are: 2009, 2012 or 2015.
#    $2: the path to an output folder as parameter.

# This script only works when invocated where it stands...
cd "$(dirname "$0")" || exit

# Check that parameters are correctly provided
if [ $# != 2 ]
  then
    echo "Two parameters must be provided to this script: the year at when to load the data (valid values are 2009, 2012 and 2015) and the path to an output folder must be provided to this script."
    exit 1
fi

if [ $1 != 2009 -a $1 != 2012 -a $1 != 2015 ]
  then
    echo "Invalid year value. Valid values are: 2009, 2012 and 2015."
    exit 1
fi

# Create output folder
mkdir $2
cd $2

# Download, unzip and rm zip for each borrough
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_1ER_${1}.zip
unzip LYON_1ER_${1}.zip
rm LYON_1ER_${1}.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_2EME_${1}.zip
unzip LYON_2EME_${1}.zip
rm LYON_2EME_${1}.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_3EME_${1}.zip
unzip LYON_3EME_${1}.zip
rm LYON_3EME_${1}.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_4EME_${1}.zip
unzip LYON_4EME_${1}.zip
rm LYON_4EME_${1}.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_5EME_${1}.zip
unzip LYON_5EME_${1}.zip
rm LYON_5EME_${1}.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_6EME_${1}.zip
unzip LYON_6EME_${1}.zip
rm LYON_6EME_${1}.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_7EME_${1}.zip
unzip LYON_7EME_${1}.zip
rm LYON_7EME_${1}.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_8EME_${1}.zip
unzip LYON_8EME_${1}.zip
rm LYON_8EME_${1}.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_9EME_${1}.zip
unzip LYON_9EME_${1}.zip
rm LYON_9EME_${1}.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/BRON_${1}.zip
unzip BRON_${1}.zip
rm BRON_${1}.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/VILLEURBANNE_${1}.zip
unzip VILLEURBANNE_${1}.zip
rm VILLEURBANNE_${1}.zip

# Patch the files to remove inconsistencies, allowing to avoir problems to any
# geometric post-treatments. Patches include removal of buildings having an
# empty geometry and change of invalid texture coordinates values.
if [ $1 == 2009 ]
  then
    # Remove the full block describing the building
    # <bldg:Building gml:id="LYON_7EME_00110">
    sed -e '3065366,3065392d' -i LYON_7EME_2009/LYON_7EME_BATI_2009.gml
    # Remove the full blocks describing the buildings
    # <bldg:Building gml:id="LYON_8_00166"> and
    # <bldg:Building gml:id="LYON_8_00177">
    sed -e '1202763,1202789d' -e '1202791,1202817d' -i LYON_8EME_2009/LYON_8EME_BATI_2009.gml
    # Rename Lyon 4 and Lyon 5 buildings files for consistency with other
    # borroughs
    mv LYON_4EME_2009/LYON_4_BATI_2009.gml LYON_4EME_2009/LYON_4EME_BATI_2009.gml
    mv LYON_5EME_2009/LYON_5_BATI_2009.gml LYON_5EME_2009/LYON_5EME_BATI_2009.gml
fi

if [ $1 == 2012 ]
  then
    cd LYON_7EME_2012
    # remove the full block describing the building
    # <bldg:Building gml:id="LYON_7EME_00215">
    sed -e '2752390,2752416d' -i LYON_7EME_BATI_2012.gml
    cd ../LYON_8EME_2012
    # Replace occurences of -1.#IND00 in line 1099147
    # (they do not represent a valide double) with a
    # valid double e.g. -1.00
    sed -e '1099147s/#IND00/00/g' -i LYON_8EME_BATI_2012.gml
fi
