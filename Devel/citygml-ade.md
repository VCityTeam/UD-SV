# CityGML ADEs

CityGML is used to represent urban information, especially the information related to various city objects like buildings, bridges, vegetation, road infrastructure etc. However, not all information are covered by CityGML. Hence, there are two possible ways of CityGML extensions:

1.  *Generic attributes and objects*
2.  *ADE (Application Domain Extension)*

## Generic attributes and objects
The CityGML classes *GenericCityObject* and *_genericAttribute* can be extended to introduce new *generic objects* and *generic attributes*.

An extended generic attribute may belong to any of the following data types: string, integer, double (floating point number), date, URI or a measure (*gml:MeasureType*). It is also possible to create complex generic attribute by making use of *genericAttributeSet*, which in itself is a generic attribute.  

Generic objects can be created by extending *GenericCityObject* that has three attributes: *class*, *function* and *usage*. *GenericCityObject* may also have explicit geometry or/and *ImplicitGeometry* (useful for specifying prototypical geometry of objects like trees, traffic lights etc.). And it is also possible to specify the intersections between the explicit geometry of the generic object with the digital terrain model.

One major limitation of using these attributes is the difficulty in validating the extended data. Domain experts may propose names, data types and cardinality information of the extended generic objects and attributes. However, the CityGML parser may not have this additional information and hence, it is impossible to verify whether the data types/cardinality information is respected in the instances of generic objects/attributes. This is where ADE comes into picture.

The conceptual model of *GenericCityObject* and *_genericAttribute* is given below [[Page 164, OGC 12-019]](https://portal.ogc.org/files/?artifact_id=47842):

![image](https://user-images.githubusercontent.com/8275121/150536248-a1cf2408-1a67-4e53-9f44-f4999b7e099b.png)


## ADE (Application Domain Extension)
 ADE or Application Domain Extension helps domain experts to extend CityGML for representing relevant information related to their domains in an interoperable manner. These domain extensions and the associated data could be easily shared to build a more enriched model. However these possible extensions must respect some conditions. This document will explain how the ADE mechanism works in CityGML.

Some helpful knowledge you should be a little familiar with before reading:
- [Wikipedia: Unified Modeling Lanugage](https://en.wikipedia.org/wiki/Unified_Modeling_Language)
- [What is XML Schema (XSD)?](https://docs.microsoft.com/en-us/previous-versions/windows/desktop/ms765537%28v=vs.85%29)

Some helpful OGC vocabulary:
- **Conceptual Model**: A highly conceptual - and often human friendly - data model,e.g. a model expressed in UML
- **Encoding**: A computer readable formalization of a data model, e.g. models expressed in XML Schema, [JSON-Schema](https://json-schema.org/), [Database Schema](https://www.ibm.com/cloud/learn/database-schema), etc.
- **Feature**: A representation of a real world thing such as a Building

## CityGML ADE mechanism
> "An Application Domain Extension (ADE) is a formal and systematic extension of the CityGML Conceptual Model (CM) for a specific application or domain." [[OGC 20-010]](https://docs.ogc.org/is/20-010/20-010.html)

Informally, ADE allows the following extensions
1. addition of new properties to existing CityGML classes
2. addition of new feature types

In CityGML, ADEs must be formalized as an encoding (the most popular format being XML Schema) and can be expressed using UML.

One of the most well known ADE examples is the noise ADE which extends the existing Transportation, Building, and CityFurniture classes to allow for calculating noise pollution. Take a look at [[OGC 12-019]](https://portal.ogc.org/files/?artifact_id=47842) Annex H for more information, examples, and pretty pictures.

![image](https://user-images.githubusercontent.com/23373264/150370813-408c7c87-b3b8-47e1-bb82-d68f16443eae.png)
credit: [[OGC 12-019]](https://portal.ogc.org/files/?artifact_id=47842)

In CityGML 2.0:
> "an ADE XML schema can define various extensions to CityGML. However, all extensions shall belong to one of the two following categories:
> 1. **New feature types are defined** within the ADE namespace and are based on CityGML abstract or concrete classes... For example, new feature types could be defined by classes derived from the abstract classes like \_CityObject or \_AbstractBuilding or the concrete class CityFurniture. The new feature types then automatically inherit all properties (i.e. attributes) and associations (i.e. relations) from the respective CityGML superclasses.
> 2. **Existing CityGML feature types are extended** by application specific properties (in the ADE namespace)... In this case, extension of the CityGML feature type is not being realised by the inheritance mechanism of XML schema. Instead, every CityGML feature type provides a “hook” in its XML schema definition, that allows to attach additional properties to it by ADEs... For example, the last property in the definition of the CityGML feature type LandUse is the element _GenericApplicationPropertyOfLandUse (cf. chapter 10.10.1).

In the case of the image above, \_AbstracBuilding is extended using method 2.

In the image given below, we see that a new feature *noise::NoiseCityFurnitureSegment* has been added, where *noise* is the namespace.

![image](https://user-images.githubusercontent.com/8275121/150538586-59f90de8-9af2-4f0b-8e47-a5d02eda99b2.png)

With CityGML 2.0 and 3.0 the best practice for formalizing an ADE is using [model-driven-engineering](https://en.wikipedia.org/wiki/Model-driven_engineering) or model transformation tools to automatically create an XML Schema from a UML model. In the case of CityGML 3.0, this is possible since the Conceptual Model itself is formalized and publicly available as an [Enterprise Architect file](https://github.com/opengeospatial/CityGML-3.0CM/releases/download/3.0.0-final.2021.02.23/CityGML_3.0_Consolidated_Draft.eap) to be exploited by model transformation tools such as [Shapechange](https://shapechange.net/).

## Examples
* CityGML Application Domain Extension (ADE): overview of developments [[Biljecki 2018]](https://opengeospatialdata.springeropen.com/track/pdf/10.1186/s40965-018-0055-6.pdf)
* ADE for Noise Immission Simulation: [Annex H, [OGC 12-019]](https://portal.ogc.org/files/?artifact_id=47842)
* ADE for Ubiquitous Network Robots Services: [Annex H, [OGC 12-019]](https://portal.ogc.org/files/?artifact_id=47842)
* [Versioning Module in CityGML](citygml-ade-versioning.md )

## Biblio
- [[Biljecki 2018]](https://opengeospatialdata.springeropen.com/track/pdf/10.1186/s40965-018-0055-6.pdf) F. Biljecki, K. Kumar, and C. Nagel, “CityGML Application Domain Extension (ADE): overview of developments,” Open Geospatial Data, Software and Standards, vol. 3, no. 1, p. 13, Aug. 2018, doi: 10.1186/s40965-018-0055-6.
- [[OGC 20-010]](https://docs.ogc.org/is/20-010/20-010.html) OGC City Geography Markup Language (CityGML) Part 1: Conceptual Model Standard Version: 3.0.0
- [[OGC 12-019]](https://portal.ogc.org/files/?artifact_id=47842) OGC City Geography Markup Language (CityGML) Encoding Standard Version: 2.0.0
- [[Chaturvedi 2017]](https://hal.archives-ouvertes.fr/hal-01386247/document) Kanishk Chaturvedi, Carl Stephen Smyth, Gilles Gesquière, Tatjana Kutzner, Thomas H. Kolbe. Managing Versions and History Within Semantic 3D City Models for the Next Generation of CityGML. Abdul-Rahman, Alias. Lecture Notes in Geoinformation and Cartography, Springer, pp.191 - 206, 2017, Advances in 3D Geoinformation, 978-3-319-25689-4. ⟨10.1007/978-3-319-25691-7_11⟩. ⟨hal-01386247⟩
- [[Samuel 2020]](https://hal.archives-ouvertes.fr/hal-02454953/file/article.pdf) J. Samuel, S. Servigne, and G. Gesquière, “Representation of concurrent points of view of urban changes for city models,” J Geogr Syst, vol. 22, no. 3, pp. 335–359, Jul. 2020, doi: 10.1007/s10109-020-00319-1.
