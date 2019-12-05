# RICT developer's central

### How to improve this page
Because a (coding) inception guide must be simple and easy to understand, if you happen to encounter something that is still confusing or awkwardly described then don't hesitate to submit possible enhancements/clarifications (through [an issue](https://github.com/MEPP-team/RICT/issues) or a [PR (Pull Request)](https://help.github.com/en/articles/about-pull-requests#about-pull-requests)).

## Step by step inception guide

### Get aquainted with RICT's project big picture
 * Read about the [whys and wherefores of the RICT project](../README.md): the general methodological framework RICT provides, as well as the [chosen software components](Devel/Architecture/Components.md#top) will both support and constrain your work.
 * As a general notice, and although RICT tries to follow mainstream practices (to reduce your surprises and associated loss of time), keep in mind that some practices used within RICT are specific to the project. As such they cannot be guessed or infered. This type of specific information is most often documented in the various [Readme.md](https://github.com/MEPP-team/UDV/README.md) and/or [Install.md](https://github.com/MEPP-team/UDV/blob/master/install.md) markdown files scattered across the repositories you will traverse.
   
### Check the pre-requisites
Languages:
 * [JavaScript](https://en.wikipedia.org/wiki/JavaScript) for the [UDV](Devel/Architecture/Components.md#ComponentUDV) frontend: JavaScript proposed [tutorial](https://developer.mozilla.org/fr/docs/Web/JavaScript)
 * [Python3](https://en.wikipedia.org/wiki/Python_(programming_language)) for the [UDS](evel/Architecture/Components.md#ComponentUDS) back end: proposed [tutorial](https://developer.mozilla.org/en-US/docs/Glossary/Python)
 * [C++](https://en.wikipedia.org/wiki/C%2B%2B) for some backend treatments (e.g. [SplitBuilding](Devel/Architecture/Components.md#ComponentUDSSplitBuilding)) requiring geography/geometry manipulations<br>

Tooling:
 * [git](ToolGit.md)
 * [git development cylce](https://github.com/MEPP-team/RICT/blob/master/Doc/DevelopersGithubCycle.md)
   
### Documentation 
Browse the [Doc/Devel subdirectory](https://github.com/MEPP-team/RICT/tree/master/Doc/Devel)

### Install/Deploy the demos
 * Clone [UDV](https://github.com/MEPP-team/UDV/tree/master/), install it and  [run the demos](https://github.com/MEPP-team/UDV/tree/master/UDV-Core/examples)

### Contributing code/info
 * Access rights: provide your github login to the project admin in order to **get git write access** to the various project repositories
 * Respect (when available) the **coding styles**
 * Read about the proposed [Git good practices](DevelopersGithubCycle.md).
 * **Submit often**: it is much better to often submit small yet effective and mature PR than jumbo/bulk code once in a while...
 * [Submit trough pull request (PR)](DevelopersGithubCycle.md#submitting-a-pull-request-pr): don't forget to provide a template.
 * Place and maintain some gentle pressure on the guilty parties when [asking for your pull request (PR) acceptation](DevelopersGithubCycle.md#pull-request-pr-acceptance-policy)

