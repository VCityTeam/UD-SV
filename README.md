**Quick links**
 * Demos: [UDV](http://rict.liris.cnrs.fr/UDVDemo/UDV/UDV-Core/), [temporal City](http://rict.liris.cnrs.fr/iTownsPlanar3DTiles/itowns/examples/planar_3dtiles.html)
 * [UD-Doc](UD-Doc): UD-SV documentation
 * [Developers' gateway](UD-Doc/DevelopersCentral.md)
 * [Projects](#projects)
 * [Components](UD-Doc/Devel/Architecture/Components.md)
 * [Needs](UD-Doc/Devel/Needs/EarlyNeeds.md)
 * [Developers's minutes, surveys...](https://github.com/MEPP-team/RICT/wiki)

## Objective of the RICT project

The objective of the RICT (Representation Information CiTy) project is to **experiment, exchange and share both knowledge and tools dedicated to the concrete handling of urban/city data**. RICT focuses on practilities and technical specificities of the full city data flow starting from database integration of raw data and ending in advanced visualizations of their downstream numerical treatments. RICT adopts an open approach and favors:
  * the adoption of mainstream standards of the urban modeling field
  * the re-use (and possible improvement/evolution) of existing open source software components

In particular RICT focuses on the design and realization of
  * a [backend](#aimed-backend-features): 
     - an infrastructure enabling the storage of city related data,
     - an infrastructure for hosting and executing computational models (using the local backend data as well as online open data).  
  * a [frontend](#aimed-frontend-features): 
     - a simple interactive visualizer of the backend data
     - a computational model treatment handler (configure, trigger, explore results of a treatment)

### Technical manifesto
We believe that in order to succeed with data usage one must not separate data concerns (information models, database infrastructure) from the offered tools, treatment process and the associated methodology. Questions like how to migrate a database when the information model changes (e.g. from CityGML version 2 to version 3), how to deal with information model modularity and extensions, what are the interactions between data and their treatment or how does one handle data storage and computation scale up, must be dealt at first. RICT will try to propose good practices for doing so.

## Projects
### Ongoing
 * [MAM and games](https://github.com/MEPP-team/RICT/wiki/MAM-and-games-(Project)): a joint project with the [Gamagora](https://gamagora.univ-lyon2.fr/) internship program focusing on the Model AugMented (MAM) approach
 * [MAM as a mediation tool](https://github.com/MEPP-team/RICT/wiki/MAM-as-mediation-tool-(Project)): Model AugMented Model (MAM) approach with the [Erasme team](http://www.polepixel.fr/residents/erasme/)  

### Closed
 * Model AugMented: MAM 2018 Erasme (proof of concep)t:
    - [project description](UD-Doc/Projects/MAM-Erasme-bootstrap/Readme.md)
    - [development gateway](https://github.com/MEPP-team/RICT/projects/3)

## Description of the needs
We collect [use case oriented early descriptions of the needs](UD-Doc/Devel/Needs/EarlyNeeds.md). 
Prior to any particular technical choice, this description of needs can help to
 * structure/organise the various involved roles
 * decompose the processes in atomic tasks and describe assembled processes
 
Eventually this structured description can 
 * lead to/orient good practices 
 * influence/structure the main architecture of components

## Seeked backend/frontend features
### Aimed backend features
The aimed backend features could be:
 * offer some [ETL tools](https://en.wikipedia.org/wiki/Extract,_transform,_load) starting from standard (or de facto standards used by mainstream crowd sourcing site like [OpenStreetMap](https://en.wikipedia.org/wiki/OpenStreetMap)) of City related data   
 * distributed logical data (?)
 * abstract level data access (i.e. use accessor API that are directly derived out of [UML](https://en.wikipedia.org/wiki/Unified_Modeling_Language) expressed [information models](https://en.wikipedia.org/wiki/Information_model)  
 * computational model execution engine
 
 ### Aimed frontend features
 The aimed frontend features could be:
   * 3D visualization of a territory
   * Use the [iTowns](http://www.itowns-project.org/) JS/WEBGL component (?)
