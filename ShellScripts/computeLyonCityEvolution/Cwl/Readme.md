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
