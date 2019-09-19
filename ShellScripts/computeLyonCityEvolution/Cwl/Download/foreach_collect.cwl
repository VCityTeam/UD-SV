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
  # Place all the results held in the above list of directories within a
  # single directory.
  # The following references where mandatory inspirational sources for the
  # the following CWL organize way of doing things:
  #   - https://www.biostars.org/p/240726/
  #   - https://github.com/common-workflow-language/cwltool/issues/279
  organize:
     in: 
       directories: [collect/resultsDir]
     run:
       class: ExpressionTool
       id: "organize"
       inputs:
         directories: Directory[]
       outputs:
         resultDir:
           type: Directory
       expression: |
         ${
            var resultDir = { "class": "Directory", 
                              "basename": "foreach_collect_failed",
                              "listing": [] };
            var num_directories = inputs.directories.length;
            if(num_directories < 1) {
               return {"resultDir": resultDir};
            }
            // In the following iteration, we could use a [...].concat(dir) (as 
            // opposed to [...].concat(dir.listing)) we would have an output.
            // But the collect stage placed its output (files/sub-directories)
            // results within a directory named as the CWL variable 
            // inputs/outputDir (this was to respect collect.cwl that does
            // so in order not to polute the invocation directory with gobs
            // of files/sub-directories). Since we don not want the collected
            // output files to end up twice nested in outputDir (that is a
            // directory tree of the form outputDir/outputDir/<output files>)
            // we must "strip" dir (the variable named dir below) on the fly
            // and hence use dir.listing (the content of dir instead of dir).

            // First we retrieve the name of the created output directory
            // ( and note that we cannot use "inputs.outputDir" because that
            // variable is alas not available in this scope... :( )
            resultDir.basename = inputs.directories[0].basename;
            for (var i = 0; i < inputs.directories.length; i++) {
              var dir = inputs.directories[i];
              resultDir.listing = resultDir.listing.concat(dir.listing);
            }
            return {"resultDir": resultDir};
          }
     out: [resultDir]
          
outputs:
   resultsDir:
      type: Directory
      outputSource: organize/resultDir

