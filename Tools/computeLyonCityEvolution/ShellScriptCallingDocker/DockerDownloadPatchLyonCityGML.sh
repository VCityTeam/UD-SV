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
    echo "Two parameters must be provided to this script:"
    echo "  1. the vintage year (valid values are 2009, 2012 and 2015) and"
    echo "  2. the path to an output folder must be provided to this script."
    exit 1
fi

if [ $1 != 2009 -a $1 != 2012 -a $1 != 2015 ]
  then
    echo "Invalid year value. Valid values are: 2009, 2012 and 2015."
    exit 1
fi

run_docker() { 
  docker run \
    --mount src=`pwd`,target=/Output,type=bind \
    -t liris:collect_lyon_data \
    ${1} /Output/$2
}

run_docker LYON_1ER_${1}.zip  $2
run_docker LYON_2EME_${1}.zip $2
run_docker LYON_3EME_${1}.zip $2
run_docker LYON_4EME_${1}.zip $2
run_docker LYON_5EME_${1}.zip $2
run_docker LYON_6EME_${1}.zip $2
run_docker LYON_7EME_${1}.zip $2
run_docker LYON_8EME_${1}.zip $2
run_docker LYON_9EME_${1}.zip $2
run_docker BRON_${1}.zip      $2
run_docker VILLEURBANNE_.zip  $2

# Notice that the files are patched by the container ENTRYPOINT
# command (i.e. the script Collect-DockerContext/collect_data.sh)