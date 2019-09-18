```bash
mkdir 3DUse-DockerContext
wget https://raw.githubusercontent.com/MEPP-team/3DUSE/master/Docker/18.04/Dockerfile --directory-prefix 3DUse-DockerContext

```
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

## Running a set of simulations seems against CWL philosophy
ExpeData needs to run a set of logs-analyzer numerical experiments in order to
sweep the parameter space. Starting from the above workflows (with or without
 docker) we thus need to define a set of experiments corresponding formally to
 a set of (different) `logs-analyzer-input.yaml` input files (each of which being )
 a single numerical experiment.

 Starting from (say) `logs-analyzer-with-docker.cwl` how can one specify a set
 of such experiments ?
   - It would be straightforward to define a set of `logs-analyzer-input.yaml` files (derived from the current one). We would then need to describe the looping on those argument files. This looping (sequential iteration) could be achieve with the help of a simple shell script.
   - A slightly improved form would then be to describe that loop with Python (since there are CWL Python wrappers: `import cwltool`)). But such solution would also cross over the CWL representation boundary.

Let us thus re-formulate the question: starting from `logs-analyzer-with-docker.cwl` how can one specify a set of such experiments in a **CWL native manner** ?
Alas this seems hard, because CWL does not seem to be meant for describing loops:
   - old (2017) [discussion on conditionals and loops](https://groups.google.com/forum/#!topic/common-workflow-language/JU7PSEKr97M/discussion)
   - same question on [loops and if conditionals (at biostar)](https://www.biostars.org/p/250486/)
   - a voted down [proposal for loops](https://github.com/common-workflow-language/common-workflow-language/issues/495)

All what seems currently possible with CWL is based the [scattering mechanism](https://www.commonwl.org/user_guide/23-scatter-workflow/index.html) although some strong limitations hinder our objective. A central obstruction is that the list of arguments (refer to the [`scatter-job.yml` file](https://www.commonwl.org/user_guide/23-scatter-workflow/index.html)) is not at the same (representation) level as the `logs-analyzer-with-docker.cwl` inputs argument description. This would requires us to encode the argument list within a simple string argument (e.g.
```
logs-analyzer.conf --database_type SQLite --database_name LOG_1_1000_1.db \
--batch_size 1 --apache_access access_log_20170907.log --apache_access_maxl 1000 \
--mesures LOG_1_1000_1.res --app_inv_file LOG_1_1000_1.inv --app_log_file LOG_1_1000_1.log`
```
(or any other encoding holding the information of `logs-analyzer-input.yaml`) and then to use javascript snippets (inside CWL) to parse such an encoding in order to trigger the nested call to `logs-analyzer-with-docker.cwl`. This
looks like quite a painful work...

Said in other terms we cannot simply loops on `logs-analyzer-with-docker.cwl` without reducing `inputs:` to an ad-hoc encoding of the whole argument set of `logs-analyzer` which seems destructive of the the very existence of `logs-analyzer-with-docker.cwl`...

A simplified reformulation would be that CWL is meant for describing the API of a simulation engine (be it nested or hierarchic) as opposed to describing a set of experiments that should be realized.

## Running as module
[Only reference](https://github.com/common-workflow-language/cwltool#import-as-a-module)
Install the requirements and then run
```bash
(venv) python called-from-python.py 
```
