# 3DTiles Temporal Extention documentation extracted from Jaillot 2020
**[[Jaillot 2020] Vincent Jaillot. 3D, temporal and documented cities : formalization, visualization and navigation. Computer Vision and Pattern Recognition [cs.CV]. Université de Lyon, 2020. English. NNT : 2020LYSE2026. tel-03228436](https://tel.archives-ouvertes.fr/tel-03228436/document)**

# 3.2 Specification into 3D Tiles (Page 38)

## 3.2.1 3D Tiles logical model and temporal extension

Figure 3.5 presents both Logic3DGeo and Logic4DCity. Logic3DGeo (in white)
is a proposition of logical model of the 3D Tiles standard. It depicts the current
state of 3D Tiles (version 1.0) [Ope19] and covers all the data modelling part
of the specification. Logic3DGeo is a specification of Gen3DGeo. Logic4DCity is a
logical model for delivering time-evolving 3D city models on the web. It integrates the
formalization of the temporal dimension to Logic3DGeo. Logic4DCity is a specification
of Gen4DCity. The recursive composition association of Geographic Feature (thick
line) is a proposition of conceptual representation of hierarchical relationships
between geographic features of 3D city models (i.e. a conceptual representation of
the batch table hierarchy extension of 3D Tiles^1 ).

3D Tiles is composed of a _Tileset_ (corresponding to _Set_ of _Gen3DGeo_ ). _Asset_ ’s at-
tributes _version_ (version of 3D Tiles) and _tilesetVersion_ (identifier for tracking updates
of a _Tileset_ ) are not related to representing the evolution of the city over time. A
_Tileset_ is composed of a set of _Tiles_ (corresponding to _Spatial Nodes_ of _Gen3DGeo_ ).
Each _Tile_ has up to two _BoundingVolumes_ : _boundingVolume_ and _viewerRequestVolume_.
The _viewerRequestVolume_ makes it possible to specify a volume where the tile must
be displayed (i.e. the content of the tile is displayed only if the camera is inside
this volume). Each _Tile_ has a _TileContent_ that can also have a _BoundingVolume_ ,
which must closely fit the geographic features of the tile. The _TileContent_ references
either a _Tileset_ or a _FeatureSet_ , which is a collection of _Geographic Features_ plus
some _FeatureSetProperty_ (e.g. number of points, offset, scale, etc.). The _FeatureSet_
entity depicts a generalization of the formats proposed by the 3D Tiles community
to represent geographic features: Batched 3D Model (b3dm), Instanced 3D Model
(i3dm), Point Cloud (pnts) and Composite (cmpt). A _Geographic Feature_ (corre-
sponding to _Geographic Feature_ of _Gen3DGeo_ ) can have a _Geometry_ ( _Geometry_ of
_Gen3DGeo_ ). It can also have _FeatureProperties_ ( _Thematic Attribute_ of _Gen3DGeo_ )
such as application-specific attributes (e.g. the owner of a building) or appearance
information (e.g. color or texture coordinates). A _Geometry_ can belong to several
_Geographic Features_ , so it is possible to have a 3D model instanced several times
(e.g. with different positions or different scales such as in the i3dm format). At the
technical specification level, a _Thematic Attribute_ is stored in a batch table or in a
feature table depending on the property and on the format (b3dm, i3dm, etc.).

We integrate the formalization of the temporal dimension proposed in _Gen4DCity_
with the entities in gray. Most of the concepts have been integrated by direct
mapping from _Gen4DCity_ thanks to the abstract modelling work done in section3.
and to the mapping of _Gen3DGeo_ to _Logic3DGeo_ described above. _VersionTransition_ ,
_Version_ and _Transaction_ are aggregated in the _Tileset_ since they are associated with
_Geographic Features_ across the _Tileset_ (i.e. that can be in different _Tiles_ ). The
_Spatial Node_ ’s _Period_ (from _Gen4DCity_ ) is aggregated in the _Bounding Volume_ and
not in the _Tile_ (which could have been done by direct mapping since _Spatial Node_ is
mapped to _Tile_ ). This way, not only can the _Tile_ ’s _boundingVolume_ attribute have a

* (^1) https://archive.softwareheritage.org/browse/directory/657e37e75fcc50bc0fc4e8fbb20adb6a88149a1d/?origin=https://github.com/AnalyticalGraphicsInc/3d-tiles

![Figure 3.5](https://user-images.githubusercontent.com/23373264/159284795-f6f7b5a7-364c-4f4e-9cdd-4197237f5166.png)

Figure 3.5.: Logic4DCity : logical model for delivering time-evolving 3D city models on the
web based on extending 3D Tiles. A logical model of 3D Tiles, Logic3DGeo , is
proposed in white and the temporal extension is represented in gray. The recur-
sive composition association of Geographic Feature (thick line) is a conceptual
representation of the batch_table_hierarchy extension of 3D Tiles.

Period , but also its viewerRequestVolume and the TileContent ’s boundingVolume. The
boundingVolumes make it possible to index Geographic Features using spatio-temporal
indexing methods. The viewerRequestVolume makes it possible to show the content
of a Tile only when the display date (date at which the data is displayed to the user)
is inside its Period.
In section3.2.2, we propose the technical specification of the temporal formalization.
This technical specification is an extension of 3D tiles. We name it 3DTiles_temporal
(following the naming convention of 3D Tiles extensions).

## 3.2.2 Technical specification of the temporal extension

3D Tiles contains concepts named extension and extra that allow to extend the
core specification. Figure3.6is a proposition of description of these concepts.
Extension makes it possible to extend 3D Tiles entities. It has a name and it is
composed of an application-specific Object. An Object can be composed of other
Objects and/or Attributes. Extensions can be aggregated in an ExtensionSet. An
ExtraSet is a collection of Extras. An Extra is an application-specific Attribute , making
it possible to add specific metadata to 3D Tiles entities. All the entities of the 3D
Tiles specification can have an ExtensionSet and an ExtraSet. In other words, all the
implemented classes of Logic3DGeo (i.e. of the 3D Tiles specification) can have an
ExtensionSet and an ExtraSet.

![Figure 3.6](https://user-images.githubusercontent.com/23373264/159288540-d64002f1-ec29-4932-b738-2682f9dc8898.png)

Figure 3.6.: Description of the concepts for extending 3D Tiles.

The 3DTiles_temporal extension specification is described with JSON schemas, which
we make available online^2. It uses the Extension concept. This way, the core of the
standard is not modified, but there is still an impact on users of 3D Tiles.
The specification is composed of three Extension objects respectively aggregated
in Tileset , BoundingVolume and BatchTable. The extension of the Tileset has a
startDate and an endDate and stores versions , versionTransitions and transactions.
The extension of the BoundingVolume also has a startDate and an endDate to allow
the representation of 4D bounding volumes and hence the use of spatio-temporal
indexing. The BatchTable is where the thematic attributes of features are stored.
We extend it with two arrays representing the time of existence of each Feature ,
namely startDates and endDates. The extension of the BatchTable also holds an array
of identifiers of Features , enabling their referencing in transactions and versions.
This specification results from models previously presented and in particular from
Logic4DCity.
The models proposed in this section allow to model the temporal dimension of 3D
city models by extending the 3D Tiles standard format. In particular, they allow
to keep track of the evolution of 3D city models’ features at various granularity
levels and to add thematic information to these, which was some of the challenges
stated in the introduction of this chapter. In the next section, we propose an
implementation of these propositions, demonstrating that they allow to achieve
interactive spatio-temporal visualization of large-scale time-evolving 3D city datasets
on the web.

# 3.3 Implementation and evaluation

In this section we present an implementation allowing to deliver and visualize time-
evolving 3D city models on the web with the 3DTiles_temporal extension proposed in
this chapter. We start with a presentation of the software architecture (section3.3.1).
We continue with an evaluation of our propositions in comparison with existing
standards (section3.3.2). We finish with the proposition of visualization rules for
urban evolution visualization and apply them for the visualization of a time-evolving
3D city model (section3.3.3).

* (^2) https://doi.org/10.5281/zenodo.

## 3.3.1 Software architecture


We propose an open-source web prototype allowing to create, deliver and visualize
time-evolving 3D city models, implementing the 3DTiles_temporal extension. The
software architecture of this prototype is represented in figure3.7. In this section,
we only give an overview of this architecture to facilitate understanding of the
evaluation of our contributions. A more detailed view of the software architecture
and implementations are presented in chapter 5.

![Figure 3.7](https://user-images.githubusercontent.com/23373264/159288646-9be898e1-ad31-4e3b-9409-9462deb117ce.png)


Figure 3.7.: Software architecture for creating, delivering and visualizing time-evolving 3D
city models, implementing the 3DTiles_temporal extension.

py3dtiles^3 allows to create 3D Tiles datasets from various sources (e.g. 3DCi-
tyDB [Yao+18], LAS files [PRS11], etc.). We contributed to the implementa-
tion of the 3D Tiles specification in py3dtiles. In addition, we implemented the
batch_table_hierarchy extension of 3D Tiles (allowing to represent hierarchical rela-
tions between objects) and the 3DTiles_temporal extension. We also implemented
two processes respectively allowing to create 3D city models in 3D Tiles ( City Tiler^4 )
and time-evolving 3D city models in 3D Tiles extended with 3DTiles_temporal ( City

* (^3) https://archive.softwareheritage.org/swh:1:rev:27c1ec918630215002da5e2115fa5d3775ed5210;origin=https://github.com/Oslandia/py3dtiles/
* (^4) https://archive.softwareheritage.org/swh:1:cnt:3fe3b38bf74758e1ac649e16d05c3c11f09076d4;origin=https://github.com/VCityTeam/py3dtiles/



Temporal Tiler^5 ). The City Tiler process allows to go from a 3DCityDB database
containing 3D city objects to 3D city models in 3D Tiles with tiles represented in
the b3dm format. The City Temporal Tiler takes two inputs: 3DCityDB databases
containing time-stamped city models of the same spatial area and a graph containing
the transactions between the features of these city models. From these inputs, it
computes a time-evolving 3D city model in 3D Tiles extended with 3DTiles_temporal ,
with tiles represented in the b3dm format. This process, as well as the pre-processing
steps allowing to compute the graph of transactions are fully detailed in section5.1.
This implementation is currently available on a specific version of py3dtiles^6. They
are planned to be integrated to the main version of py3dtiles after a few steps of
cleaning and refactoring.
The produced time-evolving 3D city dataset can be exposed through any HTTP
server ( Apache in our case) and can be visualized in the UD-Viz^7 web client. UD-Viz
allows to visualize, analyze and interact with geographic data (3D city models,
vectorial resources, maps, etc.). It is based on iTowns^8 , a framework for visualizing
3D geographic data. We contributed to the implementation of of 3D Tiles in iTowns
to make it more compliant with the specification and more flexible. In particular,
it is now possible to declare 3D Tiles extensions and associated applicative code in
a web client using iTowns and to plug them to iTowns from this web client. The
3DTiles_temporal is implemented this way in the Temporal module of UD-Viz. This
Temporal module is also in charge of the interfaces related to the temporal aspect (see
section3.3.3for screenshots and for an example use case). The City Object module
of UD-Viz allows to interact with city objects in the 3D scene (e.g. to display thematic
information of a building selected from the 3D scene). These implementations
are currently available on specific versions of UD-Viz^9 and of iTowns^10. They are
planned to be integrated to the main versions of iTowns and UD-Viz after a few steps
of cleaning and refactoring.

* (^5) https://archive.softwareheritage.org/swh:1:cnt:e9fca4145806c85d1ab4eec05cba628311fd3370;origin=https://github.com/VCityTeam/py3dtiles/
* (^6) https://archive.softwareheritage.org/swh:1:rev:39b23180b47ed3b995aeb5b8fa45aff56b88d353;origin=https://github.com/VCityTeam/py3dtiles/
* (^7) https://archive.softwareheritage.org/swh:1:rev:b5a523825862a3f2dd440c2922485cdd30009834;origin=https://github.com/VCityTeam/UD-Viz/
* (^8) https://archive.softwareheritage.org/swh:1:rev:e996369f1da742b8ca923f4c64d656f8d1a537db;origin=https://github.com/iTowns/itowns
* (^9) https://archive.softwareheritage.org/swh:1:rev:e915ff94f9902fa0def310e159beb3caf461ab59;origin=https://github.com/jailln/UDV/
* (^10) https://archive.softwareheritage.org/swh:1:snp:1f61a61af2dc46834e108c586373f043defcd687;origin=https://github.com/jailln/itowns//

Since the formalization of the temporal dimension has been integrated to 3D Tiles
as an extension (following the recommendations of the standard), it could be
implemented into other software components supporting 3D Tiles (e.g. Cesium^11 ).

* (^11) https://cesiumjs.org/
