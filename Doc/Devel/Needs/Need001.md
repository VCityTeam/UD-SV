# Need 001: means for computational model API

### User story
As Computational Model (CM) developer I want to define a CM type signature so that the CM API is documented in order to easily combine CMs within treatment workflows.

### Beneficiary role: **integrated** model developer.

### Impact: minor (nice to have).

### Maturity: ongoing

### Cost evaluation: 2 man week (?)
Tags or keywords

### Description
A given CM (Computational Model aka Filter) needs a data context in order to be executed: it requires/relies/assumes that the data it will be provided with (at execution time) will fulfill/respect/provide some data structures (distinct for both input and output). Those needs are a characteristic of the considered CM and each CM should be conceived ha requiring its own specific input and output Data Models (DMs). When the CM will be executed the CM will concretely access some Data Repository (DR) at which point the data model interface between the DM of the CM should better match with the DM of the DR. The challenge is then: through which description/mechanism does one assert (statically or dynamically) the alignment/fitting of the CM and DR models ? In other terms how to describe and use the CM type signature ?

### Notes:
This problem arises when moving away from the rigid but classic databases context (for which the logical schema guaranties the existence of attributes or relationships) to data contexts that are more abstract (like Hadoop, Apache Spark of Flink). The freedom offered by those loose environment impose to assert some preconditions (assert the existence of some attributes for an object) at treatment execution time (think of some equivalent of C++ concept checking but for the data structure).
