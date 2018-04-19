# Need 011: a graphical user interface (GUI)

### User story
As a historian, i will need easy access to all the functionalities of the tool : movement in the 3d scene, temporal evolution, document browser, guided tour, preferences... though a GUI.

Aggregator super need :
* Need 019: [navigate from selected geometries within the interface to the attached semantic information](Need019.md)

### Beneficiary role: 

### Impact:
major (cannot use the tool without it)

### Maturity:
young / ongoing (prototyped)

### Cost evaluation:

### Tags or keywords

### Description
The GUI will need to provide access to the following functionalities :
- 3d scene window : display preference & camera controls
- temporal evolution : jump to a date, specify start/end date (animation), move slider to change time
- document browser : previous/next doc, related doc, filters, search, orient doc + camera in the 3d scene
- guided tour : means to access the tour(s), start, exit, previous/next step

The GUI will use minimizing/maximimizing windows & sliders to keep from being too cluttered

### Notes:
 * Temporal slider presence must be toggable within the GUI. 
 * The slider should be a modular component used by the Application 
   (re-using it in another application must be straighforward)
