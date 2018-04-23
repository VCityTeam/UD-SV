
## Need 004: Enhancing city models with documents

### User story:

As an historian, I want to be able to enhance city models with documents. I want to be able to manage, visualise (in the 3D scene as billboard display[1] AND in the document browser) and interact with the documents. I also want to be able to associate them to city object(s) and/or other document(s) [2].

Related need :
* Need 003: [document-enhanced 4d representation of the city to detail historical processes](Need003.md)

Sub Needs (in information stream order):
  * Need 035: [conceptual and physical model of Extended Documents](Need035.md)
  * Upload:
    * Need 008: [account for Content Contributor](Need008.md)
    * Need 014: [provide a user friendly interface to add one document](Need014.md)
    * Need 031: [Provide a user friendly interface to bulk load documents](Need031.md)
    * Need 032: [tool to place and orient a document in the scene](Need032.md)
  * Updating  
    * Need 020: [manage (CRUD) extended documents](Need020.md)
    * Need 028: [A CRUD API for extended documents](Need028.md)
  * Visualization/Usage   
    * Need 015: [Oriented camera mode for documents](Need015.md)
    * Need 013: [visualization of documents within a 3D representation of the city](Need013.md)

### Beneficiary role:
[Researchers (historians, geographers, urbanists)](https://github.com/MEPP-team/RICT/blob/master/Doc/Devel/Needs/Roles.md#city-knowledgeable-person) and [general audience](https://github.com/MEPP-team/RICT/blob/master/Doc/Devel/Needs/Roles.md#general-audience)

### Impact: 
Major

### Maturity: 
immature. 

### Cost evaluation:
?

### Tags or keywords
Documents, City models

### Description
Researchers and practitionners using virtual representations of cities need to add/attach documents to these representations in order to complement them. These documents are heterogeneous medias (images, text, audio, video, etc.), can come from multiple sources (i.e. from random citizen to experts) and can be linked to different scales objects (i.e. smokestack, bridge, city, etc.). There are two main use cases:
* Users navigate the 3D (or 4D) scene and relevant documents appear on the scene considering the user context.
* Users make use of search box to specify search terms and search results, i.e., documents matching user query are highlighted.

Major steps to enhance city models with documents are given below.
1. Integrating conceptual city model with documents. Conceptual models of cities are integrated with key metadata involving document name, creator etc. along with document references to city objects, and other documents. Refer [2] for more details. The major idea of the work was to consider documents as city objects, thereby allowing a very generic view.
2. Visualization of documents in 3D scene. There are several ways by which documents can be displayed in a 3D scene, e.g., document titles etc. However one approach taken by [1] was to display the documents, especially images in a billboard style. Documents are displayed over the concerned city object.
3. Search and filter documents: Another required feature is to permit users to search or filter documents according to desired criteria. By considering a generic approach, i.e., documents are also city objects, users are now able to search documents as city objects. However, multiple documents are not highlighted or documents not matching search query are not hidden from the urban scene.
4. User context: User context must be considered in order to reduce the number of documents displayed on the 3D scene. Users  classified into tourists, historians etc. get different views of the urban scene (with relevant documents.) based on their context. Document metadata is used to decide relevance of documents.

### References
1. Visualization of Documented 3D Cities, Clément Chagnaud, John Samuel, Sylvie Servigne, Gilles Gesquière, Eurographics Workshop on Urban Data Modelling and Visualisation, UDMV 2016, Liège, Belgium, Decembre 8, 2016
2. Representation and Visualization of Urban Fabric through Historical Documents, John Samuel, Clémentine Périnaud, Sylvie Servigne, Georges Gay, Gilles Gesquière, 14th EUROGRAPHICS Workshop on Graphics and Cultural Heritage, Genova, Italy, October 5-7, 2016 
