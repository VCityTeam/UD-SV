from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime, timedelta
from airflow.operators.docker_operator import DockerOperator
import sys # required for host_tmp_dir fix on OSX. Refer to 
           # Collect_DockerOperator.py for the details

default_args = {
        'owner'                 : 'airflow',
        'description'           : 'Use of the DockerOperator',
        'depend_on_past'        : False,
        'start_date'            : datetime(2018, 1, 3),
        'email_on_failure'      : False,
        'email_on_retry'        : False,
        'retries'               : 1,
        'retry_delay'           : timedelta(minutes=5)
}

with DAG('DockerTutorial', 
         default_args=default_args, 
         schedule_interval="5 * * * *", 
         catchup=False) as dag:
        t1 = BashOperator(
                task_id='print_current_date',
                bash_command='date'
        )

        t2 = DockerOperator(
                task_id='docker_command',
                image='centos:latest',
                api_version='auto',
                auto_remove=True,
                command="/bin/sleep 30",
                docker_url="unix://var/run/docker.sock",
                network_mode="bridge",
                host_tmp_dir=None if not sys.platform == "darwin" else "/tmp/"
        )

        t3 = BashOperator(
                task_id='print_hello',
                bash_command='echo "hello world"'
        )

        t1 >> t2 >> t3
