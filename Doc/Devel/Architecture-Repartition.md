# Architecture & Repartition

[Direct link to edit the schema](https://docs.google.com/drawings/d/1Fn3ur8uXsjrH7YFseKu7XJrqCqmqu6xaxsCB6kSajzg/edit?usp=sharing) (after edition you need to download it as a .png, rename it as Architecture.png and upload it here, in .../devel/images).

![](images/Architecture.png)


* <img src="Design/images/A.png" width="30" height="30" />: it's the Web Application.

* <img src="Design/images/B.png" width="30" height="30" />: When the (A) sends a request (requests a tileset) here, iTowns requests to the (C). When the (C) returns the data on format [3DTiles](https://www.opengeospatial.org/standards/3DTiles) like b3dm, pnts ... , iTowns parses this and puts the data on [Three.js](https://discoverthreejs.com/) class. iTowns also manages the display.

* <img src="Design/images/C.png" width="30" height="30" />: The Building-Server receives the request, asks to the server (the database), recovers the data and converts it to 3DTiles format and sends it to the iTowns.
