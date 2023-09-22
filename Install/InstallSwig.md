# Install Guide of [SWIG](https://www.swig.org/)

## Getting Started
For more information about SWIG or C++ wrapping, refer to [this tool page](../Tools/ToolSwig.md).  
  
⚠️ In this tutorial, we'll be installing SWIG 4.0. Feel free to adapt it to your own use cases.

### For Linux
1. Install SWIG 4.0
```
apt-get install swig4.0
ln -s /usr/bin/swig4.0 /usr/bin/swig
```

2. Check your swig version :
```
swig -version
```
If the process was successful, you will see your swig version.  
If not, you can consult the [SWIG manual](https://www.swig.org/Doc4.0/SWIGDocumentation.html#Preface_installation) for further instructions.


### For Mac OS

#### Install with brew
```bash
brew install swig    # installs version 4.1.X at this date
```

#### Install from sources

1. Download SWIG for Mac OS from SWIG [Download Page](https://sourceforge.net/projects/swig/files/swig/swig-4.0.2/). Unzip the files after downloading.

2. Download a "pcre-10.42.tar.bz2" of [Perl Compatible Regular Expressions](https://www.pcre.org/) or PCRE [here](https://github.com/PCRE2Project/pcre2/releases).

3. Remove the .bz2 extension of the pcre file then put it into the SWIG root folder.

4. Run the following commands under the SWIG folder:
   ```bash
   ./Tools/pcre-build.sh
   ./autogen.sh
   ./configure
   make
   sudo make install
   ```

#### Post install check

Open a terminal and check your swig version :
   ```bash
   swig -version
   ```
If the process was successful, you will see your swig version.  
If not, you can consult the [SWIG manual](https://www.swig.org/Doc4.0/SWIGDocumentation.html#Preface_installation) for further instructions.


### For Windows
1. Download SWIG for Windows from SWIG [Download Page](https://sourceforge.net/projects/swig/files/swigwin/swigwin-4.0.2/). Unzip the files after downloading.

2. Add the SWIG folder in your system environments variables in Path.

3. Open a terminal and check your swig version :
```
swig -version
```
If the process was successful, you will see your swig version.  
If not, you can consult the [SWIG manual](https://www.swig.org/Doc4.0/SWIGDocumentation.pdf#file%3A///home/william/swig/github/swig/Doc/Manual/SWIGDocumentation.html%23Windows) for further instructions.


## Credits
- [SWIG Installation Guide](https://open-box.readthedocs.io/en/latest/installation/install_swig.html)
