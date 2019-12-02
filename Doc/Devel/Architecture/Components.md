<img src="Diagrams/ComponentDiagram-macro-components-with-notes.png"
     align=center
     alt="ComponentDiagram-macro-components-with-notes.png" 
     width="600"
     border="0">

## Components (quick) description
 * **Client side**:<br>
   [Urban Data Viewer (UDV)](https://github.com/MEPP-team/UDV) is a repository gathering [WebGL](https://en.wikipedia.org/wiki/WebGL), [iTowns](https://github.com/iTowns/itowns), javascript components dedicated to Uban Data (with a 3D geospatial description) visualisation. The UDV sub-components are regrouped in [UDV/UDV-Core](https://github.com/MEPP-team/UDV/tree/master/UDV-Core) and include
     - [UDV/Guided Tour](https://github.com/MEPP-team/UDV/tree/master/UDV-Core/src/Modules/GuidedTour)
     - [UDV/Temporal](https://github.com/MEPP-team/UDV/tree/master/UDV-Core/src/Modules/Temporal)
     - [UDV/Documents](https://github.com/MEPP-team/UDV/tree/master/UDV-Core/src/Modules/Documents), [UDV/DocumentComments](https://github.com/MEPP-team/UDV/tree/master/UDV-Core/src/Extensions/DocumentComments), [UDV/DocumentValidation](https://github.com/MEPP-team/UDV/tree/master/UDV-Core/src/Extensions/DocumentValidation)
     - [UDV/Crontibute](https://github.com/MEPP-team/UDV/tree/master/UDV-Core/src/Extensions/Contribute)
     - [UDV/Authentication](https://github.com/MEPP-team/UDV/tree/master/UDV-Core/src/Extensions/Authentication)
     - [UDV/Links](https://github.com/MEPP-team/UDV/tree/master/UDV-Core/src/Modules/Links)
     - [UDV/Geocoding](https://github.com/MEPP-team/UDV/tree/master/UDV-Core/src/Extensions/Geocoding)
     
   Third party components:<br>
     - [iTowns](https://github.com/iTowns/itowns)
      
 * **Backend**      
   - [py3dtiles](https://github.com/MEPP-Team/py3dtiles/) : a fork of [Oslandia's py3dtiles](https://github.com/Oslandia/py3dtiles/)
   - LibCityProcess: a library [repackaging 3DUse filters](https://github.com/MEPP-team/3DUSE/issues/39) as a separate component
      * [SplitBUilding](https://github.com/EricBoix/3DUSE/blob/master/src/utils/cmdline/splitCityGMLBuildings.cxx)
      * [ChangeDetection](https://github.com/EricBoix/3DUSE/blob/master/src/utils/cmdline/extractBuildingsConstructionDemolitionDates.cxx)

<img src="Diagrams/ComponentDiagram-macro-components-and-subcomponents.png"
     align=center
     alt="ComponentDiagram-macro-components-and-subcomponents.png"
     width="400"
     border="0">
       
## Historical notes
Here is a list of aging/deprecated components
 * **Client side**:
   - [UDV/EarlyPrototype](https://github.com/MEPP-team/UDV/tree/master/EarlyPrototype) holds the first prototype version
   - Vilo3D: refers to an ancient [UDV release tag](https://github.com/MEPP-team/UDV/releases/tag/Vilo3D-Demo-1.0) used in the context of [Vilo3D project](http://imu.universite-lyon.fr/projet/vilo-3d-la-fabrique-urbaine-des-processus-a-leurs-representations-3d/) )
 * **Backend**      
   - [building-server](https://github.com/MEPP-team/building-server/): a fork of [Oslandia's building-server](https://github.com/Oslandia/building-server/) that can be seen as API delivering 3DTiles (build with [py3dtiles](https://github.com/MEPP-Team/py3dtiles/)) and using a pre-computed index.
