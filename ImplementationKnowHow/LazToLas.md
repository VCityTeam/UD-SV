The `laszip` CLI command is part of the [LAStools](https://lastools.github.io/)
toolbox.
They are a few occurrences of the docker based containerization of LAStools
among which
| Author | [Github](https://github.com/) | [Dockerhub](https://hub.docker.com) | OS base | Dockerfile |
| ------ | ----------------------------- | ----------------------------------- | ------- |------------|
| [Devon Hakel-Kinko](https://github.com/devonhk/dockerfiles/blob/master/lastools/Dockerfile#L10C19-L10C36) | [devonhk/dockerfiles/lastools](https://github.com/devonhk/dockerfiles/tree/master/lastools) | [pydo/lastools](https://hub.docker.com/r/pydo/lastools#!) | Debian:stretch-slim | [Dockerfile](https://github.com/devonhk/dockerfiles/blob/master/lastools/Dockerfile) |
| [Jules Robichaud-Gagnon](https://github.com/jrobichaud) | [Pointscene/docker-lastools](https://github.com/Pointscene/docker-lastools) | N/A | Ubuntu 18.04 | [Dockefile](https://github.com/devonhk/dockerfiles/blob/master/lastools/Dockerfile) |
| [Håkon Åmdal](https://github.com/hawkaa) | [hawkaa/docker-lastools](https://github.com/hawkaa/docker-lastools) | [hakonamdal/lastools](https://hub.docker.com/r/hakonamdal/lastools) | [Wine](https://linuxize.com/post/how-to-install-wine-on-ubuntu-20-04/) over Ubuntu 20.04 | [Dockerfile](https://github.com/hawkaa/docker-lastools/blob/master/Dockerfile) |

Usage example:
```bash
wget https://dataset-dl.liris.cnrs.fr/elaphes-cave/Exp-Cloud-ELAPHS-94M.laz
docker run -v `pwd`:/lastools hakonamdal/lastools las2las -i Exp-Cloud-ELAPHS-94M.laz -o Exp-Cloud-ELAPHS-94M.las
```