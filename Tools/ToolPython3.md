
## Installing python packages: pip and setup.py
 * `pip` uses the `setup.py` package file (setuptools) and is the prefered (as of 2021)
    way of installing python packages 
 * `pip install -e`: [when to use it](https://stackoverflow.com/questions/42609943/what-is-the-use-case-for-pip-install-e)
 * `pip install -r`: [when is the requirements.txt used](https://packaging.python.org/discussions/install-requires-vs-requirements/#requirements-files)
 * Adding custom steps to a `setup.py` installation process:
   - [Run custom code in setup.py](https://blog.niteo.co/setuptools-run-custom-code-in-setup-py/)
   - [pip and cmd_class](https://stackoverflow.com/questions/19569557/pip-not-picking-up-a-custom-install-cmdclass)
 * The `MANIFEST.in` file is usually [not needed anymore](https://stackoverflow.com/questions/24727709/do-python-projects-need-a-manifest-in-and-what-should-be-in-it)
 * Preventing setup.py from installing as an egg
   - when using pip to install a package from its sources that located in e.g. the current
     directory, one can use `pip install -r .`. Within pip recent versions (say above 20.X) 
     this installs an egg-link file in your `site_packages/` python directory that refers to
     the current directory (as opposed to copying the `*.py` (package files) of the package
     you are working on in `site_packages/`). This makes it harder to understand if the
     package is correct.
   - in order to [circumvent this egg usage](https://stackoverflow.com/a/27175492/5649243) generate
     a tar ball of the package and then install that tar ball with e.g.
     ```bash
     pushd /path/to/my/package/ 
     python setup.py sdist 
     popd 
     pip install /path/to/my/package/dist/package-1.0.tar.gz
     ```
