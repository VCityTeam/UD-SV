### How to install docker on windows (windows 10 only) : 

### 1. Install the linux sub-system:
 - Go to : Panneau de configuration (the old one) > Applications et fonctionnalités > Fonctionnalités facultatives > Plus de fonctionnalités Windows.
 - Check **Sous-système Windows pour Linux** and click on **Ok**
 - Reboot the host 
 - Update the WSL2 package [ici](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
 - In the "Microsoft Store", look for Ubuntu and download the chosen version, 20.04 by default
 - Start the Ubuntu application and install it. 
   <br>
   If the sub-system Linux is already installed, check if Docker is already installed. If it is, uninstall it using : 
   `sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli`
   If you still have trouble with Docker in Ubuntu, uninstall Linux and install it again.

### 2. Install Docker :
 - Install [Docker Desktop](https://hub.docker.com/editions/community/docker-ce-desktop-windows/)
 - Once installed, within "Parameters > General", assert that the "Use the WSL 2 based Engine" checkbox is **checked**.
 - Vérifier dans la partie "Resources > WSL Integration" que la distribution Linux installée est bien affichée.

### 3. Docker usage tips: 
 - Install and use the [Windows PowerShell](https://docs.microsoft.com/fr-fr/windows/wsl/install-win10) which is usefull for opening a Linux based terminal.
 - Never install Docker under the Linux sub-system (e.g. don't use `apt-get` to install docker)
 - Prefer using a linux based terminal to a Windows PowerShell, in order to 
    * build your local images (`docker build ...`), 
    * "Docker-Compose" usages (whose PowerShell usage seems edgy) 

