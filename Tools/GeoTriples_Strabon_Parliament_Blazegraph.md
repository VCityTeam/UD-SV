# Comparison of different triple stores/Query Engines
This page documents different triple stores and SPARQL endpoints and explores their limitations and relevance in UD-SV.

## GeoTriples
* **Repository**: https://github.com/LinkedEOData/GeoTriples
* **Programming languages**: Java
* **Support for spatio-temporal queries**: 
* **Licence**: Apache-2.0 License 
* **Features**: 
  * Converts shapefiles to RDF
  * GML to RDF (very buggy and not enough documentation)
* **Extensions to support spatio-temporal queries**:
  * Supports GeoSPARQL constructs
* **Query languages**: ODBA queries?

## Strabon
* **Repository**: http://hg.strabon.di.uoa.gr/Strabon/
* **Programming languages**: Java
* **Licence**: Mozilla Public License Version 2.0
* **Support for spatio-temporal queries**:
  * GeoSPARQL
  * stRDF/stSPARQL
* **Features**: 
     * Triple store 
     * SPARQL endpoint
     * Visualization of geospatial data on a 2D map
     * Contains quad visualisations (for example visualizing triples on a timeseries)
     * High query performance TODO:add link
* **Extensions to support spatio-temporal queries**: 
    * [PostgreSQL-Temporal](http://github.com/jeff-davis/PostgreSQL-Temporal) for temporal queries
* **Query languages**: SPARQL+stSPARQL

## Parliament
* **Repository**: https://github.com/SemWebCentral/parliament
* **Programming languages**:
  * Java
* **Support for spatio-temporal queries**:
  * Geospatial only (GeoSPARQL)
* **Licence**:  BSD-3-Clause License 
* **Features**:
  * Triple store
  * SPARQL endpoint
  * Geospatial index
  * Query rewriting
* **Extensions to support spatio-temporal queries**:
* **Query languages**:
  * ARQ
  * SPARQL

## Blazegraph
* **Repository**: https://github.com/blazegraph/database
* **Programming languages**: 
* **Support for spatio-temporal queries**:
* **Licence**: 
* **Features**: 
* **Extensions to support spatio-temporal queries**:
* **Query languages**: 

## Neo4j
* **Repository**: https://github.com/neo4j/neo4j
* **Programming languages**: Java
* **Support for spatio-temporal queries**:
* **Licence**: GNU GENERAL PUBLIC LICENSE
* **Features**: 
* **Extensions to support spatio-temporal queries**:
* **Query languages**: Cypher

## Virtuoso
* **Repository**: https://github.com/openlink/virtuoso-opensource
* **Programming languages**: 
* **Support for spatio-temporal queries**:
* **Licence**: 
* **Features**: 
* **Extensions to support spatio-temporal queries**:
* **Query languages**:

## Twinkle
* **Repository**: 
    * http://ldodds.com/projects/twinkle/
* **Programming languages**: Java
* **Support for spatio-temporal queries**:
* **Licence**: GNU public license
* **Features**: Simple to setup and use
* **Extensions to support spatio-temporal queries**:
* **Query languages**:
  * SPARQL
  * ARQ

# References
* Immersing evolving geographic divisions in the semantic Web, PhD Thesis 2019, Camille Bernard

# Other documentation
* DVA internship notes: [SPARQL Query Tools](UD-Graph_SPARQ_Editors)GeoTriples_Strabon_Parliament_Blazegraph.md
