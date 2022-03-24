# Getting started with ShapeChange 
[ShapeChange](https://shapechange.net/) is a Java tool for UML transformations using XSLT.

It's UML to OWL transformations are based on the [ISO 19150-2](https://www.iso.org/standard/57466.html) standard: Rules for developing ontologies in the Web Ontology Language (OWL). The Open Geospatial Consortium has analyzed these ShapeChange transformations and the ISO 19150-2 standard in their [Testbed-12 ShapeChange Engineering Report](http://docs.opengeospatial.org/per/16-020.html) and has found limitations in the transformation specifications.

### Relevant Links
- [ShapeChange](https://shapechange.net/)
- [ISO 19150-2:2015](https://www.iso.org/standard/57466.html)
- [OGC Testbed-12 ShapeChange Engineering Report](http://docs.opengeospatial.org/per/16-020.html)
  - [Section 8: UML to RDF/OWL/SKOS](http://docs.opengeospatial.org/per/16-020.html#section_rdf)

***

### Installation requirements

To begin using ShapeChange for UML transformations **Java 11 or later** is required.

_For converting Enterprise Architect files_ the following dependencies are required:
1. Windows operating system
2. Enterprise Architect must be installed
3. 32 bit Java

See the ShapeChange [Get Started page](https://shapechange.net/get-started/) for more information.

## Basic ShapeChange Implementation
This section will briefly describe how a ShapeChange conversion works and the basics of configuring ShapeChange input and output.

As shown below ShapeChange takes two files as input:
1. **A ShapeChange configuration file**
   - Used to specify transformation rules and parameters 
   - [Test example 1](http://shapechange.net/resources/test/testXMI.xml)
   - [Test example 2](http://shapechange.net/resources/test/testEA.xml)
2. A UML Model\* in one of the following formats
   - **XMI10**: a UML model in XMI 1.0 format
   - **EA7**: an Enterprise Architect project file, supported are versions 7.5 and later
   - **GCSR**: a GCSR model contained in a Microsoft Access Database (MDB)
   - **SCXML**: a model in a ShapeChange specific XML format. These can be created using [the Model Export target](https://shapechange.net/targets/model-export/) from ShapeChange.

_\* Note that a UML model can be composed of multiple schemas. For example like how the CityGML application schema is reliant on the GML schema._

During transformation there are 2 main stages:
1. **Optional transformations**
   - These transformations can be used to simplify or divide the model
   - They can be made on the input model or the output of another optional transformation to form chains or trees of transformations
   - There are 21 different "transformers" which can effectuate these transformations
   - See [here](https://shapechange.net/transformations/) for more information on optional transformations
2. **Target output transformations**
   - After the optional transformations are complete, their outputs are sent to the target transformation which converts the model into one or multiple output targets.
   - For example, an output target may be an OWL ontology or XML Schema.
   - If no optional transformations are declared, the target transformation will transform the input model directly
   - See [here](https://shapechange.net/targets/) for more information on target transformations

![ShapeChange_overview](http://docs.opengeospatial.org/per/includes/16-020/ShapeChange_overview.png)

### Configuration File

The configuration file is written in XML. Examples of configuration files can be found in the [UD-Graph](https://github.com/VCityTeam/UD-Graph/tree/master/Transformations/ShapeChange) repository.

When configuring a ShapeChange transformation 5 elements in the configuration file can be specified:
1. [Input](https://shapechange.net/get-started/config/input/) - What (and where) are we transforming
2. [Dialog](https://shapechange.net/get-started/config/dialog/) - an optional "interface dialog"
3. [Log](https://shapechange.net/get-started/config/log/) - optional and useful configurations for logging warnings, errors and transformation information  
4. [Transformers](https://shapechange.net/get-started/config/transformers/) - optional configurations for intermediate transformations. Several transformation may be specified 
5. [Targets](https://shapechange.net/get-started/config/targets/) - configuring what (and where) we are outputting after conversion. Conversion rules are specified here.

The following subsections will only conver input and target configurations as they are the only ones which are required to launch a ShapeChange conversion.

#### Input Configuration

To create a basic input configuration the `inputModelType` and `inputFile` parameters are used to specify what type of UML file is being converted (XMI, EA7, etc.) and where it is located.
```lang-xml
<input>
  <parameter name="inputModelType" value="SCXML"/>
  <parameter name="inputFile" value="../Input-Models/ShapeChange/CityGML_2.0_Conceptual_Model.xml"/>
</input>
```

A detailed list of all input parameters can be found [here](https://shapechange.net/get-started/config/input/#Parameters)

It may also be useful to specify several _StereotypeAliases_ when the UML model uses naming conventions not recognized by ShapeChange. The list of recognized or _wellknown_ stereotypes can be found [here](https://shapechange.net/app-schemas/uml-profile/#Stereotypes). A list of commonly used stereotypes can be imported [here](https://shapechange.net/resources/config/StandardAliases.xml). These unrecognized naming conventions can be mapped to the wellknown stereotypes as follows:
```lang-xml
<input>
  <xi:include href="http://shapechange.net/resources/config/StandardAliases.xml"/>
  <stereotypeAliases>
    <StereotypeAlias wellknown="property" alias="Property"/>
    <StereotypeAlias wellknown="version" alias="Version"/>
    <StereotypeAlias wellknown="FeatureType" alias="TopLevelFeatureType"/>
  </stereotypeAliases>
</input>
```
Further input customization details can be found [here](https://shapechange.net/get-started/config/input/)

#### Output/Target Configuration

To configure output for ShapeChange, one or multiple targets must be specified. Many output targets are available such as:
- XML Schema
- Feature Catalogues
- RDF/OWL
- ArcGIS Workspace
- JSON Schema
- SQL DDL and Replication Schema
- Model Export
- UML Model
- First Order Logic to Schematron
- Profile Transfer to EA Repository
- Application Schema Metadata

To configure a target, the target `class` attribute declares the target, and the `outputDirectory` parameter is used to specify the output location.
```
<targets>
  <TargetExample class="de.interactive_instruments.ShapeChange.Target.Ontology.OWLISO19150" mode="enabled">
    <targetParameter name="outputDirectory" value="../Input-Models/OWL/CityGML_2.0_Conceptual_Model"/>
  </TargetExample>
</targets>
```
Each target comes with a default set of transformation encoding rules that can be customized to configure the conversion using the `defaultEncodingRule` parameter which references an `EncodingRule`. For example, when converting UML models to OWL ontologies, adding the [`rule-owl-pkg-singleOntologyPerSchema`](https://shapechange.net/targets/ontology/uml-rdfowl-based-isois-19150-2/#rule-owl-pkg-singleOntologyPerSchema) will use a single ontology namespace will be used for the input and its packages. Omitting this rule, will not convert these types. An example UML to OWL rule transformation:
```lang-xml
<targets>
  <TargetExample class="de.interactive_instruments.ShapeChange.Target.Ontology.OWLISO19150" mode="enabled">
    <targetParameter name="defaultEncodingRule" value="CityGML_RDF_Encoding_Rules"/>
    <rules>
      <EncodingRule name="CityGML_RDF_Encoding_Rules">
        <rule name="rule-owl-pkg-singleOntologyPerSchema"/>
      </EncodingRule>
    </rules>
  </TargetExample>
</targets>
```
Any non-standard namespaces must be listed here as well. See the [StandardNamespaces file](https://shapechange.net/resources/config/StandardNamespaces.xml) for examples.

Further output target customization details can be found on the ShapeChange website:
- [getting started: targets](https://shapechange.net/get-started/config/targets/)
- [targets](https://shapechange.net/targets/)
- [input specific targets](https://shapechange.net/targets/#Supported_Target_Types)
