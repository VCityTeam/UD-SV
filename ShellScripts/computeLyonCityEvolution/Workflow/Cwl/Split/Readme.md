## Installing the requirements:
1. Build the ad-hoc docker image<br>
   Refer to [this installation section of the Docker/Readme.md](../../Docker/Readme.md#Installation)<br>
   Note: refer below on why cwltool can't do it for us !
2. Build the python environment 
   ```bash
   virtualenv -p python3 venv
   source venv/bin/activate
   pip3 install cwltool
   pip3 install cwlref-runner
   ```

## Run a single step of split
The following must be run from this current Split directory (that is the directory where this Readme.md is located):
 1. Run Collect workflow first (refer to ../Collect/Readme.md)
 1. Run of a single step collect
    ```
    (venv) cwl-runner split-single.cwl split-single-inputs.yml
    ```
 1. Loop on a set of inputs a single step collect
    ```
    (venv) cwl-runner foreach-split.cwl foreach-split.yml
    ```

