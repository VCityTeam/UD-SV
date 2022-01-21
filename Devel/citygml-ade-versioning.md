# Representing Temporal Information and Versions in CityGML

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

## Workspace and Scenarios

The above notions of versions, transactions and version transitions introduced in CityGML 3.0 have been further extended in [[Samuel 2020]](https://hal.archives-ouvertes.fr/hal-02454953/file/article.pdf). 

![image](https://user-images.githubusercontent.com/8275121/150520355-642a9511-7dce-4940-9a91-b8edf13d4684.png)

## See also
* [CityGML ADEs](citygml-ade.md)

## Bibliography
- [[OGC 20-010]](https://docs.ogc.org/is/20-010/20-010.html) OGC City Geography Markup Language (CityGML) Part 1: Conceptual Model Standard Version: 3.0.0
- [[OGC 12-019]](https://portal.ogc.org/files/?artifact_id=47842) OGC City Geography Markup Language (CityGML) Encoding Standard Version: 2.0.0
- [[Chaturvedi 2017]](https://hal.archives-ouvertes.fr/hal-01386247/document) Kanishk Chaturvedi, Carl Stephen Smyth, Gilles Gesquière, Tatjana Kutzner, Thomas H. Kolbe. Managing Versions and History Within Semantic 3D City Models for the Next Generation of CityGML. Abdul-Rahman, Alias. Lecture Notes in Geoinformation and Cartography, Springer, pp.191 - 206, 2017, Advances in 3D Geoinformation, 978-3-319-25689-4. ⟨10.1007/978-3-319-25691-7_11⟩. ⟨hal-01386247⟩
- [[Samuel 2020]](https://hal.archives-ouvertes.fr/hal-02454953/file/article.pdf) J. Samuel, S. Servigne, and G. Gesquière, “Representation of concurrent points of view of urban changes for city models,” J Geogr Syst, vol. 22, no. 3, pp. 335–359, Jul. 2020, doi: 10.1007/s10109-020-00319-1.
