# 3DCityDB shell scripts

This folder contains shell scripts related to the usage of [3DCityDB](https://www.3dcitydb.org/3dcitydb/).
The following documentation lists those shell-scripts and, for each of them, provides a quick description as well as usage information.

### create_3DCityDB.sh

* The purpose of this script is to create a new __local__ 3DCityDB database.

* The script expects for the following parameters (as command line arguments):
    * database name
    * database owner.

* The script must be installed/placed in the directory
`<path_to_3DCityDB-Importer-Exporter>/3dcitydb/postgresql/` and **must be invocated where it stands** (that is the current working directory of invocation must be that directory).

* You will be prompted by 3DCityDB to provide a SRID and corresponding SRS. If
you work with the data of Lyon, provide the following values:
    * When asked for `Please enter a valid SRID (e.g., 3068 for DHDN/Soldner Berlin):` , enter : `3946` (which is the standard coordinate system for Lyon)
    * When asked for `Please enter the corresponding SRSName to be used in GML exports (e.g., urn:ogc:def:crs, crs:EPSG::3068, crs:EPSG::5783):` , enter : `crs:EPSG::3946`

### empty_3DCityDB.sh

* The purpose of this script is to empty a __local__ 3DCityDB database. To do
so, it drops the 3DCityDB database and creates a new one with the same name.

* The script expects for the following parameters (as command line arguments):
    * database name
    * database owner

* The script must be installed/placed in the directory
`<path_to_3DCityDB-Importer-Exporter>/3dcitydb/postgresql/`

* It is based on the create_3DCityDB.sh which must also be placed in
`<path_to_3DCityDB-Importer-Exporter>/3dcitydb/postgresql/`

* The script must be invocated where it stands (that is the current working directory of invocation must be the above described installation directory).

* You will be prompted by 3DCityDB to provide a SRID and corresponding SRS. If
you work with the data of Lyon, provide the following values:
    * When asked for `Please enter a valid SRID (e.g., 3068 for DHDN/Soldner Berlin):` , enter : `3946` (which is the standard coordinate system for Lyon)
    * When asked for `Please enter the corresponding SRSName to be used in GML exports (e.g., urn:ogc:def:crs, crs:EPSG::3068, crs:EPSG::5783):` , enter : `crs:EPSG::3946`
