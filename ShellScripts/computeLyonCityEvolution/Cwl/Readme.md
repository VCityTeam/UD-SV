## Installing the requirements:
1. Build the ad-hoc docker image<br>
   Refer to [this installation section of the Docker/Readme.md](../Docker/Readme.md#Installation)<br>
   Note: refer below on why cwltool can't do it for us !
2. Build the python environment 
   ```bash
   virtualenv -p python3 venv
   source venv/bin/activate
   pip3 install cwltool
   pip3 install cwlref-runner
   ```
   
## Runnable things
```
cwl-runner foreach_collect_and_split.cwl foreach_collect_and_split-reduced-input.yml
```

## CWL lessons learned

### A valueFrom issue with nested workflow
Refer to [this issue](https://github.com/common-workflow-language/cwltool/issues/1203).

### Unable to use the $import directive
Refer to [this issue](https://github.com/common-workflow-language/cwltool/issues/1198).

### Giving up on using `glob` on a step out (put)
Assume you have a `collect.cwl` that places its resulting set of output files in a resulting directory and that the output signature is that `Directory`. And further assume that you wish to chain `collect.cwl` with another workflow that expects a `File[]` as input type. You will thus need to "convert" a `Directory` output to its `File[]` content.
Although some references (e.g. [1](https://www.biostars.org/p/283544/), [2](https://raw.githubusercontent.com/esanzgar/gluetools-cwl/master/playground/glob_not_working.cwl)) indicate that you can use a `glob` to do so, making things work is not trivial. And quite a big number of "variations" around the following scheme
```
steps:
  collect:
     run: collect.cwl
     in:
       fileNames: FileNames
     out: [resultDir]
  grab_files:
     source: collect/resultDir
        results:
          valueFrom: |
            $( self.filter(file => !!file.basename.match(/.*_MY_FAVORITE_PATTERN.gml/)).pop() )
```
don't seem to work (at least for me).

Thus it seems that "globbing" on a workflow's `outputs:` is possible yet "globbing" on a steps' `out:` is much harder (your mileage may vary).

### Forget about using cwltool --print-dot to compute workflow diagram
Alas as explained [here](https://www.biostars.org/p/366246/) (but also in [this issue](https://github.com/common-workflow-language/cwlviewer/issues/203) or [that issue](https://github.com/common-workflow-language/cwlviewer/issues/202) or suggested [here](https://github.com/common-workflow-language/cwltool/issues/7)) the output of [`cwltool --print-dot'](https://pypi.org/project/cwltool/) is **NOT nearly as nice** as the ones of [cwlviewer](https://github.com/common-workflow-language/cwlviewer) (refer below). For example it misses input and output boxes...

### Using cwlviewer to compute workflow diagram imposes a git URL to your workflow
A recurent need is to compute your favorite full/integrated worklow diagram. This starts by running [`cwtool --pack`](https://github.com/common-workflow-language/cwltool#combining-parts-of-a-workflow-into-a-single-document) e.g. with
```
cwtool --pack my_favorite_workflow.cwl > my_integrated_workflow.cwl
```
that collects all the sub-referenced (e.g. pointed by `run` entries) and then by using [cwlviewer ](https://github.com/common-workflow-language/cwlviewer) on the result. Note that the resulting `my_integrated_workflow.cwl` is a temporary file (that requires updating each time a sub-workflow gets updated) that one does not want to commit on a git repository.
This prevents using the [online cwl viewer version](https://view.commonwl.org/) that requires an URL link to the workflow to be viewed. 

Now one might think that using a combination of a localhost running version of [cwlviewer ](https://github.com/common-workflow-language/cwlviewer) together with a lightweight htpp server to expose your workflow through an URL might get you on track.
For example you might try doing something something like

```
cwtool --pack my_favorite_workflow.cwl > my_integrated_workflow.cwl
python3 -m http.server &
cd /tmp
git clone https://github.com/common-workflow-language/cwlviewer.git
cd cwlviewer/
docker-compose up
```
and opening your favorite web-browser on `http://localhost:8080/` in order to to provide `http://localhost:8000/my_integrated_workflow.cwl`.
This strategy will alas fail because you missed reading the smallprints of [cwl viewer](https://view.commonwl.org/) that asks your URL worklow to be a **Git repository URL** (like on Github or Gitlab...). You got bitten...

