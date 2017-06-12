# Need 002: means for modular information models

### User story
As database administrator I want to to deploy an ADE aside an existing (reference) CityDB database so that I preserve information modularity and avoid a bloatedexpensive to maitain unique centralized database.

### Beneficiary role: database admin, deployment (to other project) admin

### Impact: medium (can do without but painfull in the long run).

### Maturity: ongoing

### Cost evaluation: 6 man months (?)

### Tags or keywords

### Description
CityGML last specification is now defined as an abstract model in the form of an UML based description as opposed to previous specifications that were given as XML Schema (XSD) based concrete forms. 
Additionally CityGML accepts information model "extensions" (called ADE e.g. [Energy_ADE](http://www.citygmlwiki.org/index.php/CityGML_Energy_ADE)) themselves described in their abstract or concrete forms.

The challenge can be summarized as: **when working (defining or producing data) with such ADE's, what are the modular methods and tools to be used in order to maintain such an extensible data repository?**
How to concretly evolve/extend the reference data model down when navigating the production process starting from the [conceptual data model](https://en.wikipedia.org/wiki/Conceptual_schema) (expressed in UML in the context of this need), going through the [logical data model](https://en.wikipedia.org/wiki/Logical_data_model) and ending with the [physical data model](https://en.wikipedia.org/wiki/Physical_data_model)?

In order to illustrate this challenge, let us consider the [UML diagram](http://cadastralvocabulary.org/citygml/tax_ade/1.0/CityGML_TaxADE_UML.png) of an ADE ([the Immovable Property_Taxation_ADE](http://www.citygmlwiki.org/index.php?title=CityGML_Immovable_Property_Taxation_ADE)). In such UML class diagram, the classes belonging to [CityGML core specification](http://portal.opengeospatial.org/files/?artifact_id=47842) are depicted with a single color (yellow for this example with classes like `LandUse`, `_CityObject`, `_AbstactBuilding`).
Instead the ADE classes are depicted with a distinguished color (green for this example with classes like `tax::PropertyUnit`, `tax::BuildingUsePart`). 
Let us assume that some Data Base, named `DB_Ref`, deployed with CityGML logical model already exists, and further assume that a treament developer wishes to work with this ADE.
Such a developer will have (at least) two possibilities:
 1. **integrated DB migration path**: 
   - merge/assemble/aggregate (at the conceptual model level) the CityGML information model together with the considered ADE conceptual model, 
   - deploy a new DB, named `DB_Ref_New`, with this new integrated model and migrate the content of `DB_Ref` to this new ADE extended based database `DB_Ref_New`,
   - eventually delete `DB_Ref`.
 2. build a **separate ADE specific DB** restricted to hold the ADE data
   - build a new `DB_ADE` database which has the ADE conceptual model as information model,
   - have a service layer (e.g. some REST api) to unify `DB_Ref` together with `DB_ADE`.

The clear advantages of this "separate ADE specific DB" are:
 - its modularity: one can combine easily many ADE, 
 - avoiding the cumbersome DB migration. 

Its drawback is the necessity to blur/hide-away/abtract the existence of two underlying DBs (`DB_Ref` together with `DB_ADE`) to the DB users, namely the CMs (Computational Model).

### Notes:
References: [Implementing modular Domain Specific Languages and Analyses](voelter.de/data/pub/modevva2012.pdf), Markus Voelter et al. 

