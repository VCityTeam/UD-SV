# LAZ to PLY conversion

## Using pdal (Point Data Abstraction Library)

First pull the [pdal](https://pdal.io/en/) docker
[image (pdal/pdal)](https://hub.docker.com/r/pdal/pdal/tags/#!)
with

```bash
docker pull pdal/pdal
```

Then convert LAZ to PLY using
- the `pdal translate` command that runs the 
  [translate method](https://pdal.io/en/2.6.0/apps/translate.html) method
- that takes its input as first argument and the second argument as its output.

Example:

* On windows
  ```bash
  docker run -v //G//Data//://data pdal/pdal pdal translate /data/my_pointcloud.laz /data/my_pointcloud.ply
  ```
  where `//G//Data//://data` mounts the (Windows) path `G:/Data` in `/data`
* On Un*x
  ```bash
  docker run -v `pwd`:/data pdal/pdal pdal translate /data/my_pointcloud.laz /data/my_pointcloud.ply
  ```
