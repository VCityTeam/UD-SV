(Work in progess)

## Overview : WebGL frameworks & game engines

[List of WebGL frameworks (wikipedia)](https://en.wikipedia.org/wiki/List_of_WebGL_frameworks)

* [Unity](https://docs.unity3d.com/Manual/webgl-gettingstarted.html) : cross-platform game engine with a built-in IDE. Industry standard for videogame development. Allows for quick prototyping. Comprehensive documentation, huge community. However, its WebGL implementation (WebGL player) is not native (.NET transpiled) : high compilation & loading time, browser-dependant performances, all assets loaded into browser memory. Non-optimized games will not run smoothly.

* [Three.js](https://threejs.org/) : cross-browser JavaScript library/API used to create and display animated 3D computer graphics in a web browser. Although not game-oriented, can be used to build browser-based games : dungeon crawler ([Keep Out](http://www.playkeepout.com/)), futuristic racing ([HexGL](http://hexgl.bkcore.com/)), even MMORPG ([Iron Bane](http://ironbane.com/)). Three.js has no built-in physics (collision) engine, however physics engine like Bullet.js or Cannon.js can be used in conjunction.

* [Whitestorm.js](https://whsjs.io/#/) : 3D JavaScript library/API based on Three.js that simplify code, adds physics (ammo.js) and post-effects. More game-friendly than Three.js.

* [Babylon.js](https://www.babylonjs.com/) : JavaScript framework for building 3D games with HTML 5 and WebGL. Uses Cannon.js physics engine. Even more game-oriented than Whitestorm.js. Does not use Three.js (-> not good with Itowns ?).

* [PlayCanvas](https://playcanvas.com/) : 3D game engine/interactive 3D application engine alongside a proprietary cloud-hosted creation platform that allows for simultaneous editing from multiple computers via a browser-based interface. Probably not relevant here, but worth a look (backed by Activision and Mozilla, growing community).

Unity would offer the best development workflow & utilities, can be considered for use if and only if its WebGL player is optimized in the future. We would also need to "plug" it to the city database. No affinity with Itowns.

Babylon.js looks promising for browser games in general, however the project is still young and the community small (but growing). The biggest issue is that it does not use Three.js, which make it harder to plug it into Itowns (?).

A three.js-based solution seems to be our best candidate at the moment (easier to integrate into Itowns). Three.js alone can be enough for a simple game / interactive virtual tour. Whitestorm.js adds physics, post-effects (could be needed for future gamification projects, but probably not right now) and maybe more utilities (to be investigated...).

-> Three.js / Whitestorm.js ?





 
 
