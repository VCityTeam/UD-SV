# !/bin/sh

# WARNING: This script must be placed in <path_to_3DCityDB-Importer-Exporter>/3dcitydb/postgresql/ to work. 

# This script drops a 3DCityDB database and creates a new one with the same
# name. It waits for the following  parameters: $1: database name and
# $2: database owner.  

# This script only works when invocated where it stands...
cd "$(dirname "$0")" || exit

# Check that parameters are correctly provided
if [ $# != 2 ]
  then
    echo "Two parameters must be provided to this script: database name and database owner"
    exit 1
fi

# Drop database
dropdb -U $2 $1

# Create empty database
# sudo su postgres
createdb -O $2 $1
# exit

# Add the postgis extension to the database
psql -d $1 -c 'create extension postgis;'

# Edit the database configuration
sed -e "s/PGUSER=.*$/PGUSER=${2}/" -e "s/CITYDB=.*$/CITYDB=${1}/" -i CREATE_DB.sh

# Run 3DCityDB CREATE_DB.sql script
psql -d ${1} -U ${2} -f CREATE_DB.sql 
