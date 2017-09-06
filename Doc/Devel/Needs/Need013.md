
# Need 013: Visualization of documents within a 3D representation of the city

### User story
As a historian I want to visualize and locate documents (images, videos, text...) in the 3d representation of the city. I need a preview of what the document is, and a visual indication of its position in the scene.

### Beneficiary role: 

### Impact: 

### Maturity:

### Cost evaluation:

### Tags or keywords
Document Visualization

### Description
The need can be fulfilled by billboards [1] integrated in the 3d representation of the city, anchored to the city object which is the subject of the document. Filtering/culling of the billboards may be needed to avoid cluttering. However [1] has been tested in a desktop environment and we also need to test this in a web environment.

There are two important aspects to be considered for every document (in billboard display):
* Position of the document billboard: In [1], we placed the document (image or document preview) exactly over the concerned city object (non-document city objects). There are other options, like in case of photographs, position the document on the point where the photograph was taken. Other important questions concerning document position:
  * How to automatically obtain document position from document references?
  * What's the position of a document when it refers one or more document objects.
* Position of the camera (quaternion): In [1], document always faced the user/camera. We also tried to maintain a fixed orientation for documents. Such a case means that we only have a partial view of a document as we move around the 3D scene.

### References:
1. Visualization of Documented 3D Cities, Clément Chagnaud, John Samuel, Sylvie Servigne, Gilles Gesquière, Eurographics Workshop on Urban Data Modelling and Visualisation, UDMV 2016, Liège, Belgium, Decembre 8, 2016

