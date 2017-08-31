# Need 001: Contribution à 3dtiles - Lecture des regions - les boundings volumes

### User story
  Actuellement iTowns possède un système de tuile. Chaque tuile posséde un attribue qui s'appelle le bounding volume.
  Ce bounding volume est une boite englobante qui regroupe l'intégralité des objets d'une tuile
  
  ![](./Schemes/tile.png)
  
  Comme le montre cet exemple, il y a une tuile principale qui regroupe 4 tuiles qui elle regroupe des batiments.
  Là ou les boundings volume sont importants c'est que pour savoir si la camera de la scène voit ou pas un objet.
  On regarde si le frustum de la camera intersecte avec le bounding volume si oui on rentre dans les enfants de la tuile 
  et ainsi de suite.

  Sur notre shcéma nous avons donc les box, les régions et les sphères le but de ce need est donc d'implementer les régions.
  Les régions sont utile pour la vision globe de iTowns, car ce n'est pas des boites:
  
  ![](./Schemes/tile2.png)
  
  
### Beneficiary role: iTowns et la norme 3dtiles

### Impact: Major

### Maturity: done

### Cost evaluation: 2 man week (?)

### Description

Pour faire ce need, nous avons adapté les coordonnées des regions pour qu'elle soit englobé par une box
  
  ![](./Schemes/regionbox.png)

### Notes:
