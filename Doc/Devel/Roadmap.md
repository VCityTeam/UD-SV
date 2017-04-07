## Strategic context
What VCity can currently do and that we **don't necessarily need to maintain/upgrade** (on condition to find other means to achieve the offered functionality)
 * libCityGML i.e. the C++ parsing library allowing the xml bindings to CityGML V2 doesn't need to be maintained nor does it need to be upgraded to CityGML V3. The strategy is here to use [3DCityDB importer/exporter](https://github.com/3dcitydb/importer-exporter) to be used as ETL into the database.
  * QT can be dropped since we migrate to a web based client version
 
What VCity can currently do and that we might wish to keep (for a midterm on long term)  
 * Feature: GUI treeview i.e. a hierarchical tree enabling to view/walkd on a CityGML document. Note that this view must be coupled with the 3D graphic view (bet it QT/OSG/OpenGL based or iTowns based)
 * Product (until end of 2018): the "fat client" approach can be dropped in favor of a client/server architecture. Nevertheless note that VCity current C++/QT fat client should still be kept alive until late 2018 (i.e. when CityGML V3 will be effective) since it still federates the team programming effort in order to offer a platform for the master/Phds students
 
 What needs to be embrace/developed:
  * CityGML V3 considered as an abstract model
  * Web-client/server architecture
  * Server execution engine for treatments
 
