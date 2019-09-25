## Running on the local (tiny and fake) input directory
```
cwl-runner --js-console list-some-year-files.cwl list-some-year-files-input.yml
```
For some reason the files that are part of the output seem to be copied
in the current working directory. Remove them
```
\rm *.gml
```

## Running on a real Download output directory
In case you already ran the `../Download/foreach_collect.cwl` example you might try running the workflow on its output:
```
cwl-runner --js-console list-some-year-files.cwl list-some-year-files-Download-input.yml
```
and then do clean up as above
```
\rm *.gml
```
