# UD-SV developer's central <a name="top"></a>

## Step by step inception guide

### Getting started
 * The [whys and wherefores of the UD-SV project](../Readme.md)
 * [Architecture](/Architecture/Readme.md)

### Tooling: check your knowledge of the pre-requisites
The main languages used in UD-SV are:
 * [JavaScript](https://en.wikipedia.org/wiki/JavaScript), used for frontend, e.g. for [UD-Viz](https://github.com/VCityTeam/UD-Viz), [UD-Viz-Template](https://github.com/VCityTeam/UD-Viz-Template): proposed [tutorial](https://developer.mozilla.org/fr/docs/Web/JavaScript)
 * [Python3](https://en.wikipedia.org/wiki/Python_(programming_language)), e.g for the [py3dTilers](https://github.com/VCityTeam/py3dtilers) back end: proposed [tutorial](https://developer.mozilla.org/en-US/docs/Glossary/Python)
 * [C++](https://en.wikipedia.org/wiki/C%2B%2B) for some backend treatments (e.g. [SplitBuilding](/Tools/Readme.md#ComponentUD-ServSplitBuilding)) requiring geography/geometry manipulations
 * Markdown

In order to contribute code/info
 * [git](/Tools/ToolGit.md) and [git development cycle](/ImplementationKnowHow/GitWorflow/DevelopersGithubCycle.md)
 * adopt some **Editor/IDE** e.g. [VisualStudioCode](https://code.visualstudio.com/), [VisualStudio](https://visualstudio.microsoft.com/vs/community/) (for C/C++, Windows only), [PyCharm](https://www.jetbrains.com/pycharm/) (for Python), [sublime](https://www.sublimetext.com/)...
 * learn how to use a **[debugger](https://en.wikipedia.org/wiki/Debugger)** (depends on the language and the considered IDE)
 * [Continuous Integration](https://en.wikipedia.org/wiki/Continuous_integration) e.g. [Travis](https://github.com/VCityTeam/py3dtilers/blob/master/.travis.yml)
 * Containers, mainly [docker](/Tools/ToolDocker)
 * **coding styles** e.g. [eslintrc.js](https://github.com/VCityTeam/UD-Viz-Template/blob/master/.eslintrc.js), for [C++](https://github.com/VCityTeam/VCity/blob/master/Developers/Coding-Style.md) or [flake8](https://github.com/VCityTeam/py3dtilers/blob/master/.flake8)
 * When working on [Markdown](https://en.wikipedia.org/wiki/Markdown) based documentation [validate the links and references](DevelopersValidatingMardownLinks.md)

Adopt the best practices
 * **Submit often**: it is much better to often submit small yet effective and mature PR than jumbo/bulk code once in a while...
 * [Submit trough pull request (PR)](https://github.com/VCityTeam/UD-SV/blob/master/ImplementationKnowHow/GitWorflow/DevelopersGithubCycle.md#submitting-a-pull-request-pr): don't forget to provide a template.
 * Place and maintain some gentle pressure on the guilty parties when [asking for your pull request (PR) acceptation](https://github.com/VCityTeam/UD-SV/blob/master/ImplementationKnowHow/GitWorflow/DevelopersGithubCycle.md#pull-request-pr-acceptance-policy)
 * Note: when defining a link in markdown only use relative path for references (don't write `[link-name](/b)` but e.g. `[link-name](../../b)`) 

> [!TIP]
> If contributing to [UD-Viz](https://github.com/VCityTeam/UD-Viz/tree/master), make sure to take a look at the [developer documentation](https://github.com/VCityTeam/UD-Viz/blob/master/docs/static/Developers.md)!

### Install the demos
 * If you need to compute a 3Dtiles tile-set
   - Understand what [py3dTilers](https://github.com/VCityTeam/py3dtilers) is made for
   - Depending on the type of your input data, try to run one of the tilers e.g. [CityTiler](https://github.com/VCityTeam/py3dtilers/tree/master/py3dtilers/CityTiler)
   - Alternatively understand is your work on Lyon métropole opendata [get acquainted with PythonCallingDocker](https://github.com/VCityTeam/UD-Reproducibility/tree/master/Computations/3DTiles/LyonTemporal/PythonCallingDocker#readme): for example try to [compute this tile-set](https://github.com/VCityTeam/UD-Reproducibility/tree/master/Demos/ValleeChimie#1-compute-correct-data-for-your-demo)
 * Clone, install and run the [UD-Viz-Template](https://github.com/VCityTeam/UD-Viz-Template)
   - display your tileset (the one you computed) by configuring configuration file.  

### Create a release
- Following this [documentation](https://github.com/VCityTeam/UD-Viz/blob/master/docs/static/ReleasePublish.md)

