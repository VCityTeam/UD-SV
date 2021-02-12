### How to install docker on windows (windows 10 only) : 

### 1. Install the linux sub-system:
 - Aller dans : Paramètres > Applications et fonctionnalités > Fonctionnalités facultatives > Plus de fonctionnalités Windows.
 - Cocher la case **Sous-système Windows pour Linux** et faire 'Ok'
 - Reboost the host 
 - Mettre à jour le package WSL [ici](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
 - Dans le "Microsoft Store", rechercher Ubuntu et télécharger la version souhaité, par défaut 20.04
 - Lancer l'application Ubuntu et faire l'installation. 
   <br>
   Si le sous-système Linux est déjà installé, vérifier que Docker n'est pas installé sur la distribution. Sinon, le désinstaller en utilisant la commande 
   `sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli`
   Si Docker reste installé sur le sous-système Linux, désinstaller la version Ubuntu correspondante via le store et le réinstaller.

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

