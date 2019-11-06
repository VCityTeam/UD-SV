#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: ExpressionTool

id: "convert_directory_to_list_of_files"
# Return the list of files encountered in the input directory as well
# as the files encountered in its direct sub-directories (but not further
# that is not the possible sub-sub-directories...)
# Warning:
#  - this command does NOT return the possible sub-directories but only
#    files contained within
#  - this command only returns the directory files and its possible 
#    sub-directory files. But it does NOT recurse any further.

inputs:
  directory: Directory

outputs:
  outputFiles:
     type: File[]

expression: |
  ${
     // We cannot return directory.listing because we need to 
     // weed out the possible sub-directories
     var outputFiles = [];
     if( ! inputs.directory.class == "Directory" ) {
       // Input was not a directory: return empty list
       return {"outputFiles": outputFiles};
     }

     var dir_entries = inputs.directory.listing;
     for (var i = 0; i < dir_entries.length; i++) {
       var entry = dir_entries[i];
       if( entry.class == "Directory" ) {
         // Possible sub-directories files are added (note that is also
         // adds the possible sub-sub-directories that shall need to remove)
         outputFiles = outputFiles.concat(entry.listing);
       } else {
         outputFiles = outputFiles.concat(entry);
       }
     }

     // Remove the possible sub-sub-directories that were possibly added
     // at previous stage
     for (var i = 0; i < outputFiles.length; i++) {
       var entry = outputFiles[i];
       if( entry.class == "Directory" ) {
         outputFiles.splice(i, 1);
         i = i-1;    // The array is shorter because modified on the fly !?!
       }
     }

     return {"outputFiles": outputFiles};
   }

