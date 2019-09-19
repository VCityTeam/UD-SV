#!/usr/bin/env cwl-runner

cwlVersion: v1.0

hints:
  DockerRequirement:
    dockerPull: liris:collect_lyon_data

class: CommandLineTool

baseCommand:

inputs:
  zipFileName:
    type: string
    inputBinding:
      position: 1
  outputDir:
    type: string
    inputBinding:
      position: 2

outputs:
  resultsDir:
    type: Directory
    outputBinding:
      glob: $(inputs.outputDir)
