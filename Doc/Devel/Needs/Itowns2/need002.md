# Need 002: Contribution à 3dtiles - Lecture des fichiers de nuage de points - les pnts

### User story

Nous avons dans [3dtiles](https://github.com/AnalyticalGraphicsInc/3d-tiles) le format de streaming de donné, un type de fichier 
qui s'appelle les pnts (un format de nuage de points).

Actuellement, Itowns lit des fichier B3dm, un format de maillage, le but de ce need et de lire des pnts.

### Beneficiary role: iTowns et la norme 3dtiles

### Impact: Major

### Maturity: done

### Cost evaluation: 2 man week (?)

### Description 

Pour faire ce need nous avons eu besoin d'analyser la structure des [pnts](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/PointCloud/README.md). 
Après cela nous avons fait un programme qui parcourt ces fichiers. Nous avons ensuite placé les différentes données dans les structures de iTowns.
Voici un exemple de résultat: 

 ![](./Schemes/pointCloud.png)

### Notes:

Un exemple est disponible sur [le site d'iTowns](http://www.itowns-project.org/itowns/examples/pointcloud.html).

Et voici une [documentation](https://github.com/MEPP-team/RICT/blob/master/Doc/Process/Itowns2Feature.md) qui explique en détaile ce qui a été fait.
