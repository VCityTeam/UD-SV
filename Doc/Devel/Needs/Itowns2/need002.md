# Need 002: Contribution à 3dtiles - Lecture des fichiers de nuage de points - les pnts

### User story

Nous avons dans [3dtiles](https://github.com/AnalyticalGraphicsInc/3d-tiles) le format de streaming de donnée, un type de fichier
qui s'appelle les pnts ce sont un format de nuage de points.

Actuellement, Itowns lit des fichier B3dm, un format de maillage, et le but de ce need et de lire des pnts.

### Beneficiary role: iTowns et la norme 3dtiles

### Impact: Major

### Maturity: done

### Cost evaluation: 2 man week (?)

### Description 

Pour faire ce need nous avons eu besoin d'analyser la structure des [pnts](https://github.com/AnalyticalGraphicsInc/3d-tiles/blob/master/TileFormats/PointCloud/README.md).
Après cela nous avons fait un programme qui parcours ces fichiers. Nous avons ensuite placé les différentes données dans les structure 
de iTowns.
Voici un exemple de résultat: 

  ![](./Schemes/Capture du 2017-06-19 16-18-06.png)

### Notes:

Un exemple est disponible sur [le site d'iTowns](http://www.itowns-project.org/itowns/examples/pointcloud.html)
