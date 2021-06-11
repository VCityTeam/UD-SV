When working the design or the documentation, diagrams and
mostly [UML diagrams](https://www.uml-diagrams.org/) (e.g. [Class](https://www.uml-diagrams.org/class-diagrams-overview.html), [Component](https://www.uml-diagrams.org/component-diagrams.html), [Activity](https://www.uml-diagrams.org/activity-diagrams.html)..) are a must have. 

Here are some recommandable portable (accross OSes) tools with text based formats (mandatory
for git repositories):

### [Plantuml](https://plantuml.com/) 
  - Integrated within Gitlab/github (images generated on the fly)
  - UML oriented: perfect for sequence diagrams
  - Misses diagram manual layout control
 
### [mermaid](https://github.com/mermaid-js/mermaid)
  - [mermaid on readthedocs](https://mermaid-js.github.io/mermaid)
  - Integrated within Gitlab/github (images generated on the fly)
  - Misses diagram manual layout control
  - Quite some limitations concerning some UML views

### [diagrams.net](https://app.diagrams.net/)
  - Previously named draw.io
  - [Online tool](https://app.diagrams.net/)  
  - [Dockerized version](https://github.com/jgraph/docker-drawio) for offline usage
  - Available on [github](https://github.com/jgraph/drawio) with Apache license
  - Cons:
    * by default, the saved diagrams are compressed which is not really adapted
      for git usage. Yet it is possible to uncompress the xmls.
    * automatic builds of png out of the serialized xmls is possible but requires 
      some docker usage (i.e. there is no simple cli expression of "build the
      corresponding png")
 
### [Pyton diagrams](https://pypi.org/project/diagrams/)
   - Mostly for deployment/control diagrams
   
