## Architecture<a name="top"></a>

Architecture information is organized as follow:
  * [Components description](../../Tools/Readme.md)
  * [Application.md](Application.md) containing the architecture and related diagrams regarding the whole application.
  * [Itowns.md](Itowns.md) for ressources regarding iTowns inner architecture.
  * [Server.md](Server.md) for ressources about server components (currently for py3dtiles and building-server).
  * [3DCityDB.md](3DCityDB.md) for ressources regarding 3DCityDB and its enhancement.

## Other

### People
 * [Tatjana Kutzner (from TUM)](https://www.gis.bgu.tum.de/unser-team/lehrstuhlangehoerige/dr-tatjana-kutzner/)
    - Defines [ADE (network among others)](https://github.com/TatjanaKutzner/CityGML-UtilityNetwork-ADE) 
    - [Tatjana Kutzner's thesis (chapter 4.1 p63)](https://mediatum.ub.tum.de/doc/1341432/1341432.pdf) states that the key point is the ATL (Transformation Language) availability. In chapter 4.3.2 three tools are mentions FME (proprietary), Go Publisher (proprietary) and HALE (open-source).
 * [Kanishk Chaturvedi](https://github.com/kanishk-chaturvedi/CityGML-3.0) from [TUM](https://www.gis.bgu.tum.de/unser-team/lehrstuhlangehoerige/kanishk-chaturvedi/)
 
### Tools
 * [Enterprise Architect](http://www.sparxsystems.com/products/index.html#ult)
    - [OSX-Wine install](https://github.com/MEPP-team/VCity/wiki/OSX_Instal_Enterprise_Architect_-_2017_06_08)
    - [ShapeChange trial](https://github.com/MEPP-team/VCity/wiki/EA_and_ShapeChange_trial_-_2017_06_22)
    - EA automation:
      * [Java](https://exploringea.com/2013/12/11/ea-automation-with-java/)
      * [JavaScript](http://www.sparxsystems.com/enterprise_architect_user_guide/10/automation_and_scripting/the_scripter_window.html)
 * [OBEO designer](https://www.obeodesigner.com/en/) and [UML designer](http://www.umldesigner.org/) 
   - [Obeo Designer Academic Program](https://www.obeodesigner.com/en/academic-program) is available for research or educational purposes.
   - [Sirius community](https://www.eclipse.org/forums/index.php?t=thread&frm_id=262) (pointed [here](https://www.obeodesigner.com/en/resources))
   - See also [Importing CityGML trial](https://github.com/MEPP-team/VCity/wiki/Obeo_designer_trial_-_2017_06_22/_edit)     
 * [MEGA UML](http://www.mega.com/en/resource/mega-uml-hopex) by [MEGA](http://www.mega.com/en)
 * Generate postgresql database tables diagram with  
    - [schemaspy](https://stackoverflow.com/questions/3223770/tools-to-generate-database-tables-diagram-with-postgresql) looked promising but couldn't make it work. Whatever arguments you provide for host, port, password it will generate something in `./schemapy/index.html` instead of complaining about wrong authentication (or could it be that is a social engineering scam to obtain the access codes?)
    - Note: Mysql-workbench only works with MySQL...

### References
  * [Software architecture](http://ftacademy.org/sites/ftacademy.org/files/materials/fta-m11-soft_arch-pre.pdf) by Bijlsma, Heerendr, Roubtsova, Stuurman
  * [A Reminder On Three/MultiTier Layer Architecture Design](https://www.hanselman.com/blog/AReminderOnThreeMultiTierLayerArchitectureDesignBroughtToYouByMyLateNightFrustrations.aspx) (by Scott Hanselman): **"If you are designing a layer, know your in's and out's and for Goodness' Sake know your responsibility.  If you don't, back to the drawing board until you do."**
  * [Difference between CRUD and REST](https://softwareengineering.stackexchange.com/questions/120716/difference-between-rest-and-crud): [CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete) means the basic operations to be done in a data repository. [REST](https://en.wikipedia.org/wiki/Representational_state_transfer) operates on resource  representations (complex objects abstractions), each one identified by an URL. In short: **same thing, different layers** (CRUD falls within the Data Access layer while REST fits in the Business layer).
  * [Stateless vs Stateful](https://en.wikipedia.org/wiki/Stateless_protocol) protocols: there can be **complex interactions between stateful and stateless protocols** among **different protocol layers**. For example, HTTP is an example of a stateless protocol layered on top of TCP, a stateful protocol, which is layered on top of IP, another stateless protocol, which is routed on a network that employs BGP, another stateful protocol. Note: REST**ful** is state**less**.
  
### Notes
 * [uWSGI](https://uwsgi-docs.readthedocs.io/en/latest/) is a [Web Server Gateway Interface (WSGI)](https://en.wikipedia.org/wiki/Web_Server_Gateway_Interface) compatible applications and frameworks (used among the Python community). [uWSGI can be deployed](https://uwsgi-docs.readthedocs.io/en/latest/WebServers.html) with its own integrated http server. [Flask](http://flask.pocoo.org/) is a [web micro-framework](https://en.wikipedia.org/wiki/Flask_(web_framework)) that uses [uWSGI as web deployment option](http://flask.pocoo.org/docs/0.12/deploying/uwsgi/).
 * The `citygml2PSQL.py` and `building_server_processdb.py` both update a database. Yet note that the usage of `citygml2PSQL.py` is at the command line level (its input is a file and it uses a [shell based pipe](https://en.wikipedia.org/wiki/Pipeline_(Unix) mechanism) and is hence offline) whereas `building_server_processdb.py` is at the SQL protocol level (hence online or networked). 
 * The [DTM](https://en.wikipedia.org/wiki/Digital_elevation_model) terrain data is downloaded on the fly by iTowns (in the case of Lyon directly from [Grand Lyon WMS server](https://download.data.grandlyon.com/wms/grandlyon?SERVICE=WMS&REQUEST=GetMap&LAYERS=MNT2012_Altitude_10m_CC46&VERSION=1.3.0&STYLES=&FORMAT=image/jpeg&TRANSPARENT=false&BBOX=1840285.7887575002,5172130.550769992,1841520.2114662502,5173177.596804991&CRS=EPSG:3946&WIDTH=256&HEIGHT=256).
 * The deployed REST server uses [3DTiles](https://github.com/AnalyticalGraphicsInc/3d-tiles) (made by the [Cesium consortium](http://cesiumjs.org/about.html) i.e. mainly an [AGI ( Analytical Graphics, Inc.)](http://www.agi.com/home) emanation.
