## GeoTriples

[GeoTriples](http://geotriples.di.uoa.gr/) is a tool for transforming geospatial data from their original formats (e.g., shapefiles or spatially-enabled relational databases) into RDF. The following input formats are supported: spatially-enabled relational databases (PostGIS and MonetDB), ESRI shapefiles and XML, GML, KML, JSON, GeoJSON and CSV documents. 

[Wiki documentation](https://github.com/LinkedEOData/GeoTriples/wiki)

**WARNING** thus far testing with XML files is prone to `java.lang.OutOfMemoryError: Java heap space` exceptions. It is recommended to transform shapefiles instead as this appear to be less buggy after testing (as of 29/06/2021).

Also note that when building GeoTriples from the source, JDK 11 is unsupported. Use at most JDK 10.

### Docker Installation
GeoTriples 1.1.6 is available as a docker container on DockerHub as a part of the KR-Suite

To start a container named _geotriples1_ using the current directory as a input/output volume (a different directory can be specified but one must be mounted to use the tool)
```
docker run --name geotriples1 -d -v $(pwd):/inout gioargyr/krra-geotriples:tool
``` 
Once the container is running use the following commands to enter a shell inside the docker container
```
docker exec -it geotriples1 bash
```

### CLI Usage
To display usage:
```
./geotriples-cmd
```
Use the mounted volume to move your geospatial data into the container's `/inout` folder.

Creating triples from a shapefile is done in two steps:
1. [generate a mapping file](#generate_mapping-command)
2. [transform data](#dump_rdf-command)

#### generate_mapping command
This command is used to generate mapping files for geospatial data sources

The basic command for creating a mapping file called `mapping.ttl` is as follows:
```
./geotriples-cmd generate_mapping -o /inout/mapping.ttl -b [base URI or namespace] /inout/[shapefile]
```

#### dump_rdf-command
This command is used to transform a geospatial data source into RDF based on a mapping file

The basic command for transforming the shapefile is as follows:
```
./geotriples-cmd dump_rdf -o /inout/out.ttl -f TURTLE -b [base URI or namespace] -sh /inout/[shapefile] /inout/mapping.ttl
```
The output will be written to `out.ttl`
