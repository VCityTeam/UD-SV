from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime, timedelta
from airflow.operators.docker_operator import DockerOperator

default_args = {
        'owner'                 : 'LIRIS',
        'description'           : 'Use of the DockerOperator',
        'depend_on_past'        : False,
        'start_date'            : datetime(2018, 1, 3),
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
