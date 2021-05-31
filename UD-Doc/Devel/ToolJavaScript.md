1 - C’est quoi le javascript ?


Langage de script non typé => pas de compilation, interprété à la volée


A la base créé pour gérer l’aspect dynamique du html => performance toute pourrie


Date ? Création de moteur javascript qui optimise l'exécution de celui-ci (https://www.youtube.com/watch?v=PsDqH_RKvyc). Lorsque le moteur passe une première fois dans un morceau de code il tente de l’optimiser, par exemple si une string est stockée dans une variable il va présumer que la variable contient une string et optimiser la mémoire. Par contre si plus tard dans le code cette même variable contient un entier alors le moteur va devoir annuler l’optimisation ce qui engendre une perte de performance. D'où l'importance de ne pas faire n’importe quoi !


A noter que le langage évolue actuellement ES6 (standard ECMAScript) mais cette dernière version n’est pas forcément supportée par tous les navigateurs (e.g. IE) ou par nodejs (pas de support ES6 non plus). Babel (qui est un paquet npm) permet de régler ces problèmes de compatibilité (par exemple en “transpilant” ES6 vers ES5).

Notes sur le langage JS
* La bonne référence pour le JS est le site de Mozilla https://developer.mozilla.org/fr/
* JS est garbage collecté : 
   * attention à anticiper des effets pervers sur l’usage de la mémoire
   * éviter de faire des new
   * chaque navigateur à son garbage collector et donc les fonctionnements ne sont pas universels FIXME a vérifier
* La closure (e.g. captation du contexte de définition d’une fonction importé dans la fonction) est un mécanisme puissant mais qui a des effets de bords sur la mémoire
* Promise : les promesses permettent de gérer l’asynchronisme
2 - Du coup c’est quoi nodejs ?


Date ? Du coup les navigateurs (qui se respectent, mille million de mille sabord !) embarquent un moteur qui optimise du javascript. En gros si on enlève toute la partie graphique (window, document, DOM, html, css) + d’autres choses que gère un navigateur et qu’il nous reste en fait le moteur et qu’on y ajoute quelques trucs genre un truc qui permet de lire des fichiers etc.. et bien on a nodejs !


Plus précisément nodejs c’est une techno basée sur le moteur de chrome (V8) qui permet d'exécuter du javascript pas dans un navigateur mais sur le bureau !


3 - le petit dernier npm !


Nodejs permet donc de réaliser des applications bureau en javascript. Du coup pourquoi ne pas faire une application bureau qui permettrait de gérer un système de paquets javascript hein ?!
Le process classique consiste donc à installer nodejs qui permet à son tour d’installer npm (node package manager) qui lui va gérer l’importation/installation/publication de tous les paquets javascripts !


4 - et donc voila ud-viz


Ud-viz c’est un paquet npm, mais plus précisément c’est une bibliothèque. C’est à dire que quand elle est publiée sous les repos npm ce sont les fichiers des sources qui sont publiés/exportés alors que l’on pourrait publier/exporter un bundle par exemple (utilisé dans une app web en gros). On choisit d’exposer les sources aux utilisateurs du paquet. D’ou coup ya pas d’application dans ud-viz c’est du code qui sert à en fabriquer !


5 - Le cycle de travail: usages de npm


git clone https://github.com/VCityTeam/UD-Viz
cd UD-Viz
npm --version
* npm est la commande qui va permettre de gérer tout le cycle de travail
* npm s’appuie sur le fichier package.json qui va lui servir de point d’entrée
* Le fichier package.json définit des “scripts” qui sont des cibles (penser à make) que l’on peut utiliser avec la commande nom run <nom_du_script>.
npm i
* Commande raccourci pour “npm install”
* Utilise le fichier package.json pour les entrées “dependencies”, “devDependencies” et “peerDependencies” pour gérer/installer les dépendances
* npm install  gère récursivement les dépendances des packages, sous-packages...
* Il est hélas “normal/usuel/courant/banal” d’avoir des warnings pour le “npm install”
npm run build 
* Réalise le build de la librairie en standalone i.e. un unique fichier javascript qui regroupe l’ensemble de l’application et qui sera servi à un client web
* Cette étape de build s’appuie en général sur l’utilitaire webpack (qui est donc une devDependancy du projet) :
   * webpack est lui même configuré par le fichier webpack.config.json  
   * webpack est lui-même modulaire. Par exemple pour loader/packer un fichier css webpack va utiliser css-loader
   * webpack va parcourir récursivement le code (à partir du fichier donné en point d’entrée) et injecte le code rencontré
   * A son tour webpack peut utiliser d’autres utilitaires comme Babel qui se charge de transpiler le code (ES6 vers ES5, pour par exemple offrir le mot clef class), minifier le code (i.e. enlever tout le code dans lequel l’application ne passe pas)
* nodemon


npm run debug
* Utilise nodemon pour watcher source (surveiller les modifications dans un cycle de développement) et relance automatiquement un rebuild de l’application
npm run build-debug
*  Build the standalone librairie en debug i.e.
npm run test 
* Déclenche les tests (utilisés e.g. dans Travis CI)




6 - ya quoi dans la bête ?


Bin => contient des exe nodejs utile pour décrire une routine de debug voir nodemon
Dist => where are builded locally standalone
Doc => cqfd
Src => sources publish on npm package
Package.json => description du paquet ud-viz, on peut voir les scripts npm, les dépendances etc
Webpack.config.js => lorsque que l’on build (souvent lorsque l’on veut créer une application web) il faut un programme qui parse le code et injecte le code des paquets (require de l’ES5 / import de l’ES6), de plus il faut pas qu’il re importe un paquet déjà injecté (système de cache). En gros on tape une entrée ici src/ (par défaut webpack pointera sur index.js dans src/) il parse tout le code et le pack pour faire du web ! On peut rajouter d’autres opérations a ce pipeline comme la “minification” ou la “transpilation” (babel) !


7 - Coding


Utiliser un flux de travail (git workflow) 
* à base de fork (au début) ou de branches 


Coding style
* Ne pas utiliser de variable globale et donc ne pas utiliser le pattern singleton
* Fixer le type d’une variable i.e. il est réprouvable de changer le type d’une variable au cours de l'exécution
* Toujours préférer la déclaration const à let à var (pour définir une variable)
* Bien mettre de la sémantique dans les noms des variables e.g. le nom d’une variable privée est pré-fixée par un _ (underscore)
* Eviter les new au maximum pour la GC
* Passer par des getters et des setters (par opposition à accéder directement à un membre) i.e. respecter l’encapsulation
Lazy import
