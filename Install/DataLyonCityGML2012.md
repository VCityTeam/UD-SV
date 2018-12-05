Create a target directory and connect into it. Then
````
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_1ER_2012.zip
unzip LYON_1ER_2012.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_2EME_2012.zip
unzip LYON_2EME_2012.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_3EME_2012.zip
unzip LYON_3EME_2012.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_4EME_2012.zip
unzip LYON_4EME_2012.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_5EME_2012.zip
unzip LYON_5EME_2012.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_6EME_2012.zip
unzip LYON_6EME_2012.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_7EME_2012.zip
unzip LYON_7EME_2012.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_8EME_2012.zip
unzip LYON_8EME_2012.zip
wget https://download.data.grandlyon.com/files/grandlyon/localisation/bati3d/LYON_9EME_2012.zip
unzip LYON_9EME_2012.zip
````

 * Edit file `LYON_8EME_2012/LYON_8EME_BATI_2012.gml` at line `1099147` that goes
   ```
   <app:textureCoordinates ring="#UUID_cae90897-97ba-4e86-9d8a-c46ec2823b37">0.352869 -1.#IND00 0.353114 -1.#IND00 0.353111 -1.#IND00 0.352869 -1.#IND00 </app:textureCoordinates>
   ```
   and replace the three `-1.#IND00` occcurences with a valid double e.g. `-1.00`

 * Edit file at and remove the full `<cityObjectMember>` block describing `<bldg:Building gml:id="LYON_7EME_00215">` (starting on line `2752390` and ending at line `2752416`) 
 
* Proceed with the [importation within your 3DCityDB database](Install3DCityDB.md#import-some-citygml-file-content)
