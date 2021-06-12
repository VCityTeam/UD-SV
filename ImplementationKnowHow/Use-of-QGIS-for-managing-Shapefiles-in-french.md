## Changer le Système de Référentiel Spatial d'un fichier Shapefile

1. Ouvrir le Shapefile avec QGIS.
2. Dans l'onglet "Couches", faire un clic droit sur la couche correspondant au fichier dont on souhaite changer le SRS.
3. Sélectionner "Enregistrer sous".
4. Choisir le chemin et le nom du fichier dans le champ "Enregistrer sous", puis choisir le SCR désiré dans le champ correspondant. Sur les données de Lyon, nous travaillons actuellement avec le référentiel Lambert 93 CC 46 (= ESPG:3946).
5. Confirmer le choix en appuyant sur OK, QGIS se charge de faire la conversion automatiquement dans le nouveau fichier. Il est à noter que le fichier nouvellement créé sera automatiquement ouvert dans QGIS. Pour éviter ceci, il faut désactiver l'option "Ajouter les fichiers sauvegardes à la carte" dans la fenêtre précédente.

## Filtrer les éléments d'un fichier Shapefile suivant des valeurs d'attributs sémantiques

1. Ouvrir le Shapefile avec QGIS.
2. Dans l'onglet "Couches", faire un clic droit sur le fichier qui nous intéresse.
3. Sélectionner "Filtrer".
4. Nous avons dans cette fenêtre la liste des noms champs sémantiques présents sur ce fichier, dans la partie "Champs".
5. Sélectionner un champ et appuyer sur le bouton "Tout" dans l'onglet "Valeurs" afin d'obtenir toutes les valeurs présentes parmi les différents objets du Shapefile pour ce champ choisi. Cela permet de visualiser les intitulés et ainsi pouvoir mettre en place le filtre désiré.
6. Dans le champs en bas "Expression de filtrage spécifique au fournisseur de données", il faut ensuite saisir le filtre à l'aide des opérateurs présentés juste au dessus.
Par exemple, on peut écrire : "Champ1" = 'Valeur1' OR "Champ1" = 'Valeur2' pour éliminer tous les objets du Shapefile qui n'ont pas Valeur1 et Valeur2 dans l'attribut Champ1.
Pour faciliter l'utilisation de la sémantique (savoir quand on met des "" ou des ''), on peut directement cliquer sur les champs et les valeurs dans les deux onglets présentés précédemment.
7. Valider le filtre en appuyant sur "Ok".
8. Pour retirer un filtre, il faut revenir dans cette fenêtre et retirer l'expression correspondante, ou appuyer sur "Effacer" pour retirer tous les filtres d'un seul coup.
9. Il est possible d'enregistrer une couche filtrée de la manière présentée précédemment, sans pour autant impacter le fichier Shapefile en entrée. Par exemple, on fait le filtre et on en registre la couche (puis on peut "Effacer" pour revenir à la couche initiale si on veut tester d'autres filtres). On aura créé un fichier shapefile contenant uniquement les objets filtrés, mais le shapefile original restera inchangé.

## Calculer l'intersection entre une couche modèle et une autre qui servira de masque.

1. Ouvrir le Shapefile avec QGIS.
2. Ouvrir la "Boîte à outils" en allant dans "Traitement".
3. Chercher "Intersection" et sélectionner la méthode présente dans "Géotraitements QGIS"
4. Dans "Couche en entrée", sélectionner le nom de la couche que nous désirons filtrer. Ce sont les éléments de cette couche qui seront conservés en sortie.
5. Dans "Couche d'intersection", sélectionner le nom de la couche qui servira de masque. Tous les objets de la couche en entrée qui ne sont pas dans cette couche seront tronqués (ou supprimés) afin de ne conserver que les parties présentes dans cette couche.
6. Enregistrer le résultat de la manière présentée précédemment.

Il est à noter que dans le fichier de sortie, les attributs des objets de la seconde couche sont ajoutés à deux des objets de la couche en entrée. Par exemple, en entrée nous avons une ligne avec un attribut Champ1. En intersection nous avons deux polygones traversés par cette ligne, chacun contenant un attribut : respectivement Champ2 et Champ3. En sortie, nous aurons deux lignes correspondant aux emprises des deux polygones, et chaque ligne contiendra l'attribut Champ1 et en plus l'attribut Champ2 ou Champ3 en fonction du polygone intersectant.

