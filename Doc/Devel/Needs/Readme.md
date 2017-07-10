## List of needs
 * [Need 001](Need001.md): means for computational model API
 * [Need 002](Need002.md): means for modular information models
 * [Need 003](Need003.md): means for a guided tour through space and time
 * [Need 004](Need004.md): integration of medias (images, text, audio, video, etc.) within a 4D (spatio-temp) representation of the city
 * [Need 005](Need005.md): ergonomic user exploration of time : temporal slider
 * [Need 006](Need006.md): ergonomic user exploration of space (advanced camera control, shortcut to point of interest...)
 * [Need 007](Need007.md): guided tour, between spatiotemporal points of interest, which the user can enter/leave/return to at will
 * [Need 008](Need008.md): ability to display the historical uncertainty of the 3d reconstruction
 * [Need 009](Need009.md): ability to use texture in the 3d scene
 * [Need 010](Need010.md): ability to display multiple temporal versions of a building
 * [Need 011](Need011.md): user interface : document browser, temporal slider, minimap, filters, preferences...
 * [Need 012](Need012.md): ability to browse through a document base
 * [Need 013](Need013.md): provide a user friendly interface to manage extended documents
 * [Need 014](Need014.md): manage documents and their links with other city objects and documents
 * [Need 015](Need015.md): user interaction with documents
 * [Need 016](Need016.md): ergonomic exploration of time
 * [Need 017](Need017.md): develop a server to stream PostGIS 3D objects having a temporal dimension to the web
 * [Need 018](Need018.md): provide means for storing and accessing thematic information extending the geometric information of a city 
 * [Need 019](Need019.md): navigate from selected geometries within the interface to the attached semantic information
 * [Need 020](Need020.md): CRUD (manage) extended documents
 * [Need 021](Need021.md): ability to 3D display the city for a given date
 * [Need 022](Need022.md): game controller support
 * [Need 023](Need023.md): VR support
 * [Need 024](Need024.md): Provide means for storing and accessing quality information extending the geometric information of a city
 
## Definitions
### Requirement
**Definition**: a **[requirement](http://pmblog.accompa.com/2009/07/13/features-vs-requirements-requirements-management-basics/)** is a capability that a product must possess or something a product must do in order to ultimately satisfy a customer need.

A requirement **targets a technical audience** as its readers, like engineers, developers, project manager and testers. Requirements might be described with a bias of a particular implementation and must outline and detail exactly **what needs to be delivered** (as a componennt of the product). For example:
 * Requirement 1: "The system (i.e. delivered system or product) shall be able to register a customer item through the specification of the following attributes: an textual ID (20 characters long), comments (2000 characters long) and its retail price (currency)."
 * Requirement 2: "The system shall be able to visualize up to 1024 building (for the 3D mode)." 

### Need 
**Definition**: a **need** or [feature](http://pmblog.accompa.com/2009/07/13/features-vs-requirements-requirements-management-basics/) is a set of related requirements that allows the user to satisfy a "business" objective or need.

Needs are thus high level requirements that **target general audience like management or project leader** and abstracts the technical details. For example
 * Need 1: "We need to offer web based access to city visualisation."
 * Need 2: "The portal of the system should list all the available city datas."
 
 ## When, why and how to write a need
A need arises when formalizing new product ideas informally expressed during a brainstorm, overheard at a conference/meeting, or mentioned during discussions with product users. The main reason for formalizing a need ("ideas" can come from many sources, but needs cannot be written by the general audience) is to provide a support for discussing and assessing (political decision) the product evolutions opportunities. 

The key purpose of a need is thus to untangle the initial idea, its implicit/explicit assumptions about the solution a new answering feature would solve. A need must thus clearly express what problem it addresses (even though they are possibly many features or approaches that could solve it) as well as specify means to assess when it is solved. In other terms the questions to answer when writing a need are:
 * What problem are we trying to solve? (Why should we be doing this? What is the pain?)
 * Who are we trying to solve this problem for? (Who's pain would be relieved?)
 * How will we know if we succeed? (what is hoped outcome?) 

The description of a need should have the following items:
 * **Identifier**: a string of the form `N<integer_need_number>` e.g. `N042`.
 * **User story**: a suggestive one liner description in the form "As a [role], I want to [do something] so that [reason/benefit]".
 * **Beneficiary role**: the role (researcher, developper, operations) that would directly benefit from the realisation of the need. 
 * **Impact**: choose among critical (project maker), major (would have heavy/significant benefits) or minor (nice to have).
 * **Maturity**: choose among immature, ongoing, mature, complete
 * **Cost evaluation**: some ball park estimation in man weeks or man months for its full realization (requirements, designs, implementation, tests, packaging, integration, documentation).
 * **Tags or keywords**: be them known (client, server, database) or not already mentioned (user experience...). 
