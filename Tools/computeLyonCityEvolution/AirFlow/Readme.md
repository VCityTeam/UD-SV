## Installing the requirements:

### Build the ad-hoc docker images
Refer to [this installation section of the Docker/Readme.md](../Docker/Readme.md#Installation)

Note: too bad AirFlow won't do it for us
### 
```bash
cd <this-repository>/Tools/computeLyonCityEvolution/Workflow/AirFlow
virtualenv -p python3 venv
source venv/bin/activate
(venv) pip3 install apache-airflow
(venv) pip3 install docker         # Required for DockerOperator examples
(venv) pip3 install kubernetes     # Required for KubernetesOperator examples
```

### Setting up airflow
Point Airflow to use the dags directory located in the current working directoryby overwriting your `$AIRFLOW_HOME` directory (that defaults to `~/airflow`).
```
cd <this-repository>/Tools/computeLyonCityEvolution/Workflow/AirFlow
export AIRFLOW_HOME=`pwd`
airflow initdb     # Initialize the dags database
```
Make sure that the proper dags were parsed:
```
airflow list_dags
airflow list_dags --report   # Full report: usefull to assert pathes
```

### Running Airflow's sequential tutorial example
Get going by running Airflow tutorial example (renamed here to SequentialTutorial just to make sure we are indeed loading the local copy):
```
airflow list_tasks SequentialTutorial
airflow list_tasks SequentialTutorial --tree
airflow test SequentialTutorial print_date 2015-06-01
airflow test SequentialTutorial sleep 2015-06-01
airflow test SequentialTutorial templated 2015-06-01
```

## DockerOperator

### Running Airflow's Docker tutorial example
The execution of the tutorial example goes
```
(venv) airflow test DockerTutorial docker_command 2015-06-01
```
Note that by default **FAILS** on OSX. 
References: 
 - [Marc Lamberti's how to use dockeroperator apache airflow](https://marclamberti.com/blog/how-to-use-dockeroperator-apache-airflow/)
 - [API](https://airflow.apache.org/_api/airflow/operators/docker_operator/index.html?highlight=docker#module-airflow.operators.docker_operator)
 
### Running the hand made Collect example
```
(venv) airflow test Collect print_current_date 2015-06-01
(venv) airflow test Collect docker_command 2015-06-01
```

### DockerOperator Open Problem 1 (DOP1): data/files transfer between components/operators
In order to transfer data between operators ([ref1](https://stackoverflow.com/questions/42762087/airflow-and-data-transfer-between-operators), [ref2](https://stackoverflow.com/questions/55531774/transmitting-data-between-components-in-airflow)) Airflow uses the [Xcoms cross-communication mechanism](https://airflow.apache.org/concepts.html#xcoms).
Xcoms requires the transmitted data to be ["pickable"](https://docs.python.org/3/library/pickle.html) which might a be a too big constraint in some contexts.
For example assume that you dag includes a DockerOperator wrapping some treatment that uses simple file for its I/O (think e.g. of some arbitrary binary file format used in application domain like medical imaging...). Then Xcoms would require you to write the ad-hoc deserialization/serialization of such a format.

#### DOP1 Constraints and recommendations
 * [ETL best practices with Airflow](https://gtoonstra.github.io/etl-with-airflow/)
    - recommends to **Rest data between tasks** (refer to [the eponymous section on that page](https://gtoonstra.github.io/etl-with-airflow/principles.html))
    - warns that **you should not and even cannot do is depend on temporary data (files, etc.) that is created by one task in other tasks downstream**.
 * The ["ingesting files" example](https://gtoonstra.github.io/etl-with-airflow/ingestfile.html) (of [ETL best practices with Airflow](https://gtoonstra.github.io/etl-with-airflow/)) mentions that
    ```
    It’s helpful to have an audit record of the data that you ingested from
    external systems. These external systems can already be in a file format
    (FTP), an HTTP/SOAP/API connection with json or xml output, or perhaps
    even by connecting to an external database directly.
    ```
 * The [same "ingesting files" example](https://gtoonstra.github.io/etl-with-airflow/ingestfile.html) recommends to structure the file by-products of a dag by using to ad-hoc operators (that use [`shutil.copyfile()`](https://docs.python.org/3/library/shutil.html) :
      - an [`FileToPredictableLocationOperator`](https://github.com/gtoonstra/etl-with-airflow/blob/master/examples/file-ingest/acme/operators/file_operators.py#L30) in charge of "Picking up a file from somewhere and lands this in a predictable location elsewhere"
      - an [`PredictableLocationToFinalLocationOperator`](https://github.com/gtoonstra/etl-with-airflow/blob/master/examples/file-ingest/acme/operators/file_operators.py#L81) that "Picks up a file from predictable location storage and loads/transfers the results to a target system (in this case another directory, but it could be anywhere)."

#### DOP1 What are the Xcom alternatives ?
  * [Fileflow](https://fileflow.readthedocs.io/en/latest/) ?:
    - Fileflow is a collection of modules that support data transfer between Airflow tasks via file targets and dependencies with either a local file system or S3 backed storage mechanism.
    - Caveat emptor: [last commit](https://github.com/industrydive/fileflow/commits/master) dates back to 2017
    - Caveat emport: Fileflow has been tested on **Python 2.7** and Airflow version 1.7.0. (as of October 2019 aiflow version is 1.10.x and examples fails on install)
    - They are only a couple hundred lines of code...
    - As many examples manipulating files this flow write some files and then read them as opposed to reading files from the local filesystem...
  * [sftpOperator](https://airflow.apache.org/_api/airflow/contrib/operators/sftp_operator/index.html) ?
    - [Multiple files sftp](https://precocityllc.com/blog/airflow-and-xcom-inter-task-communication-use-cases/)
 * S3 ? They are many S3 related operators e.g.
    - [s3_copy_object_operator](https://airflow.apache.org/_api/airflow/contrib/operators/s3_copy_object_operator/index.html) or 
    - [s3_to_sftp_operator](https://airflow.apache.org/_api/airflow/contrib/operators/s3_to_sftp_operator/index.html)

### DockerOperator open problem 2: how to deal with DockerOperator I/O on files ?
Independently from the interoperator communication (file handling) difficulty, using Docker for computations introduces the technical burden of having to deal with forth (copying input files from invocation directory to docker workdir) and back (copying chosen resulting files from docker workdir to invocation directory).
An interesting feature of CWL is precisely to hide away such details.
Just to illustrate how tedious this task can be, the following command is a CWL generated docker run command that deals with the I/O business (look at the many `--volume` arguments as well as the `--input-file` one):
```
docker run -i \
    --volume=/private/tmp/docker_tmp6rbchhl7:/FNUixl:rw \
    --volume=/private/tmp/docker_tmps7a_v8hv:/tmp:rw \
    --volume=/<user_HOME_DIR>/UNSAVED/tmp/UD-SV.MEPP-team/ShellScripts/computeLyonCityEvolution/Cwl/Collect/junk-output-of_foreach_collect/LYON_1ER_2009/LYON_1ER_BATI_2009.gml:/var/lib/cwl/stg9c05f462-4e7d-4d93-9ad4-7d92162da6ce/LYON_1ER_BATI_2009.gml:ro \
    --workdir=/FNUixl \
    --read-only=true \
    --user=501:20 \
    --rm \
    --env=TMPDIR=/tmp \
    --env=HOME=/FNUixl \
    --cidfile=/private/tmp/docker_tmpjzi5pu7m/20191016115350-750376.cid \
    liris:3DUse \
    splitCityGMLBuildings \
    --input-file \
    /var/lib/cwl/stg9c05f462-4e7d-4d93-9ad4-7d92162da6ce/LYON_1ER_BATI_2009.gml \
    --output-file \
    junk-split.gml \
    --output-dir \
    junk-dir
```
Note that
 * The are no concrete example of [using 'tmp_dir' parameter of DockerOperator](https://www.google.com/search?q=dockeroperator+tmp_dir+filetype:py)
 * There is a [single example of DockerOperator using `volumes`](https://www.google.com/search?q=dockeroperator+volumes+filetype%3Apy)
    - it is sample that provides a [`docker_copy_data` script](https://github.com/apache/airflow/blob/master/airflow/example_dags/docker_copy_data.py)
    - [here is the usage of volumes](https://github.com/apache/airflow/blob/master/airflow/example_dags/docker_copy_data.py#L81)

### DockerOperator Open problem 3: provide a file server WITHIN the airflow script
We have the freedom to choose some file server technology. For example we could consider a [dockerized sftp server](https://github.com/atmoz/sftp). Yet there is the additional difficulty that such a file server must exist across the execution of all the operators of the pipeline (requiring some file input/output). In other terms this file server (DockerOperator) should be a parallel task to the rest of the pipeline and we must guarantee that it starts before all the other ones and ends after them.
Yet there doesn't seem to exist an Airflow way to express such a constraint. If this is were indeed impossible, the Airflow script would require some "outside" ressoure whose allocation/tear-down would have to be described elsewhere (which would obfuscate things).

## KubernetesOperator
### Airflow configuration
Running airflow dags with KubernetesPodOperators requires the executor to support the KubernetesExecutor (refer to the `executor` entry in your `$AIRFLOW_HOME/airflow.cfg` configuration file). In turn the KubernetesExecutor requires other backend than default database SQLite (and you'll get the error message `airflow.exceptions.AirflowConfigException: error: cannot use sqlite with the KubernetesExecutor` when not doing so).
Yet the default configuration, refer to the `sql_alchemy_conn` entry of your `$AIRFLOW_HOME/airflow.cfg` configuration file and you'll have to use MySQL or PostgreSQL, for example ([refer here](https://stackoverflow.com/questions/36822515/configuring-airflow-to-work-with-celeryexecutor)).

Configuring Airflow with a PostgreSQL metadata database server is nicely described [in the phase 2 section of this blog](https://stlong0521.github.io/20161023%20-%20Airflow.html).

```
brew install postgresql
# To have launchd start postgresql now and restart at login:
brew services start postgresql
# Or, if you don't want/need a background service you can just run:
pg_ctl -D /usr/local/var/postgres start
```
```
createdb airflow_meta      # For example
```
Deal with the newly created [database ownership/password](https://stackoverflow.com/questions/12720967/how-to-change-postgresql-user-password). 
```
# Install necessary sub-packages
(venv) pip install apache-airflow[crypto] # For connection credentials protection
(venv) pip install apache-airflow[postgres] # For PostgreSQL DBs
```
Modify the configuration in `$AIRFLOW_HOME/airflow.cfg`
```
# Change the executor to Local Executor
executor = LocalExecutor

# Change the meta db configuration
sql_alchemy_conn = postgresql+psycopg2://<your_postgres_user_name>:<your_postgres_password>@host_name/database_name
```
Test the db access with the [profiling interface](https://airflow.apache.org/profiling.html) with e.g. the request `select * from dag limit 100`

### Running KubernetesPodOperator Airflow's tutorial example
WARNING: the Permanent Volume Claim must be done manually !!!
```
$ kubectl apply -f kubernetes_airflow_documentation_sample-storage-class.yaml
(venv) airflow test kubernetes_airflow_documentation_sample start 2015-06-01
```

### Running some other KubernetesPodOperator example
Running this [KubernetesPodOperator tutorial](https://kubernetes.io/blog/2018/06/28/airflow-on-kubernetes-part-1-a-different-kind-of-operator/
)
```
(venv) airflow test kubernetes_sample passing-task 2015-06-01
(venv) airflow test kubernetes_sample failing-task 2015-06-01
```

### FAILING FOR NOW ?

### References:
 * Must read: Marc Lamberti's [Airflow Kubernetes EXECUTOR](https://marclamberti.com/blog/airflow-kubernetes-executor/)
 * [Airflow on Kubernetes tutorial](https://kubernetes.io/blog/2018/06/28/airflow-on-kubernetes-part-1-a-different-kind-of-operator/)  (Part 1: A Different Kind of Operator)
 * Airflow documentation
    * [KubernetsOperator gateway](https://airflow.apache.org/kubernetes.html)
    * [API reference](https://airflow.apache.org/_api/airflow/contrib/operators/kubernetes_pod_operator/index.html?highlight=kubernetes#module-airflow.contrib.operators.kubernetes_pod_operator)
 * [Kubernetes's DockerOperator tutorial](https://kubernetes.io/blog/2018/06/28/airflow-on-kubernetes-part-1-a-different-kind-of-operator/)


# Technical notes
## Airflow technical notes

 * Initialization<br>
   Point Airflow to use the dags to the directory where they are located (e.g. in the current working directory) by overwriting your `$AIRFLOW_HOME` directory (that defaults to `~/airflow`) :
   ```
   export AIRFLOW_HOME=`pwd`
   airflow initdb     # initialize the database
   ```
   References:
    * [Initialize the database](https://airflow.apache.org/howto/initialize-database.html))
    * [First Airflow setup and run](https://medium.com/@moyukh_51433/outlier-detection-using-airflow-workflow-6424c209ceff)

 * Update the database `airflow upgradedb` (many times after a single `airflow initdb`)

 * `airflow run -sd SUBDIR` or `airflow test -sd SUBDIR` : file location or directory from which to look for the dag
    Reference: [how to use several dag_folders](https://medium.com/@xnuinside/how-to-load-use-several-dag-folders-airflow-dagbags-b93e4ef4663c)


 * Assert (refer [here](https://airflow.apache.org/tutorial.html)) that the proper dags are parsed:
   ```
   airflow list_dags
   airflow list_dags --report   # Full report: usefull to assert pathes
   ```

 * List the tasks of a dag:
   ```
   airflow list_tasks <dag_name>
   airflow list_tasks <dag_name> --tree
   ```

 * Executing a single taks
   ```
   airflow test SequentialTutorial print_date 2015-06-01
   airflow test SequentialTutorial sleep 2015-06-01
   airflow test SequentialTutorial templated 2015-06-01
   ```

 * Running a [full dag from the CLI](https://bcb.github.io/airflow/run-dag-and-watch-logs): 
   ```
   export AIRFLOW__CORE__LOG_FILENAME_TEMPLATE="{{ ti.dag_id }}.log"
   airflow scheduler   # start the scheduler
   airflow trigger_dag <my_dag_name>
   tail -f $AIRFLOW_HOME/logs/...     # Watch the logs
   ``` 
 
 * Using the UI
   ```
   # start the web server, default port is 8080
   airflow webserver -p 8080
   airflow scheduler    # start the scheduler (when not already done)
   # visit localhost:8080 in the browser 
   ```

 * Various references:
   - [Testing and debugging airflow](https://blog.godatadriven.com/testing-and-debugging-apache-airflow) is tedious

## Kubernetes technical notes
```
kubectl version                    # Assert kubectl is installed
kubectl cluster-info  # Display addresses of the master and services
kubectl get nodes                  # List all nodes
kubectl get --watch pods           # Dynamic (never ending) listing
kubectl get deployments --all-namespaces # List deployments
kubectl get pods --all-namespaces  # List all pods in all namespaces
kubectl describe pods --all-namespaces
kubectl describe pod <pod-name>
kubectl exec <pod-name> -c <container-name> <command>
kubectl exec -ti $POD_NAME bash    # Execute bash on the first container
```
```
export NODE_PORT=$(kubectl get services/kubernetes-bootcamp -o go-template='{{(index .spec.ports 0).nodePort}}')
$ echo NODE_PORT=$NODE_PORT
```

Questions:
 - There are [auditing features](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/) and [monitoring features (heapster)](https://github.com/kubernetes/kubernetes/blob/master/cluster/addons/cluster-monitoring/README.md). But how to trail pod deployment requests from the cli ?

References:
 - [kubectl cheatsheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
 - [Kubernetes basics tutorial](https://kubernetes.io/docs/tutorials/kubernetes-basics)
 - This [Google's KubernetesPodOperator tutorial](https://cloud.google.com/composer/docs/how-to/using/using-kubernetes-pod-operator) alas requires [Google's cloud composer](https://cloud.google.com/composer/)

## WIP
A PermanentVolume can map to a file on the host. Use `kubectl describe pv` and look at the `Source/Path` entry.

```
$ cd UD-SV.MEPP-team/ShellScripts/computeLyonCityEvolution/Workflow/AirFlow
$ airflow test kubernetes_airflow_documentation_sample start 2015-06-01 &
kubectl get pods   # Yields: test-e38ed9c0  status = Pending
kubectl get events # Yields: pod/test-e38ed9c0   persistentvolumeclaim "test-volume" not found
kubectl get all --all-namespaces # Yummy
kubectl describe pods/test-4bc9e3d6
kubectl describe pv
watch kubectl get pv,pvc,events --sort-by='.metadata.creationTimestamp'
```
Reference: [pending status issue](https://github.com/kubernetes/kubernetes/issues/14023)
