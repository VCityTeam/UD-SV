# Need 021: ability to 3D display the city for a given date 

Definition: a **time-state-city** is a set of city objects all sharing the given date.

Definition: a **timed-[frustum](https://en.wikipedia.org/wiki/Frustum)-state of a city** 
is a time-state-city whose city objects lie within a specified frustum.

### User story
As an application developer I want to retrieve a time-state-city so that I can display it.

### Beneficiary role:

### Impact: major

### Maturity: ongoing

### Cost evaluation:

### Tags or keywords

### Description
The state of city is the geometry of the city for the considered date.
FIXME-ESC

### Notes:
[Sequence diagram](https://en.wikipedia.org/wiki/Sequence_diagram):
 1. the applications requests a refreshement of the scene for a given date to the iTowns framework 
 2. some iTown sub-component (3dtiles provider) passes the time-stat-city request to a 3Dtiles-server (or a server adapter)
 3. the 3Dtiles-server forwards the request to a DBCity server
 3. the DBCity server replies with a collection of a cityobjects to the 3Dtiles-server
 4. 3Dtiles-server packages the answer into a b3dm object that it handles 
    over to the iTowns framework
 5. The 3Dtiles-provider parses the b3dm object to convert it to Threejs object (mesh) 
    that is integrated to the scene
    
This implies changing the 3Dtiles specification making it a 3D+time specification.
