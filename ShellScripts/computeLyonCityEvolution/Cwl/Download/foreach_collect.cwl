#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  ScatterFeatureRequirement: {}

inputs:
  outputDir:
    type: string
  zipFileName_array: string[]

steps:
  collect:
     run: collect.cwl
     scatter: zipFileName
     in:
       zipFileName: zipFileName_array
       outputDir: $(inputs.outputDir)
     out: []

outputs: []

