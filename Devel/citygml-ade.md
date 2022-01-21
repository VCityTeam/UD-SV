# CityGML ADEs (and the temporal extentions)

This document will explain how the ADE mechanism works, and the temporal ADEs proposed in [[Chaturvedi 2017]](https://hal.archives-ouvertes.fr/hal-01386247/document) and [[Samuel 2020]](https://hal.archives-ouvertes.fr/hal-02454953/file/article.pdf).

Some helpful knowledge you should be a little familiar with before reading:
- [Wikipedia: Unified Modeling Lanugage](https://en.wikipedia.org/wiki/Unified_Modeling_Language)
- [What is XML Schema (XSD)?](https://docs.microsoft.com/en-us/previous-versions/windows/desktop/ms765537%28v=vs.85%29)

Some helpful OGC vocabulary:
- **Conceptual Model**: A highly conceptual - and often human friendly - data model,e.g. a model expressed in UML
- **Encoding**: A computer readable formalization of a data model, e.g. models expressed in XML Schema, [JSON-Schema](https://json-schema.org/), [Database Schema](https://www.ibm.com/cloud/learn/database-schema), etc.
- **Feature**: A representation of a real world thing such as a Building


## CityGML ADE mechanism doc
> "An Application Domain Extension (ADE) is a formal and systematic extension of the CityGML Conceptual Model (CM) for a specific application or domain." [[OGC 20-010]](https://docs.ogc.org/is/20-010/20-010.html)

In CityGML, ADEs must be formalized as an encoding (the most popular format being XML Schema) and can be expressed using UML.

One of the most well known ADE examples is the noise ADE which extends the existing Transportation, Building, and CityFurniture classes to allow for calculating noise pollution. Take a look at [[OGC 12-019]](https://portal.ogc.org/files/?artifact_id=47842) Annex H for more information, examples, and pretty pictures.

![image](https://user-images.githubusercontent.com/23373264/150370813-408c7c87-b3b8-47e1-bb82-d68f16443eae.png)
credit: [[OGC 12-019]](https://portal.ogc.org/files/?artifact_id=47842)

In CityGML 2.0:
> "an ADE XML schema can define various extensions to CityGML. However, all extensions shall belong to one of the two following categories:
> 1. **New feature types are defined** within the ADE namespace and are based on CityGML abstract or concrete classes... For example, new feature types could be defined by classes derived from the abstract classes like \_CityObject or \_AbstractBuilding or the concrete class CityFurniture. The new feature types then automatically inherit all properties (i.e. attributes) and associations (i.e. relations) from the respective CityGML superclasses.
> 2. **Existing CityGML feature types are extended** by application specific properties (in the ADE namespace)... In this case, extension of the CityGML feature type is not being realised by the inheritance mechanism of XML schema. Instead, every CityGML feature type provides a “hook” in its XML schema definition, that allows to attach additional properties to it by ADEs... For example, the last property in the definition of the CityGML feature type LandUse is the element _GenericApplicationPropertyOfLandUse (cf. chapter 10.10.1).

In the case of the image above, \_AbstracBuilding is extended using method 2.

With CityGML 3.0, it is not yet clear what the best practice for formalizing an ADE will be but using model transformation tools to automatically create an XML Schema from a UML model will likely be a good [model-driven-engineering](https://en.wikipedia.org/wiki/Model-driven_engineering) option. This is possible since the CityGML 3.0 Conceptual Model itself is formalized and publicly available as an [Enterprise Architect file](https://github.com/opengeospatial/CityGML-3.0CM/releases/download/3.0.0-final.2021.02.23/CityGML_3.0_Consolidated_Draft.eap) to be exploited by model transformation tools such as [Shapechange](https://shapechange.net/).

## CityGML 2.0 Temporal ADEs doc
The Versioning ADE was initially proposed in [[Chaturvedi 2017]](https://hal.archives-ouvertes.fr/hal-01386247/document) in order to provide a framework for supporting multiple 'Versions' of a city model in a single CityGML document and storing the changes between features in the model.

3 concepts were proposed and formalized in this paper:
1. **Version**: a snapshot of a city model.
2. **VersionTransition**: a composition of all of the changes between two versions. Proposed transition types include: planned, realized, historical succession, fork, and merge 
3. **Transaction**: a replacement, addition, or deletion of a feature between two versions. 

![image](https://user-images.githubusercontent.com/23373264/150381878-a5ee9379-77b5-4540-b5e6-c3b2cb8a091e.png)

credit: [[Chaturvedi 2017]](https://hal.archives-ouvertes.fr/hal-01386247/document)

![image](https://user-images.githubusercontent.com/23373264/150382089-b97df4de-c889-4069-a11a-d3aa15335dff.png)

credit: [[Chaturvedi 2017]](https://hal.archives-ouvertes.fr/hal-01386247/document)

An example GML file using XLinks is available in [3DUSE](https://github.com/VCityTeam/3DUSE/blob/master/doc/ADE/Temporel/1.%20xlinks/GML_test_ADE.gml).

Take, for example, the building has changed its function from "Office" (see the screenshot given below) to

![image](https://user-images.githubusercontent.com/8275121/150499602-926b0e72-f121-43d7-b984-f319981fa731.png)

"Living" (see the screenshot given below).

![image](https://user-images.githubusercontent.com/8275121/150499675-6b1eaf4d-86a5-4a0e-840e-572ae874b6c6.png)

In this example, there are two representations of the two versions of the building identified by the identifiers **B1020_t1** and **B1020_t2**.
* **B1020_t1** is a valid physical representation of the building **B1020** between the dates *2012-08-02* and *2013-10-09* and having the function *Office*.
* **B1020_t2** is a valid physical representation of the building **B1020** from *2013-10-09* and having the function *Living*. Since there is no use of the attribute *terminationDate*, it means that the current function of the building is *Living*. 

In order to identify that the versions are of the building **B1020**, the *identifier* attribute of both  use the same value **B1020**. In this example, we have only building part with the identifier with the value  **BP12**. However, the building part is specified using `xLink`. This will also allow us to find the multiple versions of the building part **BP12** (as shown below). 

```
    <consistsOfBuildingPart>
        <BuildingPart xlink:href="//identifier[text()='BP12']/.."/> 
    </consistsOfBuildingPart>
```
The example version of the building part   **BP12** is given below:

![image](https://user-images.githubusercontent.com/8275121/150503006-ecda395d-9591-46d3-8fbe-3b54c50f261a.png)

The above version of the building part has the following attribute values
* **BP_t1** is a valid physical representation of the building part **BP12** between the dates *2012-08-02* and *2014-06-03* and having a *Flat* *roofType*.

The above proposition has now been accepted with some enhancements in CityGML 3.0, which we describe below.

## CityGML 3.0 Versioning Module doc

The conceptual model of the versioning module as given below is proposed in [ opengeospatial /
CityGML-3.0CM ](https://github.com/opengeospatial/CityGML-3.0CM/blob/master/Conceptual%20Model/CityGML_3.0_UML-Diagrams.pdf).
![image](https://user-images.githubusercontent.com/8275121/150493650-78704aa5-dc8a-4d15-b482-f741d09447ef.png)

Some examples of the versioning module are available in [ opengeospatial /
CityGML-3.0Encodings
](https://github.com/opengeospatial/CityGML-3.0Encodings/tree/master/CityGML/Examples/Versioning). 

Since versions have now their own classes in CityGML 3.0, it is now possible to represent them.

Take for example, the following use case of two versions:

![image](https://user-images.githubusercontent.com/8275121/150516759-c5d52a84-3f82-41dd-b8f9-5781eea8ff2b.png)


The following is a version of the city.


![image](https://user-images.githubusercontent.com/8275121/150505138-50b57856-a955-4a14-84fc-ee222bb97155.png)


## Biblio
- [[OGC 20-010]](https://docs.ogc.org/is/20-010/20-010.html) OGC City Geography Markup Language (CityGML) Part 1: Conceptual Model Standard Version: 3.0.0
- [[OGC 12-019]](https://portal.ogc.org/files/?artifact_id=47842) OGC City Geography Markup Language (CityGML) Encoding Standard Version: 2.0.0
- [[Chaturvedi 2017]](https://hal.archives-ouvertes.fr/hal-01386247/document) Kanishk Chaturvedi, Carl Stephen Smyth, Gilles Gesquière, Tatjana Kutzner, Thomas H. Kolbe. Managing Versions and History Within Semantic 3D City Models for the Next Generation of CityGML. Abdul-Rahman, Alias. Lecture Notes in Geoinformation and Cartography, Springer, pp.191 - 206, 2017, Advances in 3D Geoinformation, 978-3-319-25689-4. ⟨10.1007/978-3-319-25691-7_11⟩. ⟨hal-01386247⟩
- [[Samuel 2020]](https://hal.archives-ouvertes.fr/hal-02454953/file/article.pdf) J. Samuel, S. Servigne, and G. Gesquière, “Representation of concurrent points of view of urban changes for city models,” J Geogr Syst, vol. 22, no. 3, pp. 335–359, Jul. 2020, doi: 10.1007/s10109-020-00319-1.