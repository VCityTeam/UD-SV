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


The following is a snippet from the example dataset. It has two buildings **BU_69381AL47** and **BU_69381AL49** which have undergone changes in two versions. 

![image](https://user-images.githubusercontent.com/8275121/150540875-7b2473af-3d30-4774-b9a1-604b2c4a6a13.png)

![image](https://user-images.githubusercontent.com/8275121/150541151-3e78e936-c2ce-4dff-9bfa-0bea783c5de4.png)

The two versions *v1.0* (**LYON_1ER_snapshot_2000-01-01**) and *v2.0* (**LYON_1ER_snapshot_2015-01-01**) are given below:

![image](https://user-images.githubusercontent.com/8275121/150546693-bd56ab0c-2499-4203-9c78-9d89dc27d415.png)


![image](https://user-images.githubusercontent.com/8275121/150546763-affa4257-6c89-4b20-8bc4-8132080cec2a.png)

The version transition from *v1.0* (**LYON_1ER_snapshot_2000-01-01**) to *v2.0* (**LYON_1ER_snapshot_2015-01-01**) and the associated transactions is given below:

![image](https://user-images.githubusercontent.com/8275121/150547254-79cb1e84-0c74-4d4c-b7be-48bcc07c0f71.png)

We see three transactions
* *insert*: A new building unit **BU_69381AL50_2015-01-01** has been introduced 
* *replace*: The building unit **BU_69381AL49_2000-01-01** has been undergone a change and is represented by **BU_69381AL49_2015-01-01**.
* *delete*: The building unit identified by **BU_69381AL47_2000-01-01** has been deleted

## Workspace and Scenarios

The above notions of versions, transactions and version transitions introduced in CityGML 3.0 have been further extended in [[Samuel 2020]](https://hal.archives-ouvertes.fr/hal-02454953/file/article.pdf). 

This work proposes the following concepts as enchancements to the model:
- **Workspace** - "A workspace manages various scenarios of urban evolution proposed by agents (e.g., researchers, users, domain experts, enterprises etc.)... A workspace consists of two spaces: Consensus Space and Proposition Space."
- **Scenarios** - used to represent a sequence of changes to one or more city objects. [[Samuel 2020]](https://hal.archives-ouvertes.fr/hal-02454953/file/article.pdf)
- **Space** -  a collection of one or more scenarios.
  - **Consensus Space** - has only one scenario, which represents the official scenario of the urban evolution or the evolution of urban objects. **Proposition space**, on the other hand may have zero or more scenario, with each scenario is a proposed scenario of changes.
  - **Proposition Space** - is particularly useful when the researchers wish to propose hypotheses related to urban evolution.

Versions have been classified as either:
* **Existing**: This is to represent versions which existed physically during the past, whose existence have been (officially) confirmed
* **Imagined**: This is to represent project propositions like the construction of an indstrial zone, highways etc.

Version transitions have been classified as either:
* **Regular** as in [[OGC 20-010]](https://docs.ogc.org/is/20-010/20-010.html)
* **Influenced**: This is used to represent when we use to show the influence of a version in the past to a version in the future. This is useful to represent the proposed project in a city (e.g., an industrial zone, road infrastructure)

Here is an example of a possible Workspace for the study of urban evolution:

![image](https://user-images.githubusercontent.com/23373264/150550282-1edca381-3a23-41d0-9477-116a72a1b7db.png)

## See also
* [CityGML ADEs](citygml-ade.md)
* [CityGML 3.0 Conceptual Model Section 7.13: Versioning](https://docs.ogc.org/is/20-010/20-010.html#toc41)

## Bibliography
- [[OGC 20-010]](https://docs.ogc.org/is/20-010/20-010.html) OGC City Geography Markup Language (CityGML) Part 1: Conceptual Model Standard Version: 3.0.0
- [[OGC 12-019]](https://portal.ogc.org/files/?artifact_id=47842) OGC City Geography Markup Language (CityGML) Encoding Standard Version: 2.0.0
- [[Chaturvedi 2017]](https://hal.archives-ouvertes.fr/hal-01386247/document) Kanishk Chaturvedi, Carl Stephen Smyth, Gilles Gesquière, Tatjana Kutzner, Thomas H. Kolbe. Managing Versions and History Within Semantic 3D City Models for the Next Generation of CityGML. Abdul-Rahman, Alias. Lecture Notes in Geoinformation and Cartography, Springer, pp.191 - 206, 2017, Advances in 3D Geoinformation, 978-3-319-25689-4. ⟨10.1007/978-3-319-25691-7_11⟩. ⟨hal-01386247⟩
- [[Samuel 2020]](https://hal.archives-ouvertes.fr/hal-02454953/file/article.pdf) J. Samuel, S. Servigne, and G. Gesquière, “Representation of concurrent points of view of urban changes for city models,” J Geogr Syst, vol. 22, no. 3, pp. 335–359, Jul. 2020, doi: 10.1007/s10109-020-00319-1.
