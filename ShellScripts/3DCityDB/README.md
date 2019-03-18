__empty_3DCityDB.sh__

* The purpose of this script is to empty a 3DCityDB database. To do so, it drops
the 3DCityDB database and creates a new one with the same name.

* It waits for the following parameters:
    * database name
    * database owner

* It must be placed in <path_to_3DCityDB-Importer-Exporter>/3dcitydb/postgresql/
to work correctly.

* It only works for a emptying a local database

* You will be prompted by 3DCityDB to provide a SRID and corresponding SRS. If
you work with the data of Lyon, provide the following values:
    * When asked for `Please enter a valid SRID (e.g., 3068 for DHDN/Soldner Berlin):` , enter : `3946` (which is the standard coordinate system for Lyon)
    * When asked for `Please enter the corresponding SRSName to be used in GML exports (e.g., urn:ogc:def:crs, crs:EPSG::3068, crs:EPSG::5783):` , enter : `crs:EPSG::3946`
