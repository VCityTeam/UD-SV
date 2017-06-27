# Need 005: Adding a temporal dimension to city models

**Open questions: FIXME VJA ESC, GGE**:
 * do we need date (instant time), period (time interval) ?
 * what is the time step for the slide ? (discrete or continuous time)
 * When discrete is the slides allowed to stop in between dates (historical moments) ?
 * When decided fix the above definitions (change the name if required)

### User story
As an [historian](https://github.com/MEPP-team/RICT/blob/master/Doc/Devel/Needs/Roles.md#city-knowledgeable-person), I want to add a temporal dimension to city models. I want to be able to store different versions of city models corresponding to different periods of time. I also want to be able to visualise the evolution of the city along the time using a 4D (spatio-temporal) representation of the city.

Sub Needs:

Need 010: [Modelisation of temporal dimension of city models](https://github.com/MEPP-team/RICT/blob/master/Doc/Devel/Needs/Need010.md)

Need 016: [Ergonomic exploration of time](https://github.com/MEPP-team/RICT/blob/master/Doc/Devel/Needs/Need016.md)

Need 017: [Sending temporal urban data to web client]()

### Beneficiary role:
[Historian](https://github.com/MEPP-team/RICT/blob/master/Doc/Devel/Needs/Roles.md#city-knowledgeable-person), [General audience](https://github.com/MEPP-team/RICT/blob/master/Doc/Devel/Needs/Roles.md#general-audience)

### Impact: 
Major.

### Maturity:
Ongoing

### Cost evaluation:
Ball park estimate: 4 person-month. 

### Tags or keywords

### Description
- When a media is selected within the media browser, an associated historical moment gets defined. The user can now ask to be warped to the location and at the corresponding moment (the time slider gets refreshed) within the geometrical view.
- The state of a (displayed) city at a given historical moment inludes both the city geometries of the city objects as well as the attached information (e.g. the medias).
- The user interaction (with the interface) in order to select an historical moment must be done with a slider (or with any interface element specifying an historical moment e.g. the media browser)
- Within the interface the temporal mode is toggable (can be tuned On/Off)
- Localized time slider: select a part ("region", portion, set of selected objects) of the city  and freeze its "time". When the time slider is moved it only applies to what is outisde of the region (the interior remaining time frozen).
- Invert localized time slider: select a part ("region", portion, set of selected objects) of the city. The remaining of the city will remain time frozen when the slider is modified.

### Notes:

