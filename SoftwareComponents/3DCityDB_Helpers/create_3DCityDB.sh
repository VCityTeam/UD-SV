# !/bin/sh

# This script creates a local 3DCityDB database. It waits for the following
# parameters: $1: database name and $2: database owner.

# DISCLAIMER: 
#  * This script must be placed in 
#  <path_to_3DCityDB-Importer-Exporter>/3dcitydb/postgresql/ 
#  * Only works for a local database

# This script only works when invocated where it stands...
cd "$(dirname "$0")" || exit

# Check that parameters are correctly provided
if [ $# != 2 ]
  then
    echo "Two parameters must be provided to this script: database name and database owner"
    exit 1
fi

# Create empty database
# sudo su postgres
createdb -O $2 $1
# exit

# Add the postgis extension to the database
psql -d $1 -c 'create extension postgis;'

# Edit the database configuration
sed -e "s/PGUSER=.*$/PGUSER=${2}/" -e "s/CITYDB=.*$/CITYDB=${1}/" -i CREATE_DB.sh

# Run the CREATE_DB.sql helper script
psql -d ${1} -U ${2} -f CREATE_DB.sql
