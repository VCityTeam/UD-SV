# CityDoctor

CityDoctor2 is a Java program for validating CityGML files. It checks whether certain criteria for e.g. geometries are met and outputs a report on the results.

Installing CityDoctor2 requires basic understanding of [Java](https://www.java.com/en/) and [Maven](https://maven.apache.org/)

## Installation Notes
As of 24/11/2022 the latest version of Maven available on linux is 3.6 which does not seem work with java 17 (which is a dependency of CityDoctor2 since 3.12)

To fix this the following dependencies were used:
- java version 11
- Maven version 3.6
- CityDoctor2 version 3.11

Additionally, installing maven 3.8 may work but this must currently be done manually

## Links
- Download latest version from [Gitlab](https://transfer.hft-stuttgart.de/gitlab/citydoctor/citydoctor2)
- [Installation instructions](https://transfer.hft-stuttgart.de/gitlab/citydoctor/citydoctor2#installation)
- [Usage instructions](https://transfer.hft-stuttgart.de/gitlab/citydoctor/citydoctor2#usage) 
