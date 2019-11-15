from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime, timedelta
from airflow.operators.docker_operator import DockerOperator
import sys

default_args = {
        'owner'                 : 'LIRIS',
        'description'           : 'Use of the DockerOperator',
        'depend_on_past'        : False,
        'start_date'            : datetime.utcnow(),
        'email_on_failure'      : False,
        'email_on_retry'        : False,
        'retries'               : 1,
        'retry_delay'           : timedelta(minutes=5)
}

dag = DAG('Collect',
          default_args=default_args,
          catchup=False)

temp_comd_variable_values="""
  echo "date: {{ ds }}"
  echo "test_mode: {{ test_mode }}"
  echo "task: {{ task }}"
  echo "{{ params }}"
"""

host_tmp_dir=None
if sys.platform == "darwin":
  # On OSX, and by default usage of dockerOperator, one gets an AirFlow error
  # message of the form
  #   ERROR - 500 Server Error: Internal Server Error 
  #   Mounts denied: The path /var/folders/XXX/YYY/T/airflowtmpZZZZ
  #   is not shared from OS X and is not known to Docker. You can configure
  #   shared paths from Docker -> Preferences... -> File Sharing.
  #   See https://docs.docker.com/docker-for-mac/osxfs/#namespaces for more
  #   info.) 
  #
  # The underlying OSX docker related problem is identified here:
  # https://github.com/docker/for-mac/issues/1532
  # https://stackoverflow.com/questions/45122459/docker-mounts-denied-the-paths-are-not-shared-from-os-x-and-are-not-known
  # 
  # It is well known to the Airflow community as illustrated by this
  #   [airflow issue](https://issues.apache.org/jira/browse/AIRFLOW-1381)
  # (and has a [duplicate](https://issues.apache.org/jira/browse/AIRFLOW-3510)
  # Note that this AIRFLOW jira issue indicates that solutions pointed by e.g.
  #  https://stackoverflow.com/questions/45122459/docker-mounts-denied-the-paths-are-not-shared-from-os-x-and-are-not-known
  # and that consists in exporting the OSX /var as /private/var can NOT
  # succeed. In particular trying to use the `volumes` option of the 
  # dockerOperator constructor was tried but failed (at least with the
  # following volume mount tentatives) :
  #   volumes=['/private/var/run/docker.sock:/private/var/run/docker.sock'],  
  #   volumes=['/private/var:/var'],
  #   volumes=['/var/run/docker.sock:/var/run/docker.sock'],
  # 
  # Anyhow the AirFlow community fixed this issue with this 
  #   [PR](https://github.com/apache/airflow/pull/5369)
  # apparently starting from 
  #   [release 1.10.3](https://github.com/apache/airflow/releases/tag/1.10.3)
  # 
  # Alas they are no example of usage of this new `host_tmp_dir` dockerOperator
  # constructor option and googling on 
  #  "airflow dockerOperator host_tmp_dir filetype:py"
  # yields no result. 
  #
  # Without further understanding it seems that the following definition
  # suffices to fix things:
  host_tmp_dir="/tmp/"

t1 = BashOperator(
        task_id='print_current_date',
        bash_command=temp_comd_variable_values,
        dag=dag
     )

t2 = DockerOperator(
        task_id='docker_command',
        image='liris:collect_lyon_data',
        api_version='auto',
        auto_remove=True,
        command="LYON_1ER_2009.zip .",
        host_tmp_dir=host_tmp_dir,  # Refer to above variable definition comment
        docker_url="unix://var/run/docker.sock",
        network_mode="bridge",
        dag=dag
     )

t3 = BashOperator(
        task_id='print_done',
        bash_command='echo "Done"',
        dag=dag
     )

t1 >> t2 >> t3
