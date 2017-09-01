# Need 003: Lecture de donnée tiré de UAV 

### User story
UAV signifie : Unmanned Aerial Vehicle soit véhicule aérien sans humain à bord

Le but de ce need est de pouvoir lire le type de données venant de drone par exemple dans iTowns.

Il est possible d'avoir 3 types de données :

- Les nuages de points (LIDAAR) 

- OrthoPhoto

- Images d'élévations

### Beneficiary role: iTowns

### Impact: Major

### Maturity: done

### Cost evaluation: 3 man week (?)

### Description 

- Nuage de points : 

Pour pouvoir lire les fichier LIDAAR les .las nous sommes passé par un convertiseur.
Nous avons installé [potreeConverteur](https://github.com/potree/PotreeConverter) qui permet de convertir les .las 
en .potree qui lui est lu par iTowns. 

- Orthophotos et élévations

Pour ce type de données, le travail n'est pas encore à ce jour terminé, la méthode que nous proposons fonctionne pour une image, mais pas plus pour l'instant. Nous travaillons actuellement sur une méthode plus rapide et qui peut elle prendre plusieurs images. Cependant, si il n'y a qu'une seule image cela fonction j'ai donc répondu à cette problématique pour Zanzibar. 
Pour ce problème, j'ai utilisé [un serveur wms](https://github.com/peppsac/pywms) (un protocole qui sert à l'échange de données) qu'a fait une des personnes qui travaillent sur iTowns (Monsieur Pelloux-Prayer), pour pouvoir mettre en base mes images puis les lires avec iTowns.

### Notes:

Les résultats obtenus sont à la hauteur du travail effectué. Les difficultés majeures de ce travail était clairement de comprendre et de savoir ce qui existe. L'un des points positifs étaient de travailler avec de données de grandes tailles concrète, l'île de Zanzibar. J'ai aussi dû réaliser de la documentation en anglais pour décrire les différentes étapes de lecture de ce genre de données. Maintenant, iTowns est donc capable de lire l'ensemble des données venant de drone.
