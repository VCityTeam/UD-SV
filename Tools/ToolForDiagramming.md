Diagrams are a powerfull notation when working on the design, the architecture or the documentation.
For this purpose the de-facto standard is UML and its [UML diagrams](https://www.uml-diagrams.org/) (e.g. [Class](https://www.uml-diagrams.org/class-diagrams-overview.html), [Component](https://www.uml-diagrams.org/component-diagrams.html), [Activity](https://www.uml-diagrams.org/activity-diagrams.html)..).
Yet, on a first approach, looser diagramming notations like the one of [the "C4-Model"](https://c4model.com/) (for which you might consider watching [this 35' presentation](https://www.youtube.com/watch?v=x2-rSnhpw0g)) might prove useful.

Here are some recommandable portable (accross OSes) tools, free, open format and with text 
based formats (which is mandatory for git repositories), recommended for the project:

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

### [Enterprise Architect](https://www.sparxsystems.com/resources/tutorials/uml/part1.html)
   - An industry level platform for UML modeling
   - This powerful tool is great for creating complex, standardized diagrams but may be a bit heavy for simple diagrams
   - A VM with EA installed can be found on [nextcloud](https://partage.liris.cnrs.fr/index.php/f/723424583)
   
