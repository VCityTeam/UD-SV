### 3D Portrayal services

doc : http://docs.opengeospatial.org/is/15-001r4/15-001r4.html

3D PS est la première spécification de l'API Geovolumes, qui a évolué depuis. 
L'idée derrière 3DPS est d'oublier le format de donnée des géométries (comme pour jpeg, png ...)

Il décrit un service de requête d'objet 3d avec un ensemble de requête :
-   GetCapabilities : retourne les layers mis a disposition par le service
    pour chaque layer : 
    - nom
    - description
    - wsg84 bounding box
    - id
    - availableCRS
    - availableLOD
    - availableStyle
    - etc ..

- GetRessourcebyID

- deux types de ressources "portail" possible :
    - GetScene : The response to a valid GetScene request is a document of the MIME type as specified in the request Format parameter, except under error conditions. This document contains a 3D scene assembled from the features of the selected Layers (mainly) within the specified BoundingBox, represented in the specified CRS, Format, and Styles.

    - GetView : Allows a client to retrieve readily rendered images, i.e., visual representations of an underlying 3D scene, as plain standard images. Image generation is done completely on the server side.

En bref, 3DPS décrit un service permettant le stockage et requêtage d'object 3D (gtlf, 3DTiles, GML, pointcloud ...) soit en format brut (il n'existe pas de conversion à la demande obligatoire, chaque layer peut être stocker sous différent format mais doit être pré-calculé), soit en image prête à être affiché telle quelle par le viewer, avec un ensemble de paramètre à définir dans la requete. 

implémentation test (sans getview): https://gitlab.com/tomeof/node-3dps


### Geovolumes API (3D container API)

Ressource :
- https://docs.ogc.org/per/20-029.html
- requirement : https://docs.ogc.org/per/20-030.html
- https://docs.ogc.org/per/20-031.html
- https://web3d.siggraph.org/wp-content/uploads/2020/11/SCS_Workshop_3D_Standard.pdf

Décrit une API permettant à un serveur de servir des données 3D géospatial en utilisant un flux standardisé. Ces données sont organisées dans l'espace. 
De plus, il est possible de créer en amont des process permettant la transformation et conversion de données à la volée sur le serveur afin de répondre à des query

![geovolumes](https://github.com/VCityTeam/UD-SV/blob/master/ImplementationKnowHow/images/geovolumes.png)

3D-Container (geovolume): Ressource d'informations spatiales avec un volume de délimitation distinct, un cadre de délimitation (obligatoire) (2D / 3D), 
contenant au maximum un ensemble de données de modèle 3D. Chaque volume peut contenir d'autres volumes (pouvant créer un kd-tree).

![3d_container](https://github.com/VCityTeam/UD-SV/blob/master/ImplementationKnowHow/images/3dcontainer.png)

Il est décrit avec les éléments suivants : 
- id 
- titre
- description
- extent spatial : interval, trs (par défaut, [gregorian](http://defs.opengis.net/vocprez/object?uri=http://www.opengis.net/def/uom/ISO-8601/0/Gregorian))
- extent temporel
- children
- content : Chaque lien dans le tableau "content" renvoie à une distribution spécifique de ce jeu de données. La propriété "rel" de chaque référence indique sa relation avec le jeu de données, comme "original" (la distribution représentant la version la plus originale du jeu de données, par exemple un modèle CityGML), ou "alternate" (d'autres distributions du jeu de données dans des encodages différents ou pour des plateformes différentes). Le lien vers une référence de contenu dépend du type de contenu et est à définir pour certains types :
    - 3DTiles: tileset.json
    - I3S: NodeIndexDocument
    - CityGML: Collection de document et/ou des CityModels
    - CDB: Root folder
    - 2D features: lien vers une collection de document 


requête possible :
- getCollections : Collections fournit les informations et l'accès à la collection de 3D containers. La ressource collection accepte la bounding box 2D ou 3D (bbox) et le paramètre format. La réponse HTTP /collections GET renvoie JSON contenant deux propriétés, links (lien : URI, type, relation) et 3D-Container.

- getCollections/{3D-Containe-id} : The HTTP /collections/{3DContainerID} GET  retourne un fichier JSON representant un 3D-Container.

```{
    "links": [
        {
            "href": "https://3d.hypotheticalhorse.com/collections/",
            "rel": "self",
            "type": "application/json",
            "title": "this document"
        }
    ],
    "collections": [
        {
            "id": "Buildings",
            "title": "Buildings",
            "description": "3D Buildings",
            "collectionType": "3d-container",
            "extent": {
                "spatial": {
                    "bbox": [
                        [-180, -90, 0, 180, 90, 1000]
                    ],
                    "crs": "http://www.opengis.net/def/crs/OGC/0/CRS84h"
                }
            },
            "links": [
                {
                    "title": "3D Buildings",
                    "href": "https://3d.hypotheticalhorse.com/collections/Buildings/",
                    "rel": "self",
                    "type": "application/json"
                }
            ],
            "content": [],
            "children": [
                {
                    "id": "CesiumOSMBuildings",
                    ...
                },
                {
                    "id": "NewYorkBuildings",
                    "title": "New York - Manhattan - 3D Buildings",
                    "description": "3D Buildings in Manhattan, New York.",
                    "collectionType": "3d-container",
                    "extent": {
                        "spatial": {
                            "bbox": [
                                [
                                    -74.01900887327089,
                                    40.700475291581974,
                                    0,
                                    -73.9068954348699,
                                    40.880256294183646,
                                    547.6909683533274
                                ]
                            ],
                            "crs": "http://www.opengis.net/def/crs/OGC/0/CRS84h"
                        }
                    },
                    "links": [
                        {
                            "title": "New York - Manhattan - 3D Buildings",
                            "href": "https://3d.hypotheticalhorse.com/collections/Buildings/NewYorkBuildings/",
                            "rel": "self",
                            "type": "application/json"
                        }
                    ],
                    "content": [
                        {
                            "title": "3D Tiles",
                            "href": "https://3d.hypotheticalhorse.com/collections/NewYorkBuildings/3dtiles/",
                            "rel": "original",
                            "type": "application/json+3dtiles"
                        }
                    ],
                    "children": []
                },
                {
                    "id": "WesternSydneyBuildings",
                    ...
                }
            ]
        },
        {
            "id": "WaratahStation",
            ...
        }
    ]
}
```

![activity_diagram](https://github.com/VCityTeam/UD-SV/blob/master/ImplementationKnowHow/images/activity_diagram.png)
