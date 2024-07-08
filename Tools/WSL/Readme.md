## WSL *(Windows Subsystem for Linux)*
WLS est un outil permettant à un utilisateur **Windows** de disposer d'une distribution **Linux** directement en ligne de commande; et même de se servir d'outil Windows pour travailler dessus.

## Installation 
1. Ouvrez un **Powershell** en mode **Administrateur** et exécutez `wsl --install`
2. **Redémarrez** votre ordinateur pour finaliser l'installation
3. Un terminal ubuntu s'ouvre, vous rentrez les informations de votre session.
4. Votre WSL est prêt !

## Changer de Version
1. Ouvrez un **Powershell** en mode **Administrateur**
2. Exécutez `wsl -l -o` pour voir toute les distributions à votre disposition
3. Vous pouvez ensuite exécuter `wsl --install -d <NomDistribution>` pour choisir la distribution de votre **Linux**. *(Par défaut, c'est donc un Ubuntu)

## Utiliser facilement le WSL
Je vous conseille de vous servir de l'application **Terminal**, que vous pouvez paramétrer pour ouvrir par défaut le terminal **Ubuntu** *(ou autre selon votre didtribution de Linux)*

## Utiliser VSC dans notre WSL
Visual Studio Code (VSC) est conçu pour pouvoir fonctionner avec WSC, et voici comment :

1. Verifiez que vous possédez bien un VSC Windows sur votre machine.
2. Il vous suffit de taper `code .` dans votre terminal ubuntu pour ouvrir le dossier dans votre VSC, et vous pouvez ensuite travailler dedans sans aucune autrre manipulation.
