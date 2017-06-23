# Need 003: means for a guided tour through space and time

### User story
As developper & game designer, I want to implement a guided tour of the city to illustrate historical urbanization processes, as a part of the Vilo3D project. 

Sub Needs :

* [Need004](Need004.md) : integration of historical data (images & text) within/over a 3D representation of the city
* [Need005](Need005.md) : ergonomic user exploration of time : temporal slider 
* [Need006](Need006.md) : ergonomic user exploration of space (advanced camera control, shortcut to point of interest...)
* [Need007](Need007.md) : guided tour, between spatiotemporal points of interest
* [Need008](Need008.md) : ability to display the historical uncertainty of the 3d reconstruction
* [Need009](Need009.md) : ability to use texture in the 3d scene
* [Need010](Need010.md) : ability to display multiple temporal versions of a building
* [Need011](Need011.md) : user interface (document, temporal slider, map...)
* [Need012](Need012.md) : ability to browse through a document base 

### Beneficiary role: ?

### Impact: ?

### Maturity: young / ongoing

### Cost evaluation: 3 months ?

### Tags or keywords

### Description

Vilo3D aims to provide a visualization tool for 3d city geometry (with temporal evolution), historical documents, and urbanization processes on the theme of "La Ville Ordinaire" (ordinary town : smallscale events) by Anne-Sophie Clemençon. The tool will have two modes : free tour and guided tour.
* In **free tour**, documents are integrated in the 3d scene (billboards) with some of them being hidden (LoD and/or filters) and the user can move freely in the 3d scene, and in time (which modifies which documents are displayed, and city gemotry when available).
* In **guided tour**, the user is moved from a "tour step" to another. A tour step is composed of a date (with corresponding city geometry), a position, an orientation, a document, and a text explaining the relation of this tour step with the global process. In each step, the associated historical document is superimposed on the 3d scene and the user camera is positioned so that the 3d scene corresponds to what the document shows (for example : top view camera for a map document). Each tour focuses on a specific process, and can link to other related tours.

**Example of guided tour** : "L'ilôt du lac" which aims to illustrate how a small lake in the 1850s affected the evolution of a building block until the 1980s. A first "step" shows the city block in the 1850s with the lake and an historical map, a second step shows the block after the lake was filled (with another historcal map), another step shows the demolition and reconstruction of the block (modern buildings) etc...


### Notes:

* Target audience : Experts in various fields, ranging from information technology to human sciences. Tools must be easy to use for non-technicians (focus needed on ergonomy).
* Challenges : visual clarity (image (historical doc) + text (info) + 3d scene), user movement in 3d space + time, transition between free exploration and guided tour (access, exit, resume), display the historical uncertainty of the 3d reconstruction.
* Ideas : display the past in grayscale (visual similarity with old photos ?)
