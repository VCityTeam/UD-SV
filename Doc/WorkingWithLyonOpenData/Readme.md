## Working with [Lyon Métropole's](https://data.beta.grandlyon.com/en/accueil) CityGML data

## Single vintage difficulties

### Compromised (?) data
The following glitches might block your algorithms at parsing time
(which is fine) but might also confuse any geometrical post-treatment
(which might be harder to detect) :
 * A few `<gml:MultiSurface srsDimension="3">` entries, used to decribe the geometry
   of the respective parts of a building, are empty. This is the case for 
    - building `<bldg:Building gml:id="LYON_8_00166">` (starting on line 1202763 and ending at line 1202789) and
      and building `<bldg:Building gml:id="LYON_8_00177">` (that prior to the above previous block deletion, is
      starting on line 1202791 and ending at line 1202817) within the file `LYON_8EME_2009/LYON_8EME_BATI_2009.gml` of
      [LYON_1ER_2009.zip](https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_1ER_2009.zip)
    - 2012 intall: autre type
 * Linear ring not closed on import of 3DCityDB

### Unfound metadata
Some information (provided in the form a genenric attribute) is not always
   document: grep <gen:*Attribute> and n'importe quel fichier 2015
 - Geometrical imprecision
   - Monster leaning tower
 - 2015: limite Vcity de split-building entre 2012 CityGML1 et 2015 CityGML2

### Multiple enveloppe: what is the semantic behind building regroupment ?
It is hard to understand what is the logic that governs the regroupement of the geometries
of independent physical buildings (that buildings geometrically distinct and separated by
a spatial gap) within a single CityGML "logical" building. 
For example the following CityGML building (with a single gml identifier) is constituted
by many different sub-buildings (refer to [this CityGML file](MultipleEnveloppeExample_1-LYON_1ER_BATI_2015.gml)
extracted from [LYON_1ER_2015.zip](https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_1ER_2015.zip)):

<div id="banner">
  <div class="inline-block">
     <img src="MultipleEnveloppeExample_1/MultipleEnveloppeExample_1-3D.png" alt="drawing" width="420"/>
  </div>
  <div class="inline-block">
     <img src="MultipleEnveloppeExample_1/MultipleEnveloppeExample_1-2D.png" alt="drawing" width="420"/>
  </div>
</div>

Although in the above case, the regroupement of sub-buildings (that all belong to the so
called ["subsistances"](https://en.wikipedia.org/wiki/Les_Subsistances) probably follows to administrative logic,
what about the following case where a single CityGML logical buildings gathers close to 50 independent buildings
![MultipleEnveloppeExample_1 Huge](MultipleEnveloppeExample_1/MultipleEnveloppeExample_1_Huge-3D.png).

**Chosing a single regroupement logic** (while providing the associated semantics) and **keeping
a coherent logic across the city** would ease its usage.



## Inter vintage hindrances
A difficulty, in understanding the dynamic evolution of the geometry
of city, can arise when the identifier (labeling) of a singular city
object changes across vintages.
For example consider the changes in the labeling of the same physical
buildings (more generaly any city object) between year 2012 and 2015:

VintagesIDRenumbering 2012
![Vintages ID Renumbering 2012](VintagesIDRenumbering/VintagesIDRenumbering-2012-3D.png)
VintagesIDRenumbering 2015
![Vintages ID Renumbering 2015](VintagesIDRenumbering/VintagesIDRenumbering-2015-3D.png)

Understanding the changes requires, or is greatly complicated by a lack
of, identifiers that remain valid accross vintages.

Because buildings are regrouped we need to split

Weird split

Tiny changes in the geometry    
    
 - PB: changes in the building (city object) identifiers (labeling) for
     a singular city object (across vintages)
 - PB: changes in the data semantic structuration (il faudrait une cohérence
    de structuraiton)
     2015 decoupe selon le cadastre
     2019-2012: criteres indetermines (mais differents)
   - Monster: multiple envelopes (leaning tower)
 - PB: les formats sont differents (chaque année il faudrait les reconvertir
   les années précédentes)
 - PB: changes in the logic used to separate BATI from BATI_REMARQUABLE
   across vintages: the remarquble buildings are not the same in 2019, 2012
   and 2015. Solution: if a separation is needed, keep the same criteria
   (and provide it). Otherwise place this information inside the CiotyGML file
   (use Generic Attribute)
 - leaning tower: multiple envelope sans plan B car imprecision geometrique

## Demandes
 - Dispose t'on the acquisition process in order to evaluate the induced
   acquisition error ?


