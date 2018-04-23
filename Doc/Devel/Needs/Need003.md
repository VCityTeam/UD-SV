# Need 003: A document-enhanced 4D representation of the city to detail historical processes

Links:

Sub Needs :
* [Need004](Need004.md) : Enhancing city models with documents
* [Need005](Need005.md) : Adding a temporal dimension to city models
* [Need006](Need006.md) : ergonomic user exploration of space (advanced camera control, shortcut to point of interest...)
* [Need007](Need007.md) : 'guided tour' : step by step tour to describe a historical process
* [Need009](Need009.md) : ability to use texture in the 3d scene
* [Need011](Need011.md) : user interface (document, temporal slider, map...)
* [Need028](Need028.md) : CRUD API
* [Need029](Need029.md) : web API

### User story
As an historian, I want a document-enhanced 4D representation of the city in which historical processes can be detailed.

### Beneficiary role: 
 - Experts in various fields, ranging from information technology to human sciences. Tools must be easy to use for non-technicians (focus needed on ergonomy).
 - VCity team: first client/server demonstrator for the VCity team with many re-usable features

### Impact:
Major: for the VCity team (demonstrator) & for historians

### Maturity: ongoing

### Cost evaluation: 
36 man months (3 trainees for 5 months, 2 Phd student (each half time), 1 post doc (quarter time), 1 software engineer (half time), Professor (1 man month)

### Tags or keywords

### Description

We need a visualization tool for 4d city models (3d space + time), historical documents, and urbanization/historical processes. The tool will allow the user to explore a document base as well as the 4d scene, and it will feature two modes : free tour and guided tour.
* In **free tour**, documents are integrated in the 3d scene (billboards) with some of them being hidden (LoD and/or filters) and the user can move freely in the 3d scene, and in time (which modifies which documents are displayed, and city gemotry when available).
* In **guided tour**, the user is moved from a "tour step" to another. A tour step is composed of a date (with corresponding city geometry), a position, an orientation, a document, and a text explaining the relation of this tour step with the global process. In each step, the associated historical document is superimposed on the 3d scene and the user camera is positioned so that the 3d scene corresponds to what the document shows (for example : top view camera for a map document). See [Oriented Camera Mode](Definitions.md#oriented-camera-mode) definition. Each tour focuses on a specific process, and can link to other related tours.

**Example of guided tour** : "L'ilôt du lac" which aims to illustrate how a small lake in the 1850s affected the evolution of a building block until the 1980s. A first "step" shows the city block in the 1850s with the lake and an historical map, a second step shows the block after the lake was filled (with another historcal map), another step shows the demolition and reconstruction of the block (modern buildings) etc...

### Notes:

* Challenges : visual clarity (image (historical doc) + text (info) + 3d scene), user movement in 3d space + time, transition between free exploration and guided tour (access, exit, resume), display the historical uncertainty of the 3d reconstruction.
* Ideas : display the past in grayscale (visual similarity with old photos ?)
