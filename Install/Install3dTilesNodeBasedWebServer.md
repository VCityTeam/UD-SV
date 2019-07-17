## Simple to install 3DTiles web server ([node.js](https://nodejs.org/en/) based) 

In the context of development (e.g. on your desktop)and if you need to handle over [3DTiles tilesets](https://github.com/AnalyticalGraphicsInc/3d-tiles) for your client to display then you can deploy a local (on your desktop computer) web (http) server. A quick and easy way to do so (on your desktop) consists in installing a (node.js based) [3d-tiles-samples](https://github.com/AnalyticalGraphicsInc/3d-tiles-samples) server.

The quick installation goes
````
    git clone https://github.com/AnalyticalGraphicsInc/3d-tiles-samples
    cd 3d-tiles-samples
    npm install
    npm start
````
The examples tilesets will then appear as hosted at the `http://localhost:8003/tilesets/` address.
