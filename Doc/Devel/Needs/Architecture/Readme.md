## Architecture

### People
 * [Tatjana Kutzner]([an XSD](https://github.com/TatjanaKutzner/CityGML-UtilityNetwork-ADE) from [TUM](https://www.gis.bgu.tum.de/unser-team/lehrstuhlangehoerige/dr-tatjana-kutzner/)
 * [Kanishk Chaturvedi](https://github.com/kanishk-chaturvedi/CityGML-3.0) from [TUM](https://www.gis.bgu.tum.de/unser-team/lehrstuhlangehoerige/kanishk-chaturvedi/)

### iTowns2
![JGA's architecture diagram](https://github.com/MEPP-team/RICT/blob/master/Doc/Devel/Needs/Architecture/Pictures/2017_05_03_-_JGA_Achitecture_diagrama.png)
[Associated JGA's description](https://github.com/MEPP-team/RICT/wiki/2017_05_03_-_JGA_iTowns2_presentation)

![Sketchy iTowns usage/developing  context](Diagrams/OslandiaiTown2Context.png)

### 3DCityDB
[3DCityDB architecture diagram](https://github.com/3dcitydb/3dcitydb-web-map#architecture)
 
### References
  * [Software architecture](http://ftacademy.org/sites/ftacademy.org/files/materials/fta-m11-soft_arch-pre.pdf) by Bijlsma, Heerendr, Roubtsova, Stuurman
  * [A Reminder On Three/MultiTier Layer Architecture Design](https://www.hanselman.com/blog/AReminderOnThreeMultiTierLayerArchitectureDesignBroughtToYouByMyLateNightFrustrations.aspx) (by Scott Hanselman): **"If you are designing a layer, know your in's and out's and for Goodness' Sake know your responsibility.  If you don't, back to the drawing board until you do."**
  * [Difference between CRUD and REST](https://softwareengineering.stackexchange.com/questions/120716/difference-between-rest-and-crud): [CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete) means the basic operations to be done in a data repository. [REST](https://en.wikipedia.org/wiki/Representational_state_transfer) operates on resource  representations (complex objects abstractions), each one identified by an URL. In short: **same thing, different layers** (CRUD falls within the Data Access layer while REST fits in the Business layer).
  * [Stateless vs Stateful](https://en.wikipedia.org/wiki/Stateless_protocol) protocols: there can be **complex interactions between stateful and stateless protocols** among **different protocol layers**. For example, HTTP is an example of a stateless protocol layered on top of TCP, a stateful protocol, which is layered on top of IP, another stateless protocol, which is routed on a network that employs BGP, another stateful protocol. Note: REST**ful** is state**less**.
