# UD-SV developer's central <a name="top"></a>

## Step by step inception guide

### Getting started
 * The [whys and wherefores of the UD-SV project](../Readme.md)
 * [Architecture](/Architecture/Application.md)

### Tooling: check your knowledge of the pre-requisites
The main languages used in UD-SV are:
 * [JavaScript](https://en.wikipedia.org/wiki/JavaScript), used for frontend, e.g. for [UD-Viz](https://github.com/VCityTeam/UD-Viz), [UD-Viz-demo](https://github.com/VCityTeam/UD-Viz-demo): proposed [tutorial](https://developer.mozilla.org/fr/docs/Web/JavaScript)
 * [Python3](https://en.wikipedia.org/wiki/Python_(programming_language)), e.g for the [UD-Serv](/Tools/Readme.md#ComponentUD-Serv) back end: proposed [tutorial](https://developer.mozilla.org/en-US/docs/Glossary/Python)
 * [C++](https://en.wikipedia.org/wiki/C%2B%2B) for some backend treatments (e.g. [SplitBuilding](/Tools/Readme.md#ComponentUD-ServSplitBuilding)) requiring geography/geometry manipulations
 * Markdown

In order to contribute code/info
 * [git](/Tools/ToolGit.md) and [git development cycle](/ImplementationKnowHow/GitWorflow/DevelopersGithubCycle.md)
 * adopt some **Editor/IDE** e.g. [VisualStudioCode](https://code.visualstudio.com/), [VisualStudio](https://visualstudio.microsoft.com/vs/community/) (for C/C++, Windows only), [PyCharm](https://www.jetbrains.com/pycharm/) (for Python), [sublime](https://www.sublimetext.com/)...
 * learn how to use a **[debugger](https://en.wikipedia.org/wiki/Debugger)** (depends on the language and the considered IDE)
 * [Continuous Integration](https://en.wikipedia.org/wiki/Continuous_integration) e.g. [Travis](https://github.com/VCityTeam/py3dtilers/blob/master/.travis.yml)
 * Containers, mainly [docker](/Tools/ToolDocker)
 * **coding styles** e.g. [eslint.rc](https://github.com/VCityTeam/UD-Viz-demo/blob/master/DemoFull/.eslintrc.json), for [C++](https://github.com/VCityTeam/VCity/wiki/Coding-Style) or [flake8](https://github.com/VCityTeam/py3dtilers/blob/master/.flake8)
 * When working on [Markdown](https://en.wikipedia.org/wiki/Markdown) based documentation [validate the links and references](DevelopersValidatingMardownLinks.md)

Adopt the best practices
 * **Submit often**: it is much better to often submit small yet effective and mature PR than jumbo/bulk code once in a while...
 * [Submit trough pull request (PR)](DevelopersGithubCycle.md#submitting-a-pull-request-pr): don't forget to provide a template.
 * Place and maintain some gentle pressure on the guilty parties when [asking for your pull request (PR) acceptation](DevelopersGithubCycle.md#pull-request-pr-acceptance-policy)

### Install the demos
UD-SV proposes some [online demos](http://rict2.liris.cnrs.fr/UD-Viz/UD-Viz-Core/examples/DemoStable/Demo.html). 
Try to [install them](../Install/Readme.md#top) on your local desktop.

