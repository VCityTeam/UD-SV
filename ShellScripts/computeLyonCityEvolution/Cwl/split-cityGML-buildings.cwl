#!/usr/bin/env cwl-runner

cwlVersion: v1.0

hints:
  DockerRequirement:
    dockerImageId: vcity/3duse
    dockerFile:
        $include: 3DUse-DockerContext/Dockerfile

class: CommandLineTool
baseCommand: 3DUSE/Build/src/utils/splitCityGMLBuildings
inputs:
  input_file:
    type: File
    inputBinding:
      position: 1
      prefix: --input_file
  output_file:
    type: File
    inputBinding:
      position: 2
      prefix: --output_file
  output_dir:
    type: string
    inputBinding:
      position: 3
      prefix: --output-dir

outputs:
  output_file:
    type: File
    outputBinding:
      glob: $(inputs.output_file)
