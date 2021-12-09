# [NPM](https://en.wikipedia.org/wiki/Npm_(software)) (Network Package Manager) 

## Installing npm

### Ubuntu
  * Install and update npm

    ```bash
    sudo apt-get install npm    ## Will pull NodeJS
    sudo npm install -g n     
    sudo n latest
    ```

  * References: [how can I update Nodejs](https://askubuntu.com/questions/426750/how-can-i-update-my-nodejs-to-the-latest-version), and [install Ubuntu](http://www.hostingadvice.com/how-to/install-nodejs-ubuntu-14-04/#ubuntu-package-manager)

### Windows
  * Installing from the [installer](https://nodejs.org/en/download/)
  * Installing with the [CLI](https://en.wikipedia.org/wiki/Command-line_interface)

    ```bash
    iex (new-object net.webclient).downstring(‘https://get.scoop.sh’)
    scoop install nodejs
    ```
    
 ### MacOS
 ```bash
 brew install npm
 ```

## Good practices

* Avoid installing packages (i.e. using `npm install`) outside of npm hierarchies (places where no `package.json` is present).
  Otherwise this will install the package in your homedirectory which might provoke later collisions.
* In case of trouble clear your npm cache (refer below)   

## Task: switch npm version
Once npm is installed, swsitching npm version can be done with npm itself e.g.
```bash
npm install -g npm@6.14.15
```

In a similar fashion updating (to lastest) nom can be done with

```bash
npm install npm@latest -g
```

Ubuntu note: you might need to sudo e.g. `sudo npm install -g npm@6.14.15`


## Cache related issues

 * List all the [globally installed packages](https://ponderingdeveloper.com/2013/09/03/listing-globally-installed-npm-packages-and-version/):
   `npm list -g --depth=0`

 * Clearing [the cache](https://docs.npmjs.com/troubleshooting/try-clearing-the-npm-cache): `npm cache clean --force`
    Note that the [cache is located in ~/.npm on Posix](https://docs.npmjs.com/cli/cache)

 * List [packages within a directory](https://docs.npmjs.com/cli/ls): `npm ls`
