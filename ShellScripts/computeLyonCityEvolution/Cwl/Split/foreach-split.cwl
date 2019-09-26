#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}
  StepInputExpressionRequirement: {}

inputs:
  inputFiles: File[]
  outputDirName: string
    
steps:
  loop:
    run: split-single.cwl
    scatter: inputFile
    in:
      inputFile: inputFiles
      outputFileName:
        # Refer to https://www.biostars.org/p/234804/
        valueFrom: ${ return "Split_" + inputs.inputFile.basename; }
      outputDirName:
        source: outputDirName
        valueFrom: "$(inputs.outputDirName)"
    out: [resultsDir]
  gather:
    run: ../Utils/gather_scatter_directories_contents.cwl
    in: 
      directories: [loop/resultsDir]
    out: [resultDir]
    

outputs:
  resultDir:
    type: Directory
    outputSource: gather/resultDir
