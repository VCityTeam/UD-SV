#!/usr/bin/env cwl-runner
  
cwlVersion: v1.0
class: Workflow

requirements:
  SubworkflowFeatureRequirement: {}
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}

inputs:
  outputDirectoryName: string
  ZipFileNames: string[]

steps:
  collect:
    run: Collect/foreach_collect.cwl
    in:
      outputDir:
        valueFrom: 'Collected'
      zipFileName_array: ZipFileNames
    out: [resultsDir]
  organize:
    run: Utils/rename_and_flatten.cwl
    in:
      inputDirectory: collect/resultsDir
      MyMyMyoutputDirectoryName:
        source: outputDirectoryName  # Ref: https://www.biostars.org/p/378279/
        valueFrom: "$(inputs.outputDirectoryName)"
    out: [outputDirectory]
  
outputs:
  outputDirectory:
    type: Directory
    outputSource: organize/outputDirectory
