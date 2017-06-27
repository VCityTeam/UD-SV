# Need 006: ergonomic user exploration of space  : camera movement

### User story
As an historian, i want to be able to easily navigate the 3d scene (camera control) and follow scripted paths from current location to a specific target (scripted movement).

### Beneficiary role:
everyone, more specifically non-technical users

### Impact: medium

### Maturity: young (prototyped)

### Cost evaluation: ?

### Tags or keywords

### Description:

**Camera control** : various ways of moving the user (camera) through the 3d scene. Current (existing) user controls : translation with left mouse click + drag, rotation/orbit with right mouse click + drag, zoom with mousewheel. Could be made more ergonomic (eg : google map) with position clamping, speed adjustments, .

**Scripted movement** : scripted camera movement from current user position to a target position. Orientation also adjusted to match a specific target orientation. Both movement and orientation can be smoothed (speed follows a sigmoid curve). Example : clicking on a document moves the camera to the relevant position and orientation (to match the document subject). Also used in guided tours to move from step to step. Could also be used to move the user when he clicks on a position on the **minimap**.

### Notes:

