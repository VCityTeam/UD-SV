## Installing the requirements:
```bash
virtualenv -p python3 venv
source venv/bin/activate
pip3 install cwltool
pip3 install cwlref-runner
```

## Run a single step of split
The following must be run from this current Split directory (that is the directory where this Readme.md is located):
 1. Run Download workflow first (refer to ../Download/Readme.md)
 2. Build the ad-hoc images manually (refer below on why cwltool can't do it for us)
    ```bash
    docker build -t liris:3DUse ../3DUse-DockerContext
    ```
 3. Run of a single step collect
    ```
    (venv) cwl-runner split-single.cwl split-single-inputs.yml
    ```
 4. Loop on a set of inputs a single step collect
    ```
    (venv) cwl-runner foreach-split.cwl foreach-split.yml
    ```

