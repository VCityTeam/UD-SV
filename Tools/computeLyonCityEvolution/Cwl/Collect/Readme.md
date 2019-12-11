## Installing the requirements:
1. Build the ad-hoc docker image<br>
   Refer to [this installation section of the Docker/Readme.md](../../Docker/Readme.md#Installation)<br>
   Note: refer below on why cwltool can't do it for us !
2. Build the python environment
   ```bash
   virtualenv -p python3 venv
   source venv/bin/activate
   pip3 install cwltool
   pip3 install cwlref-runner
   ```


## Run a single step of collecting data

Run of a single step collect
```
(venv) cwl-runner collect.cwl collect-inputs.yml
```

### Note cwltool fails with dockerFile
Note that running
```
(venv) cwl-runner collect-DockerFile_issue_failure.cwl collect-inputs.yml
```
that uses CWL's dockerFile instructions fails because of [this issue](https://github.com/common-workflow-language/cwltool/issues/312)...

## Run the full collection of Lyon Metropole data
Simply run
```
(venv) cwl-runner --eval-timeout 1000 foreach_collect.cwl foreach_collect-inputs.yml
```
and the output files get placed in the output directory specified in the input file.
Notes:
 - if cwl-runner stops with a warning of the form `WARNING foreach_collect.cwl:39:10: Recursive directory listing has resulted in a large number of File` then refer below to the section concerning the eval-timeout option (in short use `cwl-runner --eval-timeout 1000` in place of `cwl-runner`)
 - Performance: this script runs in 1H20' on a idle MacBookPro (2.6 GHz Intel Core i7, 32GB)

### Debugging
Note that if you wish to fool-around/learn-about-cwl you can:
 - run the `foreach_collect` on a reduced set of data sets
   ```
   cwl-runner --js-console foreach_collect.cwl foreach_collect-inputs.yml-debug_short.yml
   ```
 - run the `foreach_collect` with a [`--js-console`](https://www.biostars.org/p/303401/) argument (place some `console.log()` calls in the organize/expression javascript code)
 - understand how the CWL `scatter` works by looking at the `foreach_collect_list_output_directories.cwl` workflow and running it with e.g.
   ```
   cwl-runner foreach_collect_list_output_directories.cwl foreach_collect-inputs.yml-debug_short.yml
   ```    

### Note concerning the eval-timeout option
Note that providing `foreach_collect-inputs.yml` as argument will produce quite a large directory tree of output. This will trigger the following cwltool warning
```bash
WARNING foreach_collect.cwl:39:10: Recursive directory listing has resulted in a large number of File
       objects (56461) passed to the input parameter 'directories'.
       [...]
```
suggesting to limit this hindrance by using a 'cwltool:LoadListingRequirement' hint (with `shallow_listing` or `no_listing`) to change the directory listing behavior.

In turn this will trigger this warning
```
WARNING Failed to evaluate expression:
Expression evaluation error:
Long-running script killed after 20 seconds: Javascript expression was:
```
followed by a quote of the `Expression` section `foreach_collect.cwl`.
Because we do need those files as output we [either need to install  Nodejs or suse the `--eval-timeout` cli option](https://github.com/common-workflow-language/cwltool/blob/master/windowsdoc.md#workflows-with-javascript-expressions-occasionally-give-timeout-errors)  


## Note on the time efficiency impact of cwl-runner
Cwl-runner mounts the container `/home` and `/tmp` directories to ad-hoc temporary directories that it handles. Notice that this can have a significant performance impact on the execution time.
For example let us assume that the `liris:collect_lyon_data` container image is already build (refer to [Docker/Readme.md](../../Docker/Readme.md). Now running a collect job from the command line with
```bash
(venv) docker run -t liris:collect_lyon_data LYON_7EME_2009.zip junk-output-collect
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
   liris:collect_lyon_data LYON_7EME_2009.zip junk-output-collect
```
and the `collect_data.sh` that is executed applies a `sed` to a 198M CityGML data file (`LYON_7EME_2009/LYON_7EME_BATI_2009.gml`)...
