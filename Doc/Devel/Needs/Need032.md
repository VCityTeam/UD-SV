
# Need 032: Provide a tool to place and orient a document in the scene.

Links:
 * [Issue](https://github.com/MEPP-team/RICT/issues/45)
 * Super need: [Need 004: enhancing city models with documents](Need004.md)

### User story
As a [Content Contributor](Roles.md#content-contributor), I want to be able to place documents in the 3D scene.

### Beneficiary role: 

### Impact: 


### Maturity: 
immature

### Cost evaluation: ?

### Tags or keywords

### Component


### Description
The possible types of documents are:
 - image: photo, diagram, drawing, maps...
 - text
 - audio
 - video
 
 They are two distinguished means for placing a document in a scene:
  - pinpoint where the document (all types of the above mentioned) is georeferenced to some location (point) 
  - spatial position where the document is restricted to be an image and the image is 
     - placed at a spatial position (3D over the territory)
     - oriented (e.g. with its normal in a case of an image)
     - scaled (spatial dimensions of the image)
 
 They are three display modes:
   - screen overlay: the document is attached to the screen that overlays the scene. When moving the camera the document display remains unchanged within the screen.
   - billboard: this mode presents a pinpointed document as a standing billboard (always facing camera position) refer to `[1]`
   - scene overlay: the image has a (fixed) spatial position. From a very specific viewpoint the image appears as fitting the geometry of the scene. When moving the camera out of this specific viewpoint the image remains at the same spatial position (within the scene) i.e. the image is attached to the scene not to the camera position. But away from the very specific viewpoint the image/scene fitting is visually lost (not apparent anymore).

Two different tools are needed:
 1. pinpoint locator: it allows to pintpoint a document (i.e. select, through mouse click, a georeferenced position and associate this pinpoint location to the document)
 2. ergonomic spatial positioner: the need here specifies 
    - the what: to provide a spatial position for an image document.
    - the how: a ergonomic mouse (keyboard?) based tool that allows the user to pick up an image and assists the user in placing it (position, orientation, scale) spatially within the scene such that the image appears as fitting the geometry of scene.

### Notes:
For the spatial positioner the tool could (for example) provide the following stream of actions:
 - allow for image selection
 - place the selected image in screen overlay
 - allow the user to change the camera position until the overlayed image appears as fitting the geometry of scene.
 - allow the user to signal that the current position is the desired one (click somewhere...)
 - switch the display to scene overlay 
 
### References:
`[1]`: Clément Chagnaud, John Samuel, Sylvie Servigne & Gilles Gesquière (2016), «[Visualization of Documented 3D Cities](https://hal.archives-ouvertes.fr/hal-01386601)», [PDF](https://www.researchgate.net/publication/313376189_Visualization_of_Documented_3D_Cities).
