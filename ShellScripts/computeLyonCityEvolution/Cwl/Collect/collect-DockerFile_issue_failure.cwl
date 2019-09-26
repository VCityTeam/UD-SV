#!/usr/bin/env cwl-runner

cwlVersion: v1.0

hints:
  DockerRequirement:
    dockerImageId: liris:collect_lyon_data
    dockerFile:
        $include: DockerContext/Dockerfile

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
  outputDir:
    type: Directory
    outputBinding:
      glob: $(inputs.outputDir)
