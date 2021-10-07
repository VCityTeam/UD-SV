
## Concerning the native installation
The native (as opposed to containerized) [installion of version2.3](https://docs.bigbluebutton.org/2.3/install.html#install) has some **important** [pre-install checks](https://docs.bigbluebutton.org/2.3/install.html#pre-installation-checks). They are important checks because if you miss one of them you might lose a lot of time down the road. Among those **important** checks

* Do `sudo systemctl show-environment` and ensure that `LANG=en_US.UTF-8` is part of the output
* assert that the server has Ubuntu version 18.04 (with e.g. `lsb_release -a`)
* assert the OS is 64 bits (with `uname -m` answering `x86_64`)
* check that your server is running Linux kernel 4.x. (with `uname -r` answering e.g. `4.15.0-NNN-generic`)
* Uninstall the apt packages of nodejs (as advised for [any late version of Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-20-04)) with `sudo apt-get purge nodejs`
* Re-install nodejs version 12 "cleanly"
  ```bash
  curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh
  bash nodesource_setup.sh
  apt install nodejs
  nodejs --version        # should anser 12.22.6...
  ```
  Also assert that `apt-cache madison nodejs` (this is the [command used by the bbb-install.sh](https://github.com/bigbluebutton/bbb-install/blob/master/bbb-install.sh#L251) mentions version 12.
* Manully [remove the `apache2-bin` package](https://github.com/bigbluebutton/bbb-install/blob/master/bbb-install.sh#L597) with 
  ```bash
  sudo systemctl stop apache2
  sudo apt-get purge apache2-bin
  ```
* Eventually some nice to have cleanup
  ```bash
  sudo apt-get autoremove
  ```

### Possible things to check 
* If you do not have IPV6 support (`ip addr | grep inet6` does NOT mention `inet6 ::1/128 scope host`) then you **might** need to
  - suppress IPV6 support in the nginx configuration file `/etc/nginx/sites-enabled/default` (otherwise you will get an [](https://techglimpse.com/nginx-error-address-family-solution/)

Because IVP6 is not supported (if you do not see the line inet6 ::1/128
 scope host) then after you install BigBlueButton you will need to modify the configuration for FreeSWITCH to 
disable support for IPV6.


## Concerning the docker installation
Refer to [this issue](https://github.com/bigbluebutton/greenlight/issues/2071)
