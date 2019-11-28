#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  ScatterFeatureRequirement: {}
  StepInputExpressionRequirement: {}

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
  merge:
     ## List all the resulting directories (oddly enough only the commands
     # gets captured by the standard output as opposed to the result of the
     # commands) 
     scatter: directory
     in: 
       directory: [collect/resultsDir]
     out: []
     run:
       class: CommandLineTool
       baseCommand: ["ls", "-R"]
       inputs:
         directory:
           type: Directory
           inputBinding:
             position: 1
       outputs:
         junko:
           type: stdout

outputs: []
