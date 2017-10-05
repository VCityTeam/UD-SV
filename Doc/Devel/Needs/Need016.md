# Need 016 : Ergonomic exploration of time
 

### User story
As [historian](https://github.com/MEPP-team/RICT/blob/master/Doc/Devel/Needs/Roles.md#city-knowledgeable-person), I want (within the interface) to select an historical moment (among the set of predefined moments) so that the displayed city corresponds to the state of the city as it was at this moment.

### Beneficiary role:
[Historian](https://github.com/MEPP-team/RICT/blob/master/Doc/Devel/Needs/Roles.md#city-knowledgeable-person)

### Impact: 

### Maturity:
This need has been broke down in two issues with different priorities: [Issue with high priority](https://github.com/MEPP-team/RICT/issues/7#issuecomment-334478821) and [Issue with lower priority]().
Some parts of this needs are fulfilled (indicated with **Done** in the following description). 

### Cost evaluation:
Ball park estimate limited to the interface: 3 person-week. 

### Tags or keywords

### Description

**High Priority:**
- When a media is selected within the media browser, an associated historical moment gets defined. The user can now ask to be warped to the location and at the corresponding moment (the time slider gets refreshed) within the geometrical view. : **Done**
- The state of a (displayed) city at a given historical moment includes the city geometries of the city objects : **Done**
- The state of a (displayed) city at a given historical moment includes the attached information (e.g. the medias)
- The user interaction (with the interface) in order to select an historical moment must be done with a slider (or with any interface element specifying an historical moment e.g. the media browser) : **Done**
- Within the interface the temporal mode is toggable (can be tuned On/Off)

**Low Priority:**
- Localized time slider: select a part ("region", portion, set of selected objects) of the city and freeze its "time". When the time slider is moved it only applies to what is outisde of the region (the interior remaining time frozen).
- Invert localized time slider: select a part ("region", portion, set of selected objects) of the city. The remaining of the city will remain time frozen when the slider is modified.

### Notes:
This need is located within the GUI component and hooks up the triggers (to possibly external functionality)

