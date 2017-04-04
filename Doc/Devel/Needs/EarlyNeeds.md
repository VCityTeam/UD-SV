## Fuzzy description of the needs
Consider an organization developing Computational Models (CM aka Filter) working on city related data. Such an organization is facing different challenges:

### Challenge 1: how to define and use a [**CM type signature**](https://en.wikipedia.org/wiki/Type_signature)
A given CM (Computational Model aka Filter) needs a data context in order to be executed: it requires/relies/assumes that the data it will be provided with at execution time will fulfill/respect/provide some data structures (distinct for both input and output). 
Those needs are a characteristic of the considered CM and each CM should be conceived has requiring its own specific input and output Data Models (DMs).
When the CM will be executed the CM will concretely access some Data Repository (DR) at which point the data model interface between the DM of the CM should better match with the DM of the DR. The challenge is then: **through which description/mechanism does one assert (statically or dynamically) the alignment/fitting of the CM and DR models ?** In other terms how to describe and use the [**CM type signature**](https://en.wikipedia.org/wiki/Type_signature) ?

Notes:
 * This problem arises when moving away from the rigid but classic databases context (for which the logical schema guaranties the existence of attributes or relationships) to data contexts that are more abstract (like [Hadoop](http://hadoop.apache.org/), [Apache Spark](http://spark.apache.org/) of [Flink](https://flink.apache.org/)). The freedom offered by those loose environment impose to assert some preconditions (assert the existence of some attributes for an object) at treatment execution time (think of some equivalent of C++ concept checking but for the data structure).
   
### Challenge 2: abstracting the CM/DR IO interface (API)
The CM type signature says nothing about (doesn't require) the implementation details of the CM (e.g. in C/C++ think of the the distinction between the [function prototype](https://en.wikipedia.org/wiki/Function_prototype) and the function definition/body). 
Yet, a concrete CM implementation not only relies on its input/output data models but it also relies on the behavior ([accesors/mutators](https://en.wikipedia.org/wiki/Mutator_method)) as well as data structure means for traversal/walk (e.g. [graph traversal](https://en.wikipedia.org/wiki/Graph_traversal) or [tree traversal](https://en.wikipedia.org/wiki/Tree_traversal)). 
Additionally this says nothing of possible behaviors attached/associated with such data models: 
 * the behavior associated to the data structure when one does numerical simulations  
 * or more simply of behavioral decoration (e.g. with the [visitor technique](https://en.wikipedia.org/wiki/Visitor_pattern)). 
   
The concern of the CM producer is to **interface, through some data access API, with the data at an abstraction level that enables code recycling**. For example it shouldn't be the CM provider concern:
 * to deal with the data repository specifics/details belonging to data logical or even physical model
 * to hardwire in the CM code some given database query language requests (e.g. `SQL` and/or "spatial SQL"). 

### Challenge 3: how to evolve/extend the data server data model  
CityGML last specification is now defined as an abstract model in the form of an UML based description as opposed to previous specifications that were given as XML Schema (XSD)  based concrete form. 
Additionally CityGML accepts information model "extensions" (called ADE e.g. [Energy_ADE](http://www.citygmlwiki.org/index.php/CityGML_Energy_ADE)) themselves described in their abstract or concrete forms.

**When working (defining or producing data) with such ADE's what are the modular methods and tools to be used in order to maintain such an extensible data repository ?**  
