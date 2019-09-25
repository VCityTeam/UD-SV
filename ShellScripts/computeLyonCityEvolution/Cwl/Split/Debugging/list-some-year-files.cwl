#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: ExpressionTool
id: "split_on_regexp"

requirements:
  InlineJavascriptRequirement: {}
  StepInputExpressionRequirement: {}

inputs:
  inputDir:
    type: Directory

outputs:
  toBeSplitFiles:
    type: File[]
  notToBeSplitFiles:
    type: File[]

expression: |
  ${
     // Use a pattern matching criteria to build two subsets of files
     // covering the input directory
     // General note for expression based spliting (if substitute) 
     // workflows: refrain from "recycling the input"
     // The intent of the expression is to produce two sub-set outupts that
     // constitute a covering sub-division of the input:
     //   - one sub-set holds the elements of the input satisfying
     //     the decision criteria and
     //   - a second one the holding the rest of the input elements that 
     //     is the elements NOT satisfying criteria.
     // In doing so it might feel tempting to "recylce" the input variable
     // e.g. by weeding out (using the decision criterai) from non fitted
     // elements and returning that result as the first sub-set of the
     // output. Yet we probably should not tamper with the incoming
     // argument since that variable might be used elsewhere by the
     // cwl interpreter.
     // Alas making a deep copy of that incoming argument is not that
     // trivial in JavaScript specially when in the cwltool interpreting
     // context (refer e.g. to approaches like the ones of 
     //  https://www.codementor.io/ramnmiklus/deep-copying-an-object-in-javascript-mdlj2c318
     // or
     //  https://stackoverflow.com/questions/28876300/deep-copying-array-of-nested-objects-in-javascript
     // We thus need to manually copy things to the output...
     //
     // The incoming directory holds sub-directories (each orginial burrough)
     // that themselves hold a set of cityGML files. 
     var    toBeSplitFiles = []
     var notToBeSplitFiles = []
     var num_sub_directories = inputs.inputDir.listing.length;
     if(num_sub_directories < 1) {
        return {    "toBeSplitFiles":    toBeSplitFiles,
                 "notToBeSplitFiles": notToBeSplitFiles};
     }

     for (var i = 0; i < num_sub_directories; i++) {
       var dir = inputs.inputDir.listing[i];
       var num_subdir_files = dir.listing.length;
       for (var j = 0; j < num_subdir_files; j++) {
         var file = dir.listing[j];
         if( ! file.basename.match( /\.gml/ ) ) {
           console.log("Dropping non cityGML file: ", file.basename);
           continue;
         }
         console.log("Considering file: ", file.basename);
         // We can now apply our criteria
         if( file.basename.match( /.*BATI.*2015.*/ ) ) {
           notToBeSplitFiles.push(file);
           console.log("NOT to be split file: ", file.basename);
           continue;
         }
         if( file.basename.match( /.*BATI.*/ ) ) {
           toBeSplitFiles.push(file);
           console.log("TO BE split file: ", file.basename);
           continue;
         }
         console.log("Dropping file: ", file.basename);
       }
     }
     return {    "toBeSplitFiles":    toBeSplitFiles,
              "notToBeSplitFiles": notToBeSplitFiles};
   }
