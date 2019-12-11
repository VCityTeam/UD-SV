#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: ExpressionTool

id: "list_of_files_to_directory"
# Takes a list of files and a directory name and "creates" the directory
# with that given name and places the provided files within it.

inputs:
  files: File[]
  directoryName: string

outputs:
  outputDirectory:
    type: Directory

expression: |
  ${
     var outputDirectory = { "class": "Directory",
                             "basename": inputs.directoryName,
                             "listing": inputs.files };

     return {"outputDirectory": outputDirectory};
   }
