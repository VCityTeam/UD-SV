#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  StepInputExpressionRequirement: {}
  SubworkflowFeatureRequirement: {}
  InlineJavascriptRequirement: {}

inputs:
  outputDirName:
    type: string
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
    run: Utils/convert_directory_to_list_of_files.cwl
    in:
      directory: collect/resultsDir
    out: [outputFiles]
  split:
    run: Split/foreach-split.cwl
    in: 
      inputFiles: organize/outputFiles
      outputDirName:
        source: outputDirName   # Refer to https://www.biostars.org/p/378279/
        valueFrom: "$(inputs.outputDirName)"
    out: [resultDir]
          
outputs:
   resultDir:
      type: Directory
      outputSource: split/resultDir

