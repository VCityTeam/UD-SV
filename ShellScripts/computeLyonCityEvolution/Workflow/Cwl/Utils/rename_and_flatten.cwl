#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  SubworkflowFeatureRequirement: {}
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}

id: "list_of_files_to_directory"
# Takes a directory as input and lists the files it witholds. Refer to
# convert_directory_to_list_of_files.cwl for the limitation on the depth
# of sub-directories explored.
# Then "creates" the directory with the provided name and places the
# extracted files within it.

inputs:
  inputDirectory: Directory
  outputDirectoryName: string

steps:
  list_files:
    run: convert_directory_to_list_of_files.cwl
    in:
      directory: inputDirectory
    out: [outputFiles]
  files_to_directory:
    run: list_of_files_to_directory.cwl
    in:
      files: list_files/outputFiles
      directoryName:
        source: outputDirectoryName  # Ref: https://www.biostars.org/p/378279/
        valueFrom: "$(inputs.outputDirectoryName)"
    out: [outputDirectory]

outputs:
  outputDirectory:
    type: Directory
    outputSource: files_to_directory/outputDirectory

