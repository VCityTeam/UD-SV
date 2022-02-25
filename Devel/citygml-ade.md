# CityGML ADEs

- [Generic attributes and objects](#Generic-attributes-and-objects)
- [ADE (Application Domain Extension)](#ADE-(Application-Domain-Extension))
- [CityGML ADE mechanism](#CityGML-ADE-mechanism)
  - [EA Modeling for Shapechange](#EA-Modeling-for-Shapechange)
  - [XML Data Validation](#XML-Data-Validation)
- [Examples](#Examples)
- [Biblio](#Biblio)

CityGML is used to represent urban information, especially the information related to various city objects like buildings, bridges, vegetation, road infrastructure etc. However, not all information are covered by CityGML. Hence, there are two possible ways of CityGML extensions:

1.  *Generic attributes and objects*
2.  *ADE (Application Domain Extension)*

## Generic attributes and objects
<a name="genericattributes"></a>
The CityGML classes *GenericCityObject* and *_genericAttribute* can be extended to introduce new *generic objects* and *generic attributes*.

An extended generic attribute may belong to any of the following data types: string, integer, double (floating point number), date, URI or a measure (*gml:MeasureType*). It is also possible to create complex generic attribute by making use of *genericAttributeSet*, which in itself is a generic attribute.  

Generic objects can be created by extending *GenericCityObject* that has three attributes: *class*, *function* and *usage*. *GenericCityObject* may also have explicit geometry or/and *ImplicitGeometry* (useful for specifying prototypical geometry of objects like trees, traffic lights etc.). And it is also possible to specify the intersections between the explicit geometry of the generic object with the digital terrain model.

One major limitation of using these attributes is the difficulty in validating the extended data. Domain experts may propose names, data types and cardinality information of the extended generic objects and attributes. However, the CityGML parser may not have this additional information and hence, it is impossible to verify whether the data types/cardinality information is respected in the instances of generic objects/attributes. This is where ADE comes into picture.

The conceptual model of *GenericCityObject* and *_genericAttribute* is given below [[Page 164, OGC 12-019]](https://portal.ogc.org/files/?artifact_id=47842):

![image](https://user-images.githubusercontent.com/8275121/150536248-a1cf2408-1a67-4e53-9f44-f4999b7e099b.png)

The following example shows a generic string attribute from [ADV 2019] (CityGML 2.0).
```
<gen:stringAttribute name=“DatenquelleDachhoehe“>
  <gen:value>1000</gen:value>
</gen:stringAttribute>
```

An example from [Morel 2014]

```
   <bldg:Building gml:id="...">
        <gen:StringAttribute name="usage">
             <gen:value>house</gen:value>
        </gen:StringAttribute>
```

Another example of a [string attribute in CityGML 3.0](https://github.com/opengeospatial/CityGML-3.0/blob/master/Test%20data/Building_CityGML_3.0.xml)

```
    <cityObjectMember>
        <bldg:Building gml:id="DEBY_LOD2_5744682">
            <genericAttribute>
                <gen:StringAttribute>
                    <gen:name>Gemeindeschluessel</gen:name>
                    <gen:value>09175128</gen:value>
                </gen:StringAttribute>
            </genericAttribute>
```

The following examples from [Biljecki 2018] shows the use of a set of generic attributes

```
<gen:genericAttributeSet name="BaseHeights" codeSpace="https://www.example_authority.com"
   <gen:doubleAttribute name="AbsoluteRidgeHeight">
      <gen:value>16.167</gen:value>
   </gen:doubleAttribute>
   ...
</gen:genericAttributeSet>
```

[Kumar 2019] states that the CityGML files with generic attributes cannot be completely validated since there is no consensus on the use of names and datatypes. This is a major limitation, when it comes to the possibility of sharing without any syntactic and semantic interoperability issues. 

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

The advantage of using ADE is that domain experts could share their data along with the (XML schema/XSD) or UML diagrams of their proposed ADE. This ensures interoperability and proper validation of data with the XML parsers (unlike the case of *generic attributes and objects* as explained above).

Take for example, the newly added attributes for Noise ADE in `_AbstractBuilding`

```
<xsd:element name="buildingReflection" type="xsd:string"
  substitutionGroup="bldg:_GenericApplicationPropertyOfAbstractBuilding"/>
<xsd:element name="buildingReflectionCorrection" type="gml:MeasureType"
  substitutionGroup="bldg:_GenericApplicationPropertyOfAbstractBuilding"/>
```

With CityGML 2.0 and 3.0 the best practice for formalizing an ADE is using [model-driven-engineering](https://en.wikipedia.org/wiki/Model-driven_engineering) or model transformation tools to automatically create an XML Schema from a UML model. In the case of CityGML 3.0, this is possible since the Conceptual Model itself is formalized and publicly available as an [Enterprise Architect file](https://github.com/opengeospatial/CityGML-3.0CM/releases/download/3.0.0-final.2021.02.23/CityGML_3.0_Consolidated_Draft.eap) to be exploited by model transformation tools such as [Shapechange](https://shapechange.net/).

### EA Modeling for Shapechange
When using Enterprise Architect to create conceptual UML data models for CityGML ADEs to transform into physical data models - such as XML Schema or OWL ontologies - with the [shapechange](https://shapechange.net/) transformation tool, there are several concepts and configurations to take into account.

For a broader overview of implementing CityGML ADEs with EA, see the following documentation:
- [OGC 12-066 document: Modeling_an_application_domain_extension_of_CityGML_in_UML_-_candidate_best_practice](https://github.com/VCityTeam/3DUSE/blob/master/doc/ADE/1.%20doc/12-066_Modeling_an_application_domain_extension_of_CityGML_in_UML_-_candidate_best_practice%20(1).pdf)
- [ShapeChange documentation](https://shapechange.net/targets/xsd/)

<a name="XML-Data-Validation"/>

### XML Data Validation
A possible XML validation tool is the [XML extention](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-xml) for vscode which enables XSD and DTD [XML validation](https://github.com/redhat-developer/vscode-xml/blob/master/docs/Validation.md#validation-with-xsd-grammar) with local and online files.

#### UML Profile
In both CityGML 2.0 the `CityGML UML Profile` UML profile must be loaded in order to identify and map certain CityGML specific ADE concepts to an XML Schema. Example EA UML models can be found in the [UD-Graph repository](https://github.com/VCityTeam/UD-Graph/tree/versioning-graph/Transformations/test-data/UML)

The following Stereotypes must be used for properly declaring the following UML elements
| UML | EA Stereotype |
|---|---|
| ADE Application Schema package | `CityGML UML Profile::ApplicationSchema` |
| ADE Leaf package | `CityGML UML Profile::Leaf` |
| ADE of existing CityGML Class | `CityGML UML Profile::ADEElement` |
| ADE Feature Class | `CityGML UML Profile::FeatureType` |
| ADE Datatype | `CityGML UML Profile::DataType` |
| ADE Enumeration | `CityGML UML Profile::Enumeration` |
| ADE Type | `CityGML UML Profile::Type` |
| ADE CodeList | `CityGML UML Profile::CodeList` |
| ADE Union | `CityGML UML Profile::Union` |

![Example Enterprise Architect Stereotype definition for a new ADE FeatureType](https://user-images.githubusercontent.com/23373264/155375191-e6cbfa11-8aee-4056-b492-f29b1f6a0e85.png)

#### ShapeChange configuration
To take advantage of these 'hooks' in the UML profile use the `<rule name="rule-xsd-cls-adeelement"/>` to transform these UML elements to XSD. See this [shapechange configuration file](https://github.com/VCityTeam/UD-Graph/tree/versioning-graph/Transformations/ShapeChange) as an example.



## Examples
* CityGML Application Domain Extension (ADE): overview of developments [[Biljecki 2018]](https://opengeospatialdata.springeropen.com/track/pdf/10.1186/s40965-018-0055-6.pdf)
* ADE for Noise Immission Simulation: [Annex H, [OGC 12-019]](https://portal.ogc.org/files/?artifact_id=47842)
* ADE for Ubiquitous Network Robots Services: [Annex H, [OGC 12-019]](https://portal.ogc.org/files/?artifact_id=47842)
* [Versioning Module in CityGML](citygml-ade-versioning.md )

## Biblio
- [[Biljecki 2018]](https://opengeospatialdata.springeropen.com/track/pdf/10.1186/s40965-018-0055-6.pdf) F. Biljecki, K. Kumar, and C. Nagel, “CityGML Application Domain Extension (ADE): overview of developments,” Open Geospatial Data, Software and Standards, vol. 3, no. 1, p. 13, Aug. 2018, doi: 10.1186/s40965-018-0055-6.
- [[OGC 20-010]](https://docs.ogc.org/is/20-010/20-010.html) OGC City Geography Markup Language (CityGML) Part 1: Conceptual Model Standard Version: 3.0.0
- [[Morel 2014]](https://diglib.eg.org/xmlui/bitstream/handle/10.2312/udmv.20141076.037-042/037-042.pdf), M. Morel and G. Gesquière, Managing temporal change of cities with CityGML, Eurographics Workshop on Urban Data Modelling and Visualization (2014)
- [[OGC 12-019]](https://portal.ogc.org/files/?artifact_id=47842) OGC City Geography Markup Language (CityGML) Encoding Standard Version: 2.0.0
- [[Chaturvedi 2017]](https://hal.archives-ouvertes.fr/hal-01386247/document) Kanishk Chaturvedi, Carl Stephen Smyth, Gilles Gesquière, Tatjana Kutzner, Thomas H. Kolbe. Managing Versions and History Within Semantic 3D City Models for the Next Generation of CityGML. Abdul-Rahman, Alias. Lecture Notes in Geoinformation and Cartography, Springer, pp.191 - 206, 2017, Advances in 3D Geoinformation, 978-3-319-25689-4. ⟨10.1007/978-3-319-25691-7_11⟩. ⟨hal-01386247⟩
- [[Kumar 2019]] Kumar, Kavisha, et al. « Harmonising the OGC Standards for the Built Environment: A CityGML Extension for LandInfra ». ISPRS International Journal of Geo-Information, vol. 8, no 6, juin 2019, p. 246. www.mdpi.com, https://doi.org/10.3390/ijgi8060246.
- [[Samuel 2020]](https://hal.archives-ouvertes.fr/hal-02454953/file/article.pdf) J. Samuel, S. Servigne, and G. Gesquière, “Representation of concurrent points of view of urban changes for city models,” J Geogr Syst, vol. 22, no. 3, pp. 335–359, Jul. 2020, doi: 10.1007/s10109-020-00319-1.
- [[ADV 2019]][Data format specification of the Official 3D Building Model of Germany in Level of Detail 1 and 2](https://www.adv-online.de/AdV-Produkte/Standards-und-Produktblaetter/ZSHH/binarywriterservlet?imgUid=67550b74-08c1-9c61-699f-dce303b36c4c&uBasVariant=11111111-1111-1111-1111-111111111111)
