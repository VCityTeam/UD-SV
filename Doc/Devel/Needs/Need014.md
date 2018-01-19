
# Need 014: Provide a user friendly interface to manage extended documents

### User story

As an historian I want to be able to add, modify, delete the [documents](Definitions.md#document), their [references](Definitions.md#reference-aka-link) to [city objects](Definitions.md#city-object) or other documents.

### Beneficiary role: 
[City Knowledgeable Person](https://github.com/MEPP-team/RICT/blob/master/Doc/Devel/Needs/Roles.md#city-knowledgeable-person)

### Impact: 
minor

### Maturity: 
immature

### Cost evaluation: ?

### Tags or keywords

### Component
 * [Authoring interface](Definitions.md#authoring-interface)

### Description
While working with historians, one major observation that has been made is their use of excel files (or csv files). Therefore in order to extend city model with documents, we need the following features in the application:
1. Interface that allows the user to add one document at a time along with specifying the metadata.
2. Interface that allows the user to bulk load documents along with an excel files (csv files) that specifies key metadata of all documents along with document references to city objects (or even other city documents). Thus this interface has two important parameters
     * Link to excel file containing metadata
     * Link to folder containing documents
 
### Notes:
This need differs from [Need 028](https://github.com/MEPP-team/RICT/blob/master/Doc/Devel/Needs/Need028.md). Need 028 is a process (e.g. script) allowing to import extended documents in the database from e.g. an excel file and a set of files. This need is a user friendly interface above this process.
