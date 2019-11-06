#!/usr/bin/env cwl-runner

cwlVersion: v1.0

hints:
  DockerRequirement:
    dockerImageId: liris:3DUse
    dockerFile:
        $include: ../3DUse-DockerContext/Dockerfile

class: CommandLineTool
baseCommand: extractBuildingDates
inputs:
  first-date:
    type: string
    inputBinding:
      position: 1
      prefix: --first_date
  first-file:
    type: string
    inputBinding:
      position: 2
      prefix: --first_file
  second-date:
    type: string
    inputBinding:
      position: 3
      prefix: --second_date
  second-file:
    type: string
    inputBinding:
      position: 4
      prefix: --second_file
  outputDirName:
    type: string
    inputBinding:
      position: 5
      prefix: --output_dir

outputs:
  resultsDir:
    type: Directory
    outputBinding:
      glob: $(inputs.outputDirName)
