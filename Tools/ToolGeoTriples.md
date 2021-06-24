## GeoTriples

[GeoTriples](http://geotriples.di.uoa.gr/) is a tool for transforming geospatial data from their original formats (e.g., shapefiles or spatially-enabled relational databases) into RDF. The following input formats are supported: spatially-enabled relational databases (PostGIS and MonetDB), ESRI shapefiles and XML, GML, KML, JSON, GeoJSON and CSV documents. 

[Wiki documentation](https://github.com/LinkedEOData/GeoTriples/wiki)

**WARNING** thus far testing with XML files is prone to `java.lang.OutOfMemoryError: Java heap space` exceptions. It is recommended to build GeoTriples from the source in order to have control over the memory usage of java.

### Download the binary
Requires Java Version >= 7
Download [here](http://geotriples.di.uoa.gr/downloads/geotriples-1.1.6-bin.zip)

### Local CLI Installation
Check out the GeoTriples [local installation instructions](https://github.com/LinkedEOData/GeoTriples#quickstart) on Github for more details
```
git clone https://github.com/LinkedEOData/GeoTriples.git
cd GeoTriples
mvn clean package
```

### Docker Installation
GeoTriples 1.1.6 is available as a docker container on DockerHub as a part of the KR-Suite

To start a container named _geotriples1_ using the current directory as a input/output volume (a different directory can be specified but one must be mounted to use the tool)
```
docker run --name geotriples1 -v $(pwd)/.:/inout gioargyr/krra-geotriples:tool
``` 
Once the container is running use the following commands to enter a shell inside the docker container
```
docker exec -it geotriples1 /bin/bash
```

### CLI Usage
When built from the source:
```
cd geotriples-core/target
java -cp "./dependency-jars/*:geotriples-core-<version>-SNAPSHOT.jar" eu.linkedeodata.geotriples.GeoTriplesCMD [Options] [Argument]
```
If memory errors occur, consider using the `-Xms[size]m` flag to declare the initial Java heao size.
When installed from the binary: 
```
cd bin
./geotriples-cmd [mode] [options] <source>|[mapping]
```
#### generate_mapping command
Used to generate mapping files for geospatial data sources

Use the mounted volume to move your geospatial data into the container's `/inout` folder. In the case of XML data (and consequently GML data), two files must be uploaded to create a mapping:
1. an XML datafile
2. an XSD schema defining the XML datafile's structure

The basic command for transforming the XML file is as follows:
```
./geotriples-cmd generate_mapping -o /inout/mapping.ttl -x /inout/[XSD file] /inout/[XML datafile]
```
