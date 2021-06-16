When working on markdown documentation you might need to assert that the
Markdown links and image references to local files and headings are valid.

The [remark-validate-links](https://github.com/remarkjs/remark-validate-links) might be a simple worse considering tool.
For the impatient:
```
cd <your_git_repo>
npm install remark-validate-links
npm install --global remark-cli remark-validate-links
remark -u validate-links .
```
Note that running the CLI commands requires git to be installed and in Windows PowerShell may require [running scripts to be enabled](https://thecodemon.com/resolved-npmng-ps1-cannot-be-loaded-because-running-scripts-is-disabled-on-this-system/).
