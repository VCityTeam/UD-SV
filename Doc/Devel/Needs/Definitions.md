## Definitions/categories

### City object
Refer to [CityGML definition of CityObject](https://portal.opengeospatial.org/files/?artifact_id=16675): buildings, bridges, tunnels, vegetation, water bodies, transportation facilities, city furniture...

### City object reference
A reference to a city object (associate to a given media)

### Guided tour
A navigation in space and time step by step. Each step correspond to an historical moment and the camera is positioned and oriented depending on the document(s) related to this historical moment. A complementary text is displayed next to the document.

### Raw document 
Images, text, audio, and video

### Reference (aka link)
A [reference](https://en.wikipedia.org/wiki/Reference_(computer_science)) like a URI or an [URN](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier#URNs) 

### Associative entity 
A reference between city object(s) and document(s)

### Document metadata:
These metadata depend on the document and on the quantity of information available in and about this document. Document metadata and the associated information model are described in [Sam16] 
FIXME VJA

### Extended document
The bundle of a raw-document and its document-metadata

### Region of a city model:
Refer to [CityGML definition of LandUse](https://portal.opengeospatial.org/files/?artifact_id=16675)

### Historical moment
A date associated to a known event (e.g. modification of a geometry, new semantic information, new document, etc.)

### Historical period: 
Period between two historical moments (begining, end)

## To be defined
### Interface
The GUI FIXME ?

### Document browser
FIXME

### Geometrical view
The inteface component handling the 3D view of the geometry of the city ?

### Oriented camera mode
Related to a photo or video document. When the user interact with this document, he can enter into oriented camera mode : the document is displayed over/in the 3d scene and the camera moves to a position and orientation such that the document corresponds to the city geometry (example for a plan document : the plan is displayed over the region it represents, and the camera is placed so that the plan image is over the corresponding geometry).

 
## References
[Sam16] Samuel, J., Périnaud, C., Servigne, S., Gay, G., & Gesquière, G. (2016, October). Representation and Visualization of Urban Fabric through Historical Documents. In EUROGRAPHICS Workshop on Graphics and Cultural Heritage. : [Link](https://www.researchgate.net/profile/Sylvie_Servigne/publication/308416831_Representation_and_Visualization_of_Urban_Fabric_through_Historical_Documents/links/57e3d8a008ae4d15ffae8de9.pdf)
