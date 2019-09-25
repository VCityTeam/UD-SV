#!/usr/bin/env cwl-runner

cwlVersion: v1.0

hints:
  DockerRequirement:
    dockerImageId: liris:3DUse
    dockerFile:
        $include: ../3DUse-DockerContext/Dockerfile

class: CommandLineTool
baseCommand: splitCityGMLBuildings
inputs:
  inputFile:
    type: File
    inputBinding:
      position: 1
      prefix: --input-file
  outputFileName:
    type: string
    inputBinding:
      position: 2
      prefix: --output-file
  outputDirName:
    type: string
    inputBinding:
      position: 3
      prefix: --output-dir

outputs:
  resultsDir:
    type: Directory
    outputBinding:
      glob: $(inputs.outputDirName)
