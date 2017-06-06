## Roadmap

Voici les différentes tâches que j'ai prévu de faire dans les mois qui arrivent.

1. Faire de la documentation pour ce que j'ai déja fait (In progress). Et plus globalement, le faire au fur et à mesure.

2. Finir mon [pull Request](https://github.com/iTowns/itowns2/pull/323): (Semaine du 05/06)
  - Il y a encore des corrections à faire, mais je ne suis pas loin du but.
 
3. Avancer sur la conversion des points de [Zanzibar](https://fr.wikipedia.org/wiki/Zanzibar_(archipel)): (Semaine du 05/06 et quand j'aurai le temps ce n'est pas le plus prioritaire)
 - On m'a donnée comme mission de convertir les données de drône qui ont survolés l'ile ou se trouve la ville de [Zanzibar](https://fr.wikipedia.org/wiki/Zanzibar_(archipel)), ce sont des nuages de points,
 pour pouvoir les lire dans itowns.
 Donc globalement :
   - Essayer de charger le nuage de points avec [Lopocs](https://github.com/Oslandia/lopocs) un loader de points en Python fait par Oslandia.
   - Voir pour tester ces points sur une scène pour voir si le client tien le coup et que ça ne lag pas. 
   - Continuer ensuite la lecture des données que Zanzibar nous envoie.

4. Avancer sur les problèmes qu'il y a avec la lecture des points b3dm (Semaine du 12/06, car Jérémy n'est pas la)
 - Il y a certaines parties de la lecture des données de b3dm qui ne sont pas gerées à cause de three.js et de la norme cesium pour GLTF.
   - Voir ce qui est possible de faire pour palier à ce problème soit en passant par notre code soit en faisant une issue sur le git de three.js pour qu'ils puissent lire la norme de Cesium
   - Régler ce problème et tester.

5. Continuer la lecture des differents fichiers comme pour .pnts mais pour les autres comme Vector Data (*.vctr) mais aussi Instanced 3D Model (*.i3dm).... 
  - Globalement de voir comment ça se transforme dans les classes de three.js
