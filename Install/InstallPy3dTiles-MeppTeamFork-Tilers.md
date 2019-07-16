## Installation notes of Py3dTiles Tilers (out of Py3dTiles RICT's fork)



````
# Install pre-requisite tools (remove the sudos if you wish 
# to install in `$(HOME)/.local/...`)
sudo apt-get install python3
sudo apt-get install python3-pip
sudo pip3 install virtualenv

# Check out the ad-hoc branch of the fork:
git clone https://github.com/MEPP-team/py3dtiles.git
cd py3dtiles
git checkout 3dtiles-temporal-v2

# Deploy a virtual environment (this optional step is only useful 
# if you do not want to interfere with other Python package installs)
virtualenv -p python3 venv
source venv/bin/activate

# Install Py3dTiles python package dependencies:
pip install -e .
python setup.py install

# Install the Tilers specific dependencies
pip install pyyaml
````

Eventually you will then need to:
 * configure a `Tilers/CityTiler/CityTilerDBConfig.yml` (out of `Tilers/CityTiler/CityTilerDBConfigReference.yml`)
 * invoke the CityTiler with something similar too
   ```
   python Tilers/CityTiler/CityTiler.py --with_BTH Tilers/CityTiler/CityTilerDBConfig.yml 
   ```
   By default this command will create a `junk` ouput directory holding both 
     * the resulting tile set file (with the .json extension) and 
     * a `tiles` folder containing the `.b3dm` files
     
### Developer's not
If you happen to modify the core of py3dtiles (that is any file in the `py3dtiles/py3dtiles/` subdirectory) then prior to running any script using Py3DTiles (e.g. a Tiler or export_tileset) you will need to re-install Py3DTiles for changes to be considered. The commands are then
```
pip uninstall py3dtiles     # Just to avoid pycache trouble
pin install ./py3dtiles     # Equivalent of `pip install -e .`
``` 

