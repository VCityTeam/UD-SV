## Installing the requirements:
In the following we assume that the current working directory
```bash
virtualenv -p python3 venv
source venv/bin/activate
pip3 install -r ./requirements.txt
# Also install the dependencies of the logs-analyzer.py python script
pip3 install -r ../logs-analyzer/requirements.txt
```

## Running logs-analyzer as a cwltool sub-process:
Once the requirements are installed we can run logs-analyzer.
Notice how we have to place the logs-analyzer.py (absolute pathname) in the PATH variable and specify to the cwl-runner command (with the help of the '--preserve-environment' flag for the runner to find the script at runtime:
```bash
PATH=$PATH:$(pwd)/../logs-analyzer/src/ cwl-runner --preserve-environment PATH logs-analyzer-as-subprocess.cwl logs-analyzer-input.yaml
```
The four output files (`LOG_1_1000_1.inv`, `logdb_1_1000_1.db`,
`LOG_1_1000_1.log`, `LOG_1_1000_1.res`) end up copied 9by cwl-runner in the
 current working directory.

## Running logs-analyzer within a docker container

```bash
docker build --build-arg LIRIS_GITLAB_USER=<your_login> --build-arg LIRIS_GITLAB_PASSWD="<your_passowd>" -t liris:logs-analyzer .
cwl-runner logs-analyzer-with-docker.cwl logs-analyzer-input.yaml
```

## Running as module
[Only reference](https://github.com/common-workflow-language/cwltool#import-as-a-module)
Install the requirements and then run
```bash
(venv) python called-from-python.py 
```

## Using cwlviewer to compute workflow diagram
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

