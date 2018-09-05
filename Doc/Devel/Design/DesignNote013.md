# Basic work to represent billboards in UDV

We present here a first proposition to modelize a billboard in UDV using JS-library Three.js:
A billboard is a plane geometry supporting an image that we want to represent. A billboard is placed above the point of the city that it represents. It is linked to it by a so called "anchor line", representing the depency of the document to the geographic coordinates.


```
//Billboard modelization
var objGeometry = new THREE.PlaneGeometry(12,10); //creation of a planar geometry
var texture = new THREE.TextureLoader().load( //link to the image   ); 
var material = new THREE.MeshBasicMaterial( { map: texture, side: THREE.DoubleSide } );
var object = new THREE.Mesh(objGeometry.clone(), material);
object.name = "billboard";
object.scale.(texture.image.width /50, texture.image.height /50); //scale the object with image proportion
object.quaternion.copy( this.view.camera.camera3D.quaternion );//face camera when created. 
object.position.y= //depends on your document
object.position.x= 
object.position.z= 
object.updateMatrixWorld(); //aply changes
view.scene.add(object); //add the object to the scene

//modelization of the anchor line
var mat = new THREE.MeshBasicMaterial( { side: THREE.DoubleSide, color: 0xffffff } ); //white
var stick = new THREE.Mesh(objGeometry.clone(), mat);
stick.name = "stick";
stick.position.y= //depends on your data
stick.position.x=    
stick.position.z=    
stick.scale.set(0.7,80,100);
stick.quaternion.set(0,0,1); //vertical
stick.updateMatrixWorld();
view.scene.add(stick);
this.view.notifyChange(true);
```

Allow billboards to always face camera:
```
function updateBillboardOrientation(){
    view.scene.children.forEach((child) => {
        if(child.name == "billboard" || child.name == "stick"){
          child.quaternion.copy( view.camera.camera3D.quaternion );
          child.updateMatrixWorld();
        }
      })
    }

//The function should be called at every frame:

view.addFrameRequester( MAIN_LOOP_EVENTS.AFTER_CAMERA_UPDATE,this.updateBillboardOrientation.bind(this) );
```

### References:
1. Visualization of Documented 3D Cities, Clément Chagnaud, John Samuel, Sylvie Servigne, Gilles Gesquière, Eurographics Workshop on Urban Data Modelling and Visualisation, UDMV 2016, Liège, Belgium, Decembre 8, 2016
