#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  StepInputExpressionRequirement: {}
  SubworkflowFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}
  InlineJavascriptRequirement: {}

inputs:
  outputDir:
    type: string
  2009ZipFileNames: string[]
  2012ZipFileNames: string[]
  2015ZipFileNames: string[]

steps:
  2009collect:
     run: foreach_collect_and_split.cwl
     in:
       outputDirName:
         valueFrom: 'junk-split'
       ZipFileNames: 2009ZipFileNames
     out: [resultDir]
  2012collect:
     run: foreach_collect_and_split.cwl
     in:
       outputDirName:
         valueFrom: 'junk-split'
       ZipFileNames: 2012ZipFileNames
     out: [resultDir]
  2015collect:
     # 2015 files are already split
     run: Collect/foreach_collect.cwl
     in:
       outputDir:
         valueFrom: 'junk-split'
       zipFileName_array: 2015ZipFileNames
     out: [resultsDir]
  organize:
     run: Utils/gather_scatter_directories_contents.cwl
     in: 
       directories:
         source: [2009collect/resultDir, 2012collect/resultDir, 2015collect/resultsDir]
         # linkMerge (merge_flattened or merge_nested) is not relevant here
         # because gather_scatter_directories_contents.cwl takes a Directory[]
         # as input !?
     out: [resultDir]
          
outputs:
   resultsDir:
      type: Directory
      outputSource: organize/resultDir

