# LAZ to PLY conversion

## Using pdal

Clone pdal docker:

```bash
docker pull pdal/pdal
```

Convert LAZ to PLY using `translate`:

```
docker run -v //G//Data//://data pdal/pdal pdal translate /data/my_pointcloud.laz /data/my_pointcloud.ply
```

- `//G//Data//://data` mount the (Windows) path `G:/Data` in `/data`
- `pdal/pdal` is the docker image to run
- `pdal translate` runs the [translate method](https://pdal.io/en/2.6.0/apps/translate.html), the first argument is the input and the second argument is the output. If no option is given, PDAL infers input/output type from file nme extension.
