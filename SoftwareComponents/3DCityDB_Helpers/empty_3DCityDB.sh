# !/bin/sh

# This script drops a 3DCityDB database and creates a new one with the same
# name. It waits for the following  parameters: $1: database name and
# $2: database owner.

# DISCLAIMER: 
#  * This script must be placed in 
#  <path_to_3DCityDB-Importer-Exporter>/3dcitydb/postgresql/ 
#  * Only works for a emptying a local database
#  * It is based on create_3DCityDB.sh which must also be placed in 
#  <path_to_3DCityDB-Importer-Exporter>/3dcitydb/postgresql/

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

# Recreate the database using create_3DCityDB script
./create_3DCityDB.sh $1 $2
