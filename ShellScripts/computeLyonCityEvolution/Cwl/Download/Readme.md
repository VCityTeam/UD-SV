## Installing the requirements:
```bash
virtualenv -p python3 venv
source venv/bin/activate
pip3 install cwltool
pip3 install cwlref-runner
```

Build the ad-hoc images manually (refer below on why cwltool can't do it for us)
```bash
docker build -t liris:collect_lyon_data DockerContext
```
Run of a single step collect
```
(venv) cwl-runner collect.cwl collect-inputs.yml
```

## Note cwltool fails with dockerFile 
Note that running
```
(venv) cwl-runner collect-DockerFile_issue_failure.cwl collect-inputs.yml
```
that uses CWL's dockerFile instructions fails because of [this issue](https://github.com/common-workflow-language/cwltool/issues/312)...

## Note on the time efficiency impact of cwl-runner
Cwl-runner mounts the container `/home` and `/tmp` directories to ad-hoc temporary directories that it handles. Notice that this can have a significant performance impact on the execution time.
For example let us assume that the `liris:collect_lyon_data` container image is already build (refer to [DockerContext/Readme.md](DockerContext/Readme.md). Now running a collect job from the command line with
```bash
(venv) docker run -t liris:collect_lyon_data LYON_7EME_2009.zip junk-collect-output
``` 
will take roughly and in average (on an idle Power book...) 1'25'.
Yet running the same command through a cwl-runner invocation
```
(venv) cwl-runner collect.cwl collect-inputs.yml
```
will take 8 times more time (in average  12').
This is because under the hood the triggered docker command is of the form
```
docker run -i <some docker options>
   --volume=/private/tmp/docker_tmpbj2zv0k1:/exyQWS:rw \
                                  --workdir=/exyQWS    \
                                 --env=HOME=/exyQWS    \
   --volume=/private/tmp/docker_tmpeh23ihqm:/tmp:rw    \
                               --env=TMPDIR=/tmp       \
   liris:collect_lyon_data LYON_7EME_2009.zip junk-collect-output
```
and the `collect_data.sh` that is executed applies a `sed` to a 198M CityGML data file (`LYON_7EME_2009/LYON_7EME_BATI_2009.gml`)...
