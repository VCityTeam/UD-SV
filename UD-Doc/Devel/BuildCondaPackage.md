# How to build a conda package ?
> This guide is for packages:
> * are not yet distribution packages
> * not on PyPI
> * have to be built from scratch
> * require conda to manage base C libraries

## Table of contents
- [How to build a conda package ?](#how-to-build-a-conda-package)
  - [Table of contents](#table-of-contents)
  - [Why build a distribution package with conda ?](#why-build-a-distribution-package-with-conda-?)
    - [Notes on spatial libraries](#notes-on-spatial-libraries)
  - [Get and install Conda](#get-and-install-conda)
  - [Definitions](#definitions)
  - [A quick look on different states](#a-quick-look-on-different-states)
  - [The cookiecutter way](#the-cookiecutter-way)
    - [About Cookiecutter (*create a distribution package*)](#about-cookiecutter-create-a-distribution-package)
    - [Quick and easy way](#quick-and-easy-way)
  - [Set the conda recipe](#set-the-conda-recipe)
    - [The meta YAML file](#the-meta-yaml-file)
      - [Example](#example)
      - [Explanations](#explanations)
    - [Setup.py](#setuppy)
      - [Example](#example-1)
  - [Conda build](#conda-build)
    - [Install conda-build](#install-conda-build)
    - [Build the package](#build-the-package)
    - [Convert the package](#convert-the-package)
  - [Conda install](#conda-install)
    - [Install from local sources](#install-from-local-sources)
      - [Directly from tarball](#directly-from-tarball)
      - [By creating a conda channel](#by-creating-a-conda-channel)
  - [Developer's notes](#developers-notes)
    - [Create an conda virtual environment](#create-an-conda-virtual-environment)
      - [From scratch](#from-scratch)
    - [Activate this environment](#activate-this-environment)
    - [Install the package (*symbolik link*)](#install-the-package-symbolik-link)
    - [Build after changes](#build-after-changes)
    - [Useful resources](#useful-resources)

## Why build a distribution package with conda ?
### Notes on spatial libraries
When a package requires libraries with **spatial functionality** such as [GeoPandas](https://geopandas.org), it will be easier to work with [Conda](https://docs.conda.io/projects/conda/en/latest/). Such libraries depends on an open source libraries ([GEOS](https://geos.osgeo.org/), [GDAL](https://www.gdal.org/), [PROJ](https://proj.org/)). As written in GeoPandas "*Those **base C libraries can sometimes be a challenge to install**. [...] So depending on your platform, you might need to compile and install their C dependencies manually. [...]. Using conda [...] avoids the need to compile the dependencies yourself.*".

> *If you want to read more about it, you may want to read the [GeoPandas installation warnings](https://geopandas.org/install.html#installation) and the [blog article on differences between conda and pip](https://www.anaconda.com/understanding-conda-and-pip/). You can also have a look on the table below (from the just quoted blog article)*

|                       | conda                   | pip                             |
|-----------------------|-------------------------|---------------------------------|
| manages               | binaries                | wheel or source                 |
| can require compilers | no                      | yes                             |
| package types         | any                     | Python-only                     |
| create environment    | yes, built-in           | no, requires virtualenv or venv |
| **dependency checks** | **yes**                 | **no**                          |
| package sources       | Anaconda repo and cloud | PyPI                            |

Regarding these warnings and for **purposes of stability and multi-platform installations**, Conda seems to be the best option and Conda is used massively now and especially in the **data science**, machine learning and AI domains (*it includes most of useful packages such as NumPy, Pandas, ...*) and for **visualization**.

## Get and install Conda:
* [Miniconda](https://docs.conda.io/en/latest/miniconda.html) *=> minimal package*
* [Anaconda](https://www.anaconda.com/distribution/) *=> includes graphical interface and other tools*

## Definitions
* ***sdist***: source distribution, simple source-only .tar.gz
* ***bdist***: binary distribution => wheel. *To build and upload a distribution package*:
    ```bash
    python setup.py sdist bdist_wheel upload
    ```
* different levels:
    1. .py => standalone modules
    2. sdist => pure-Python packages
    3. wheel => Python packages
    4. conda => Python + system libraries

## A quick look on different states
| state | usable | importable | distribution package pip | distribution package conda | environment required | manage dependencies |
|:----:|:----:|:----:|:----:|:----:|:----:|:----:|
| standalone module | :heavy_check_mark: | :x: | :x: |:x: |:x: |:x:|
| simple package (*init Python files and hierarchy*)| :heavy_check_mark: | :heavy_check_mark: | :x: | :x: | :x: | :x: |
| conda environment with package | :heavy_check_mark: | :heavy_check_mark: | :x: | :x: | :heavy_check_mark: | :heavy_check_mark: |
| package sdist | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :x: | :x: | :x: |
| wheel | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :x: | :x: | :heavy_check_mark: / :x: |
| conda package | :heavy_check_mark: | :heavy_check_mark: | :x: | :heavy_check_mark: | :x: |:heavy_check_mark: |


## The cookiecutter way
### About Cookiecutter (*create a distribution package*)
[Cookiecutter](https://github.com/cookiecutter/cookiecutter) is "*A command-line utility that creates projects from cookiecutters (project templates), e.g. creating a Python package project from a Python package project template.*"

|     |     |
|:----|:----|
| Documentation | https://cookiecutter.readthedocs.io |
| GitHub | https://github.com/cookiecutter/cookiecutter |
| PyPI | https://pypi.python.org/pypi/cookiecutter |
| License | [BSD license](https://github.com/cookiecutter/cookiecutter/blob/master/LICENSE) |

> *To make license choice easier, check [choosealicense](http://choosealicense.com/)*

### Quick and easy way
* Use [Cookiecutter](https://github.com/cookiecutter/cookiecutter) and one of their templates like [cookiecutter-pypackage](https://github.com/audreyr/cookiecutter-pypackage) or [py_cookiecutter](https://github.com/DerThorsten/py_cookiecutter) or [cookiecutter-conda-python](https://github.com/conda/cookiecutter-conda-python)
* Examples:
    ```bash
    conda install -c conda-forge cookiecutter
    cookiecutter https://github.com/audreyr/cookiecutter-pypackage.git
    ```
    ```bash
    conda install -c conda-forge cookiecutter
    cookiecutter https://github.com/DerThorsten/py_cookiecutter.git
    ```
    ```bash
    conda install -c conda-forge cookiecutter
    cookiecutter https://github.com/conda/cookiecutter-conda-python.git
    ```
* Once done, you have to adapt/set the conda recipe to your needs (*see next section*).

## Set the conda recipe
> *[Conda recipe detailed documentation](https://docs.conda.io/projects/conda-build/en/latest/concepts/recipe.html)*

"*Building a conda package requires a recipe. A conda-build recipe is a flat directory that contains the following files*:
* ***meta.yaml**---A file that contains all the metadata in the recipe. Only package/name and package/version are required*.
* ***build.sh**---The script that installs the files for the package on macOS and Linux. It is executed using the bash command (could be optional, see [conda documentation](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#script))*.
* ***bld.bat**---The build script that installs the files for the package on Windows. It is executed using cmd (could be optional, see [conda documentation](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#script)).*
* ***run_test.[py,pl,sh,bat]**---An optional Python test file, a test script that runs automatically if it is part of the recipe*.
* ***Optional patches** that are applied to the source*.
* ***Other resources** that are not included in the source and cannot be generated by the build scripts. Examples are icon files, readme files and build notes.*" (source: [Anaconda website](https://docs.conda.io/projects/conda-build/en/latest/concepts/recipe.html))

### The meta YAML file
#### Example
```YAML
{% set name = "test" %}
{% set version = "0.7.0" %}

package:
  name: "{{ name|lower }}"
  version: "{{ version }}"

source:
  path: ..

build:
  number: 0
  script: "{{ PYTHON }} -m pip install . --no-deps --ignore-installed -vv "

requirements:
  host:
    - python
    - pip
  run:
    - fiona
    - pandas >=0.23.0
    - pyproj >=2.2.0
    - python
    - shapely
    - geopandas

 test:
   imports:
    - test

 about:
   home:
   license:
   license_family:
   license_file:
   summary: test
   doc_url:
   dev_url:

 extra:
   recipe-maintainers:
     - your-github-id-here

```

#### Explanations
> *Here are short explanations, for detailed one and explanations about other possible sections, see [Conda documentation about metadata](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html)*
* [template JINJA](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#templating-with-jinja) elements (*here for name and version*):
    ```YAML
    {% set name = "test" %}
    {% set version = "0.7.0" %}
    ```
* [package informations](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#package-section):
    ```YAML
    package:
      name: "{{ name|lower }}"
      version: "{{ version }}"
    ```
* [source](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#source-section) => Can be from tarball or zip archive (*from pypi for example*), git, hg, svn or local path (*case here*) :
    ```YAML
    source:
      path: ..
    ```
* [build](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#build-section) => number of the build & script for the build:
    ```YAML
    build:
      number: 0
      script: "{{ PYTHON }} -m pip install . --no-deps --ignore-installed -vv "
    ```
* [requirements](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#export-runtime-requirements) => what's needed to build and run the distribution package :
    ```YAML
    requirements:
      host:
        - python
        - pip
      run:
        - fiona
        - pandas >=0.23.0
        - pyproj >=2.2.0
        - python
        - shapely
        - geopandas
    ```
* [test](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#test-section) => optional, allows to run tests in a test environment after the package build (*here we only test if our package "test" is importable*):
    ```YAML
    test:
      imports:
       - test
    ```
* [about](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#about-section) => information about the package (*license, description, ...*):
    ```YAML
    about:
      home:
      license:
      license_family:
      license_file:
      summary: test
      doc_url:
      dev_url:
    ```
* [extra](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#extra-section) => area to store non-conda-specific metadata, for example GitHub id of maintainers:
    ```YAML
    extra:
      recipe-maintainers:
        - your-github-id-here
    ```

### Setup.py
> *Below is a short example, for more explanations see conda documentation and [Python packaging tutorial](https://packaging.python.org/tutorials/packaging-projects/#creating-setup-py)*

#### Example
```python
from setuptools import setup
import versioneer

setup(
    name='test',
    version=versioneer.get_version(),
    cmdclass=versioneer.get_cmdclass(),
    description="Short description",
    license="Proprietary",
    author="author",
    author_email='t',
    url='',
    packages=['test'],

    install_requires=[
		       "fiona"
		       "pandas >=0.23.0"
		       "pyproj >=2.2.0"
		       "python"
		       "shapely"
		       "geopandas"
		     ],
    keywords='test',
    classifiers=[
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7',
        'Programming Language :: Python :: 3.8',
    ]
)
```

## Conda build
### Install conda-build
> *See [conda documentation](https://docs.conda.io/projects/conda-build/en/latest/install-conda-build.html)*

In terminal window:
```bash
conda install conda-build
```

### Add required conda channels
Add the channels required for your package:

```bash
conda config --append channels [newchannel]
```

Example: 
  ```bash
  conda config --append channels conda-forge
  ```

### Build the package
Once the recipe is done, you can build the package (*this process could take a few seconds to a few minutes regarding your package*):
* *command*:
    ```bash
    conda build --numpy [numpy version to use] --output-folder [path/to/output/folder] [path/to/recipe/folder]
    ```
* *short explanations*:
    * ```--numpy [numpy version to use]``` => numpy version to use (*optional but will use default 1.11 in case of no version given*)
    * ```--output-folder [path/to/output/folder]``` => destination folder for the built package
    * ```[path/to/recipe/folder]``` => path to conda recipe folder (*containing the ```meta.yml``` file*)
* *example*:
    ```bash
    conda build --numpy 1.17.3 --output-folder test/build/ test/conda.recipe/
    ```

### Convert the package
> *[Conda documentation](https://docs.conda.io/projects/conda-build/en/latest/resources/commands/conda-convert.html#conda-convert)*

You can convert your package in order to set it for the other platforms and OS:
* *command*:
    ```bash
    conda convert [path/to/tar.bz2/file]  --platform [platform] -o [path/to/output/folder]
    ```
* *short explanations*:
    * ```[path/to/tar.bz2/file]``` => path to the built package .tar.bz2 file
    * ```--platform [platform]``` => platform name (*ex: linux-32*)
    * ```-o [path/to/output/folder]``` => output folder
* *example*:
    ```bash
    conda convert test/build/linux-64/test-0.7.0-py37_0.tar.bz2  --platform win-64 -o test/build/
    ```

## Conda install
### Install from local sources
#### Directly from tarball [***not recommended***]
> ***/!\ WARNING: "Installing packages directly from the file does not resolve dependencies. If your installed package does not work, it may have missing dependencies that need to be resolved manually." ([Anaconda User Guide](https://docs.anaconda.com/anaconda/user-guide/tasks/install-packages/#installing-packages-on-a-non-networked-air-gapped-computer))***

```bash
conda install --use-local [path/to/file.tar.bz2]
```

#### By creating a conda channel
> ***Installation via this way allows to use local build package but resolve dependencies.** See the [Stackoverflow answer](https://stackoverflow.com/a/35605508)*

1. **Create a directory channel**:
> *Recommended to use a tmp directory and respect the location of this directory*

* *command*:
    ```bash
    mkdir -p [path/to/new/directory/channel/arch]
    ```
* *example*:
    ```bash
    mkdir -p /tmp/my-conda-channel/linux-64
    ```
2. **Copy the build file to the channel & architecture directory**:
    * *command*:
        ```bash
        cp [path/to/tar.bz2/build/file] [path/to/new/directory/channel/arch/]
        ```
    * *example*:
        ```bash
        cp test/build/linux-64/test-0.7.0-py37_0.tar.bz2 /tmp/my-conda-channel/linux-64/
        ```
3. **Conda index the channel**:
    * *command*:
        ```bash
        conda index [path/to/new/directory/channel/arch]
        ```
    * *example*:
        ```bash
        conda index /tmp/my-conda-channel/linux-64/
        ```
4. **Conda install from this channel**:
    * *command*:
        ```bash
        conda install -c file:[path/to/new/directory/channel/] [package_name]=[package_version]
        ```
    * *example*:
        ```bash
        conda install -c file://tmp/my-conda-channel/ test=0.7.0
        ```

## Developer's notes
> *This method could be compared to the creation of a virtual environment and ```pip install -e``` command*.

### Create a conda virtual environment
#### From scratch
```bash
conda create --name [your_env]
```
 #### From file
```bash
conda env create -f [path/to/env.yaml/file]
```

### Activate this environment
```bash
conda activate [name_of_the_env]
```

### Install the package (*symbolik link*)
```bash
conda develop [path_to_package]
```

### Build after changes
> *[Follow the process described in this documentation](#set_the_conda_recipe) and make the necessary changes/adaptations*


### Useful resources
* Conda packaging:
    * [Building a conda package :notebook:](https://enterprise-docs.anaconda.com/en/latest/data-science-workflows/packages/build.html)
    * [Making packages and packaging “just work” | PyData 2017 Tutorial :tv:](https://www.youtube.com/watch?v=Kamld5Z-xx0)
    * The Sheer Joy of Packaging | SciPy 2018 Tutorial:
        * [Tutorial notes :notebook:](https://python-packaging-tutorial.readthedocs.io/en/latest/)
        * [Tutorial video :tv:](https://www.youtube.com/watch?v=xiI1i525ljE)
        * [Tutorial materials :octocat:](https://github.com/python-packaging-tutorial/python-packaging-tutorial)
    * [Anaconda recipes :octocat:](https://github.com/AnacondaRecipes)
    * [Production-grade Packaging with Anaconda | AnacondaCon 2018 :tv:](https://www.youtube.com/watch?v=tfI2hdK6vVY)
    * [Conda package specification :notebook:](https://docs.conda.io/projects/conda-build/en/latest/resources/package-spec.html)
    * [Build scripts :notebook:](https://docs.conda.io/projects/conda-build/en/latest/resources/build-scripts.html)
    * [Skeleton pypi :notebook:](https://docs.conda.io/projects/conda-build/en/latest/user-guide/tutorials/build-pkgs-skeleton.html)
    * [Build recipe templates :notebook:](https://docs.conda.io/projects/conda-build/en/latest/concepts/recipe.html#templates)
    * [Build environment variables :notebook:](https://docs.conda.io/projects/conda-build/en/latest/user-guide/environment-variables.html)
* Basic Python packaging:
    * [Python Packaging Authority :notebook:](https://www.pypa.io/en/latest/)
    * [Python Packaging User Guide :notebook:](https://packaging.python.org/)
    * [Detailed tutorial :notebook:](https://python-packaging.readthedocs.io/en/latest/)
* Cookiecutter templates:
    * [cookiecutter-conda-python :octocat:](https://github.com/conda/cookiecutter-conda-python)
    * [Python Cookiecutter :octocat:](https://github.com/DerThorsten/py_cookiecutter)
* Conda VS pip:
    * [Conda vs. pip vs. virtualenv commands :notebook:](https://conda.io/projects/conda/en/latest/commands.html#conda-vs-pip-vs-virtualenv-commands)
* Others:
    * [Python Packaging from Init to Deploy, Dave Forgac, Py! Ohio 2015 :tv:](https://www.youtube.com/watch?v=4fzAMdLKC5k)
    * [Building and Distributing Python Software with Conda, Jonathan Helmus,DePy 2016 :tv:](https://youtu.be/HSK-6dCnYVQ)
    * [Complete list of GitHub emojis :octocat:](https://gist.github.com/rxaviers/7360908)
    * [conda install requirements :octocat:](https://gist.github.com/luiscape/19d2d73a8c7b59411a2fb73a697f5ed4)
