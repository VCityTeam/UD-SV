FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXMEIXME FIXME FIXME FIXME

This is a raw copy of some expe-data script that requires some serious editing
to be adapted to computLyonCityEvolutin...

FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXME FIXMEIXME FIXME FIXME FIXME


import cwltool.factory
import cwltool.context
import re
import yaml
import json
import os

input = yaml.load(open("logs-analyzer-input.yaml", "r"), Loader=yaml.FullLoader)

# Input files are specified with a "path" attribute when in yaml. Yet
# when in python this same attribute becomes "location" (refer to
# https://github.com/common-workflow-language/cwltool/issues/828 ). We thus
# need to (dirty) fix the yaml-parsed input:
for unused, file_param in input.items():
  if isinstance(file_param, dict):
    if 'class' in file_param and file_param['class'] == 'File':
      file_param['location'] = file_param['path']

# Specify the output directory as being the current working directory:
runtime_context = cwltool.context.RuntimeContext()
runtime_context.outdir = os.getcwd()

# Loading the workflow with the help of an ad-hoc factory:
fac = cwltool.factory.Factory(runtime_context=runtime_context)
logana = fac.make("logs-analyzer-with-docker.cwl")
print(logana)
output_dir = os.path.dirname(os.path.realpath(__file__))

# Executing the workflow with the input we parsed:
result = logana(**input) 

print( json.dumps(result, sort_keys=True, indent=4) )

