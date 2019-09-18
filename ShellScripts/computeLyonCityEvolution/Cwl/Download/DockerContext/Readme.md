Building the image:
```bash
docker build -t liris:collect_lyon_data .
```

Fetching `LYON_1ER_2009.zip` from Lyon Open Data and placing the extacted CityGML files in the outputdir directory (on the image as opposed to in the invocation directory)
```
docker run -t liris:collect_lyon_data LYON_1ER_2009.zip outputdir
```

Fetching `LYON_7EME_2009.zip` from Lyon Open Data and applying an ad-hoc patch
```
docker run -t liris:collect_lyon_data LYON_7EME_2009.zip outputdir
```

Running in interactive mode in order to debug
```bash
docker run -it --entrypoint /bin/bash liris:collect_lyon_data
```
