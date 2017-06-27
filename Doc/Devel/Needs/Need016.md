# Need 016 : Ergonomic exploration of time
 
 todo :
   subneed : temporal slider

### User story
As [historian](https://github.com/MEPP-team/RICT/blob/master/Doc/Devel/Needs/Roles.md#city-knowledgeable-person), I want (within the interface) to select an historical moment (among the set of predefined moments) so that the displayed city corresponds to the state of the city as it was at this moment.

### Beneficiary role:
[Historian](https://github.com/MEPP-team/RICT/blob/master/Doc/Devel/Needs/Roles.md#city-knowledgeable-person)

### Impact: 

### Maturity:

### Cost evaluation:
Ball park estimate limited to the interface: 1 person-month. 

### Tags or keywords

### Description
- When a media is selected within the media browser, an associated historical moment gets defined. The user can now ask to be warped to the location and at the corresponding moment (the time slider gets refreshed) within the geometrical view.
- The state of a (displayed) city at a given historical moment inludes both the city geometries of the city objects as well as the attached information (e.g. the medias).
- The user interaction (with the interface) in order to select an historical moment must be done with a slider (or with any interface element specifying an historical moment e.g. the media browser)
- Within the interface the temporal mode is toggable (can be tuned On/Off)
- Localized time slider: select a part ("region", portion, set of selected objects) of the city  and freeze its "time". When the time slider is moved it only applies to what is outisde of the region (the interior remaining time frozen).
- Invert localized time slider: select a part ("region", portion, set of selected objects) of the city. The remaining of the city will remain time frozen when the slider is modified.

### Notes:


