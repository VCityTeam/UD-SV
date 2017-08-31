# Need 001: Contribution à 3dtiles - Lecture des regions 

### User story
  Actuellement iTowns possède un système de tuile. Chaque tuile posséde un attribue qui s'appelle le bounding volume.
  Ce bounding volume est une boite englobante qui regroupe l'intégralité des objets d'une tuile
  
  ![](./Schemes/tile.png)
  
  Comme le montre cet exemple, il y a une tuile principale qui regroupe 4 tuiles qui elle regroupe des batiments.
  Là ou les boundings volume sont importants c'est que pour savoir si la camera de la scène voit ou pas un objet.
  On regarde si le frustum de la camera intersecte avec le bounding volume si oui on rentre dans les enfants de la tuile 
  et ainsi de suite.

### Beneficiary role: **integrated** model developer.

### Impact: minor (nice to have).

### Maturity: ongoing

### Cost evaluation: 2 man week (?)

### Tags or keywords

### Description

### Notes:
