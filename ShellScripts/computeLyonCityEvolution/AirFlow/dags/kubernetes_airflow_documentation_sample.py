# references:
# - https://kubernetes.io/blog/2018/06/28/airflow-on-kubernetes-part-1-a-different-kind-of-operator/
# The following code is a striped/fixed version of the original AirFlow
# official documentation as encountered at
#    https://airflow.apache.org/kubernetes.html#kubernetes-operator
from airflow.contrib.operators.kubernetes_pod_operator import KubernetesPodOperator
from airflow.contrib.kubernetes.secret import Secret
from airflow.contrib.kubernetes.volume import Volume
from airflow.contrib.kubernetes.volume_mount import VolumeMount
from airflow.contrib.kubernetes.pod import Port

from airflow import DAG
from datetime import datetime, timedelta

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime.utcnow(),
    'email': ['airflow@example.com'],
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5)
}

dag = DAG('kubernetes_airflow_documentation_sample',
          default_args=default_args, 
          schedule_interval=timedelta(minutes=10))


#####################################
#secret_file = Secret('volume', '/etc/sql_conn', 'airflow-secrets', 'sql_alchemy_conn')
#secret_env  = Secret('env', 'SQL_CONN', 'airflow-secrets', 'sql_alchemy_conn')
#secret_all_keys  = Secret('env', None, 'airflow-secrets-2')
port = Port('http', 80)
configmaps = ['test-configmap-1', 'test-configmap-2']

volume_config= {
    'persistentVolumeClaim':
      {
        'claimName': 'pvc-test-volume-alamano'
      }
    }

volume = Volume(name='pv-test-volume', configs=volume_config)

volume_mount = VolumeMount('pv-test-volume',
                            mount_path='/root/mount_file',
                            sub_path=None,
                            read_only=False)

affinity = {
    'nodeAffinity': {
      'preferredDuringSchedulingIgnoredDuringExecution': [
        {
          "weight": 1,
          "preference": {
            "matchExpressions": [   # Added fix from original code 
              {
                "key": "disktype",
                "operator": "In",
                "values": ["ssd"]
              }
            ]
          }
        }
      ]
    },
#     "podAffinity": {
#       "requiredDuringSchedulingIgnoredDuringExecution": [
#         {
#           "labelSelector": {
#             "matchExpressions": [
#               {
#                 "key": "security",
#                 "operator": "In",
#                 "values": ["S1"]
#               }
#             ]
#           },
#           "topologyKey": "failure-domain.beta.kubernetes.io/zone"
#         }
#       ]
#     },
#     "podAntiAffinity": {
#       "requiredDuringSchedulingIgnoredDuringExecution": [
#         {
#           "labelSelector": {
#             "matchExpressions": [
#               {
#                 "key": "security",
#                 "operator": "In",
#                 "values": ["S2"]
#               }
#             ]
#           },
#           "topologyKey": "kubernetes.io/hostname"
#         }
#       ]
#     }
}

tolerations = [
    {
        'key': "key",
        'operator': 'Equal',
        'value': 'value'
     }
]

start = KubernetesPodOperator(task_id='start',
                          namespace='default',
                          image="ubuntu:16.04",
                          cmds=["bash", "-cx"],
                          #arguments=["mkdir -p /root/mount_file ;echo toto > /root/mount_file/junk"],
                          arguments=["whoami && pwd && ls -alF /root/mount_file && touch /root/mount_file/prout"],
                          labels={"foo": "bar"},
                          #secrets=[secret_file, secret_env, secret_all_keys],
                          ports=[port],
                          volumes=[volume],
                          volume_mounts=[volume_mount],
                          name="start",
                          affinity=affinity,
                          is_delete_operator_pod=True,
                          hostnetwork=False,
                          tolerations=tolerations,
                          #configmaps=configmaps,
                          dag=dag
                          )
