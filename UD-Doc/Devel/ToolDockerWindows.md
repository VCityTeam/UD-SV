### How to install docker on windows (windows 10 only) : 

1. Installer le sous-système linux :

- Aller dans : Paramètres > Applications et fonctionnalités > Fonctionnalités facultatives > Plus de fonctionnalités Windows.

- Cocher la case **Sous-système Windows pour Linux** et faire 'Ok'

- Redémarrer le pc 

- Mettre à jour le package WSL [ici](https://docs.microsoft.com/en-us/windows/wsl/install-win10)

- Dans le "Microsoft Store", rechercher Ubuntu et télécharger la version souhaité, par défaut 20.04

- Lancer l'application Ubuntu et faire l'installation. 
  <br>
  Si le sous-système Linux est déjà installé, vérifier que Docker n'est pas installé sur la distribution. Sinon, le désinstaller en utilisant la commande 
  `sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli`
  Si Docker reste installé sur le sous-système Linux, désinstaller la version Ubuntu correspondante via le store et le réinstaller.

2. Installer Docker :
  - Install [Docker Desktop](https://hub.docker.com/editions/community/docker-ce-desktop-windows/
  - Une fois installé, vérifier dans "Paramètres > Général" que la case "Use the WSL 2 based Engine" est bien cochée.
  - Vérifier dans la partie "Resources > WSL Integration" que la distribution Linux installée est bien affichée.

3. Recommandation pour l'utilisation de docker : 

- Installer et utiliser [Windows PowerShell](https://docs.microsoft.com/fr-fr/windows/wsl/install-win10) de façon à pouvoir ouvrir le terminal Linux à la demande.

- Ne jamais installer sous le système Linux Docker

- Pour construire des images locales, l'utilisation du terminal Linux semble plus fonctionnelle, notamment pour l'utilisation de "Docker-Compose"

