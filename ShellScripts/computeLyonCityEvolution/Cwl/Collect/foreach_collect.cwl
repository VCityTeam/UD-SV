#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  ScatterFeatureRequirement: {}
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}

inputs:
  outputDir:
    type: string
  zipFileName_array: string[]

steps:
  collect:
     run: collect.cwl
     scatter: zipFileName
     in:
       outputDir:
         source: outputDir      # Refer to https://www.biostars.org/p/378279/
         valueFrom: "$(inputs.outputDir)"
       zipFileName: zipFileName_array
     out: [resultsDir]
  organize:
     run: ../Utils/gather_scatter_directories_contents.cwl
     in: 
       directories: [collect/resultsDir]
     out: [resultDir]
          
outputs:
   resultsDir:
      type: Directory
      outputSource: organize/resultDir

