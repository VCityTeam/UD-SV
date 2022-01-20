# CityGML ADEs (and the temporal extentions)

This document will explain how the ADE mechanism works, and the temporal ADE proposed in [[Chaturvedi 2017]](https://hal.archives-ouvertes.fr/hal-01386247/document) and [[Samuel 2020]](https://hal.archives-ouvertes.fr/hal-02454953/file/article.pdf).

Some helpful knowledge you should be a little familiar with before reading:
- [Wikipedia: Unified Modeling Lanugage](https://en.wikipedia.org/wiki/Unified_Modeling_Language)
- [What is XML Schema (XSD)?](https://docs.microsoft.com/en-us/previous-versions/windows/desktop/ms765537%28v=vs.85%29)

Some helpful OGC vocab:
- **Conceptual Model**: A highly conceptual - and often human friendly - data model,e.g. a model expressed in UML
- **Encoding**: A computer readable formalization of a data model, e.g. models expressed in XML Schema, [JSON-Schema](https://json-schema.org/), [Database Schema](https://www.ibm.com/cloud/learn/database-schema), etc.
- **Feature**: A representation of a real world thing such as a Building


## CityGML ADE mechanism doc
> "An Application Domain Extension (ADE) is a formal and systematic extension of the CityGML Conceptual Model (CM) for a specific application or domain." [[OGC 20-010]](https://docs.ogc.org/is/20-010/20-010.html)

In CityGML, ADEs must be formalized as an encoding (the most popular format being XML Schema) and can be expressed using UML.

One of the most well known ADE examples is the noise ADE which extends the existing Transportation, Building, and CityFurniture classes to allow for calculating noise pollution. Take a look at [[OGC 12-019]](https://portal.ogc.org/files/?artifact_id=47842) Annex H for more information, examples, and pretty pictures.

![image](https://user-images.githubusercontent.com/23373264/150370813-408c7c87-b3b8-47e1-bb82-d68f16443eae.png)

In CityGML 2.0:
> "an ADE XML schema can define various extensions to CityGML. However, all extensions shall belong to one of the two following categories:
> 1. **New feature types are defined** within the ADE namespace and are based on CityGML abstract or concrete classes... For example, new feature types could be defined by classes derived from the abstract classes like \_CityObject or \_AbstractBuilding or the concrete class CityFurniture. The new feature types then automatically inherit all properties (i.e. attributes) and associations (i.e. relations) from the respective CityGML superclasses.
> 2. **Existing CityGML feature types are extended** by application specific properties (in the ADE namespace)... In this case, extension of the CityGML feature type is not being realised by the inheritance mechanism of XML schema. Instead, every CityGML feature type provides a “hook” in its XML schema definition, that allows to attach additional properties to it by ADEs... For example, the last property in the definition of the CityGML feature type LandUse is the element _GenericApplicationPropertyOfLandUse (cf. chapter 10.10.1).

In the case of the image above, \_AbstracBuilding is extended using method 2.

With CityGML 3.0, it is not yet clear what the best practice for formalizing an ADE will be but using model transformation tools to automatically create an XML Schema from a UML model will likely be a good [model-driven-engineering](https://en.wikipedia.org/wiki/Model-driven_engineering) option. This is possible since the CityGML 3.0 Conceptual Model itself is formalized and publicly available as an [Enterprise Architect file](https://github.com/opengeospatial/CityGML-3.0CM/releases/download/3.0.0-final.2021.02.23/CityGML_3.0_Consolidated_Draft.eap) and can be transformed using tools such as [Shapechange](https://shapechange.net/)

## CityGML 2.0 Versioning ADE doc


## CityGML 3.0 Versioning Module doc

## Biblio
- [[OGC 20-010]](https://docs.ogc.org/is/20-010/20-010.html) OGC City Geography Markup Language (CityGML) Part 1: Conceptual Model Standard Version: 3.0.0
- [[OGC 12-019]](https://portal.ogc.org/files/?artifact_id=47842) OGC City Geography Markup Language (CityGML) Encoding Standard Version: 2.0.0
- [[Chaturvedi 2017]](https://hal.archives-ouvertes.fr/hal-01386247/document) Kanishk Chaturvedi, Carl Stephen Smyth, Gilles Gesquière, Tatjana Kutzner, Thomas H. Kolbe. Managing Versions and History Within Semantic 3D City Models for the Next Generation of CityGML. Abdul-Rahman, Alias. Lecture Notes in Geoinformation and Cartography, Springer, pp.191 - 206, 2017, Advances in 3D Geoinformation, 978-3-319-25689-4. ⟨10.1007/978-3-319-25691-7_11⟩. ⟨hal-01386247⟩
- [[Samuel 2020]](https://hal.archives-ouvertes.fr/hal-02454953/file/article.pdf) J. Samuel, S. Servigne, and G. Gesquière, “Representation of concurrent points of view of urban changes for city models,” J Geogr Syst, vol. 22, no. 3, pp. 335–359, Jul. 2020, doi: 10.1007/s10109-020-00319-1.
