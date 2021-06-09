# Organizational logic of git repositories
The [VCityTeam organisation](https://github.com/VCityTeam) together with its partners
 * manages [list of projects](https://github.com/VCityTeam/VCity/wiki/Projects) which 
   requires the handling of information
 * produces [software components](https://github.com/VCityTeam/UD-SV/tree/master/SoftwareComponents)
 * handles all the above information (project artifacts and software) with git

## Driving organizational principles
The good practices applied for the break down of the organisation information into git repositories is as follows
 * [separate concerns](https://en.wikipedia.org/wiki/Separation_of_concerns): 
    - keep project (managerial) information separated from software
    - keep confidential information (private) separated from public information
    - keep partners respective [IP](https://en.wikipedia.org/wiki/Intellectual_property) ownerships separated
 * Specifically for software components, 
    - promote [reusability](https://en.wikipedia.org/wiki/Reusability) 
      (among which [modularity](https://en.wikipedia.org/wiki/Modular_programming))
    - ownership (as [IP](https://en.wikipedia.org/wiki/Intellectual_property) notion) concerns 
      have precedence over modularity concerns. In other terms no matter what the modularity 
      concerns might be, each repository should have a single owner. And yes this might prove
      to have a heavy impact on software engineering costs...

## Breaking down into repositories
Independently from public/private seraparation concerns, the application of the above driving 
principles yields the following good practices applied for the break down of the
information of the organisation into git repositories goes
 * Create a repository for every project (managerial) information e.g. [this UD-SV project](/Readme.md)
   (in application of the [separation of concerns](https://en.wikipedia.org/wiki/Separation_of_concerns) managerial vs software)
 * **For every owner** (precedence of ownership over software engineering)
   - create a repository for every [(software) library](https://en.wikipedia.org/wiki/Library_(computing)) (e.g. [py3dtiles](https://github.com/VCityTeam/py3dtiles) which is a python library) or [(software) package] (e.g. [UD-Viz](https://github.com/VCityTeam/UD-Viz) is a JS package)...
   - create a repository for every [(software) application](https://en.wikipedia.org/wiki/Application_software) e.g. [UD-Viz-demo](https://github.com/VCityTeam/UD-Viz-demo) is an application demo based on UD-Viz
   - create a repository for every docker component e.g. [UD-Viz-demo-docker](https://github.com/VCityTeam/UD-Viz-demo-docker)
   - but a demo can be a **directory** (within a repository) usually holding a [docker-compose ](https://docs.docker.com/compose/) or an [helm chart](https://github.com/helm/helm)(located e.g. in [UD-Reproducibility/Demos](https://github.com/VCityTeam/UD-Reproducibility/tree/master/Demos) 

The above practices are summarized by the following illustration

<img src="Diagrams/UD-SV-Repository_organizational_logic_project_vs_component.png"
     alt="Organizational logic : project vs component" width="800"/>

## Relationships between project/software repositories
Project repositories and software repositories are in a [many-to-many](https://en.wikipedia.org/wiki/Cardinality_(data_modeling)#Application_program_modeling_approaches) (cardinality) relationship i.e.
 - a (software) component repository can be the results of one or many projects
 - a project repository uses one or many component repositories (library, application, demo)

This [many-to-many](https://en.wikipedia.org/wiki/Cardinality_(data_modeling)#Application_program_modeling_approaches) is illustrated by the following diagram

<img src="Diagrams/UD-SV-Repository_organizational_logic_shared_development.png"
     alt="Organizational logic : shared development" width="800"/>

**Note**: in the above diagram software component `B` is co-developped by two projects that 
both share the same (legal) owner (respect precedence of ownership criteria of software 
modularity). Co-development here means single owner multiple project repository sharing (
co-developement). Shared ownership is hellish to handle (specially in the context of french
academia) and must be banned (at all costs).  

## Separation of public from private information
The organisation also applies the [separation of concerns](https://en.wikipedia.org/wiki/Separation_of_concerns) to the public vs private criteria.
This directly translates to the fact that private information (be it project or component) is held in private (git) repositories when public information (project or component) is kept in ...  public (git) repositories. For example
 - the [VCity project repository](https://github.com/VCityTeam/VCity/wiki/Projects) is private when the [UD-SV project repository](https://github.com/VCityTeam/UD-SV) is its public counterpart
 - [GMAOBIM software](https://github.com/VCityTeam/GMAOBIM) is a private software repository when [py3dTilers software repository](https://github.com/VCityTeam/py3dtilers) is a public repository

This can be summarized by the following illustration

<img src="Diagrams/UD-SV-Repository_organizational_logic_private_vs_public.png"
     alt="Organizational logic : shared development" width="800"/>
