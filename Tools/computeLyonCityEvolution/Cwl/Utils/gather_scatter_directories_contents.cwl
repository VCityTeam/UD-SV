#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: ExpressionTool

id: "gather_scatter_directories_contents"
# Assume you have a command tool that
#  - creates an output directory named e.g. tool_output_dir and
#  - populates tool_output_dir with its resulting files
# With the help of the "scatter" WorkflowStep you can now apply this command
# tool onto a set of parameter inputs. Let us further assume that when 
# realizing such a scattering you choose to always specify the same name 
# (tool_output_dir in our example) to designate the respective (to each
# scatter step) output directories.
# Now you will still need to gather the resulting files accross the respective
# resulting directories. This is because (under the hood) each scatter step
# places its resulting directories/files within a separated directory
# each of which with a docker related generated name (e.g.
# /tmp/docker_<some_hash_code>).
# This workflow gathers all such files (that is the files encountered in each
# directory produced by the respective scatter steps) and returns a new
# Directory structure (still named tool_output_dir) holding (refering to)
# those files.
# References/inspiration:
#  - https://www.biostars.org/p/240726/
#  - https://github.com/common-workflow-language/cwltool/issues/279

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

