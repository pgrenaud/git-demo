# Git Demo

## Intro

### Motivations

Pourquoi une démo sur Git?

J'ai vu beaucoup trop de fois des developpeurs (collègues/étudiants) qui n'avaient aucune idée de ce qu'ils faisaient
avec git. Pour bien des choses, je peux comprendre que vous ne voulez pas vous cassez la tête et vous voulez juste que
ça marche. Mais git, c'est l'une des choses que vous devez comprendre. Vous devez savoir comment ça fonctionne et
comment l'utiliser. C'est votre responsabilité en tant que developpeur d'apprendre à utiliser cette outils formadable
et essentiel à votre travail.

### Git vs SVN

Git est un système de gestion de code source (source code management system).

> Qui a déjà utiliser Dropbox ou Google Drive pour partager du code?

> Quelles sont les principales différences entre Git et SVN? On cherche 4 éléments.

SVN:

* Centralisé (remote seulement)
* Stockage avec des delta
* Versionnement par numérotation

Git:

* Distribué (local et remote)
* Stockage avec des snapshots
* Versionnement par checksum (+intégrité)
* Zone d'index (staging area)

## Basics

### Staging area

La zone d'index (staging area) est l'où on stock l'état des fichiers qui composeront le prochain commit.

> Quels sont les différents états dans lequel un fichier peut se trouver? On cherche 4 états.

Un fichier peut être dans l'un de ces 4 états:

* Non-suivis (untracked)
* Inchangés (unmodified)
* Modifiés (modified)
* Indexés (staged)

> Figure #1

1. Ajouter le fichier
2. Commit le fichier
3. Modifier le fichier
4. Indexer le fichier
5. Commit le fichier
6. Effacer le fichier

### Commit

Un instantané (commit) est un ensemble de snapshots de un ou plusieurs fichiés identifiés par un hash `SHA-1`.

> Quelles sont les différentes métadonnées contenues dans un commit? On cherche 4 éléments.

Un commit contient aussi des métadonnées tel que:

* Hash du parent
* Auteur
* Date et heure
* Titre/Message

Gardez en tête qu'un commit et son hash est dépendant de toutes ces informations (toutes les modifications et
métadonnées). Un simple petit changement change le hash complètement.

### Branch

Une branche (branch) est un simple pointeur amovible pointant vers un commit.

La branche `master` est le nom de la branche créé par défaut lors d'un `git init`.

> Figure #2

### HEAD

Le `HEAD` est un pointeur spécial pointant vers la branche actuelle.

> Figure #2 (suite)

### Merge

Lorsque l'historique est séparé, on dit qu'elle a divergé. Il faut donc fusionner pour ramener l'historique en
un seul point.

Fusionner (merge) est le processus qui consiste à incorporer les modifications apportés à une branche dans une autre.

> Figure #3

Merge:

1. La branche `master` pointe au commit `C2`
2. On crée la branche `feature`
3. On bascule (checkout) sur la branche `feature`
4. On commit `C3`
5. On checkout la branche `master`
6. On crée la branche `hotfix`
7. On checkout la branche `hotfix`
8. On commit `C4`
9. On checkout la branche `master`
10. On merge la branche `hotfix` (fast-forward)
11. On checkout la branche `feature`
12. On commit `C5`
13. On checkout la branche `master`
14. On merge la branche `feature` (commit `C6`)

### Rebase

Rebaser (rebase) est le processus qui consiste à prendre les modifications apportés à une branche et les rejouer
dans une autre.

> Figure #4

Merge:

1. La branche `master` pointe au commit `C2`
2. On crée la branche `feature`
3. On commit `C3`
4. On checkout la branche `feature`
5. On commit `C4`
6. On checkout la branche `master`
7. On merge la branche `feature` (commit `C5`)

Rebase:

1. La branche `master` pointe au commit `C2`
2. On crée la branche `feature`
3. On commit `C3`
4. On checkout la branche `feature`
5. On commit `C4`
6. On rebase la branche `master`
7. On checkout la branche `master`
8. On merge la branche `feature` (fast-forward)

### Remote

Toutes les opérations effectuées jusqu'à maintenant étaient locales.

Les références distantes (remote references) sont des références (pointeurs) vers des éléments de dépôts distants.
Les branches distantes (remote branches) sont des références (pointeurs) vers l’état des branches de dépôts distants.

Le remote `origin` est le nom du remote créé par défaut lors d'un `git clone`.

> Figure #5

Origin:

1. La branche `master` pointe au commit `C2`
2. Les commits `C3` et `C4` sont ajoutés à `master`
3. Les commits `C5`, `C6` et `C7` sont ajoutés à `master`

Local:

1. La branche `master` et `origin/master` pointe au commit `C2`
2. On commit `C5` et `C6`
3. On récupère (fetch) la branche `origin/master` avec les commits `C3` et `C4`
4. On merge la branche `origin/master` (commit `C7`)
5. On pousse (push) la branche `master` vers `origin`

## Teamwork

### Purpose

Vous travaillez en équipe; vous n'êtes pas seul!
Vous travailler avec vos collègues et non contre eux.

Vous devez donc faire en sorte que votre travaille complète celui de vos collègues et non qu'il aille à l'encontre
de leur travail.

### Warning

Avertissement très important!

**Ne jamais rebase (ou amend) des commits qui existent à l'extérieur de votre repository.**

Lorsque l'on rebase ou amend un commit, son hash `SHA-1` change, ainsi que tous ceux des commits enfants.
Si les commits avait déjà été push auparavant et que quelqu'un les a déjà pull et fait de nouveaux commmits,
vous allez vous ramassez avec de très gros problème (c'est-à-dire avec une historique pêle-mèle).
Même si c'est possible de corriger les problèmes causés par ce genre de situation, c'est tout un casse-tête.

### Formating convention

Aussi futile (peu important) que ça puisse paraître, mettre en place des conventions de code est très important lorsque
l'on travail en équipe. C'est généralement le cas dans tous les projets open source accessible sur github.
Cela va vous évité beaucoup de problème et de perte de temps. Les cas les plus grave que l'on veut évité ici est lorsque
deux personnes commits sous un encodage/format différent dans le même commit, ce qui détruit complètement des diffs.
Vous voulez donc dès maintenant mettre en place des conventions qui seront adoptées unanimement par votre équipe.
Une fois que vous aurez établie ces conventions, il est généralement pertinant de configurer son IDE en conséquence.

Content:

* Encoding
* New line separator
* New line at end of file
* Indent using space or tab
* Column limit
* Trailing whitespaces

### Minimal diff policy

Une des raisons pour laquel vous établissez des conventions de code, c'est pour la politique de diff minimal
(minimal diff policy). Celle-ci consiste à ce que chacun des commits apportent un minimum de changements, ou plutôt,
que chaque commit modifie uniquement ce dont il a besoin de modifier.

**Ne jamais faire de formatage de code dans un commit où l'on apporte des changements de fontionnalités.**

On veut surtout éviter ici qu'il y est des lignes modifié dans votre diff alors que vous n'y avez fait aucun
changement, commme un ajout éroné de whitespace (voir la section précédente).Si jamais vous voyez qu'il y a
un correctif d'indentation à faire par exemple, je vais vous montré plus tard comment faire le changement maintenant
mais le commit séparément.

**C'est pourquoi il est important de toujours consulter le diff avant de faire un commit.**

Prenez toujours le temps de regarder le diff pour voir ce que vous vous apprêté à commit dans le dépôt. C'est rapide
à faire, c'est un très bon moment pour révisé son code et un bon moyen pour déterminer votre message de commit.

### Gitignore

Un des apects qui va dans le même sens que la politique de diff minimal et les conventions de code, c'est de ne pas
commit des fichiers propres à un environement de développement ou à un système spécifique. Par exemple, les fichiers
de configuration de votre IDE, des fichiers généré par votre système d'exploitation ou encore des fichiers caches/logs
généré par votre framework sont tous des choses que vous ne voulez jamais commit et voir dans un dépôt.

Pour prévenir cela, on utilise un fichier spécial nommée `.gitignore`. Dans ce fichier, on y indique tous ce qu'on
veut que git ignore et ne commit pas dans le dépôt. On peut y inscrire des fichiers et répertoire, sous forme relatif
ou absolut, et même utiliser des regex.

Content:

* IDE configurations files
* OS related files
* Framework related local config, caches and logs

### Workflow

Team workflow

Git étant très flexible, vous pouvez y travailler de mille et une façon. Je vais donc vous proposer un workflow.
Libre à vous de l'utiliser, de vous en inspirer ou d'utiliser workflow propre à vous.

Structured branches:

* master: Production (release are made here, available for hotfix). Nobody commit here.
* dev: Complete feature ready for next release. Dev merge here.
* feature-a: Topic branch for feature A.
* feature-b: Topic branch for feature B.

Topic branches:

* master: Main branch. Nobody commit here.
* feature-a: Topic branch for feature A.
* feature-b: Topic branch for feature B.

Personnal branches:

* master: Main branch. Nobody commit here.
* joe-dev: Dev branch for Joe.
* bob-dev: Dev branch for Bob.

Vous pouvez désigner un membre de votre équipe qui sera le seul reponsable des merges.

La clé pour ramener les commits des branches topics/personnels, c'est en utilisant les pull request directement sur
github. Je vais vous expliquer plus en détails lors de la démo.

### SSH keys

Vous allez voir plus loin que je ne vais jamais saisir de mot de passe lorsque je vais communiquer avec Github.
Pourtant, Github est capable de m'identifier et de m'authentifier. Cela fonctionne grâce à l'usage de clés
cryptographiques asymétriques RSA public/privé, communiment appellé clés SSH.

Puisque l'installation des outils, la génération des clés et l'usage générique de clés SSH dépasse le contenu
de cette démonstration, et que les instructions sont entièrement dépendantes de votre système d'exploitation,
vous devrez chercher comment faire par vous-même. Je reste disponible pour répondre à vos questions.

Voici quelques liens pertinant sur le sujet:

* <https://help.github.com/articles/generating-an-ssh-key/>
* <https://git-scm.com/book/en/v2/Git-on-the-Server-Generating-Your-SSH-Public-Key>

## Demo

### Installing Git

L'installation de Git varie selon votre système d'exploitation. À vous de consulter la documentation.

### Configuring Git

> New command: `git config`

    git config --global user.name "Patrick Gagnon-Renaud"
    git config --global user.email "coding@pgrenaud.com"
    git config --global core.editor gedit  # Notepad++ for Windows
    git config --list

### Creating a new repository (local)

> New commands: `git init`, `git status`

    mkdir demo
    cd demo
    git init
    git status

### Initial commit

> New commands: `git add <pathspec>`, `git commit`

    vim README.md
    git status
    git add README.md
    git status
    git commit  # Initial commit.
    git status

### Configuring your IDE

> New commands: `git diff`, `git diff --check`

Tout d'abord, ouvrir l'IDE (ici WebStorm) et créer un nouveau projet dans le répertoire du dépôt.

Configure IDE:

* Encoding: UTF-8
* New line separator: \n
* New line at end of file
* Indent using space only
* No column limit
* Remove trailing whitespaces
* Show whitespaces

Vérifier la configuration:

    vim README.md
    git diff
    git diff --check

### Creating the Gitignore file

> New command: `git commit -m <msg>`

> New special file: `.gitignore`

    git status
    vim .gitignore
    git status
    git add .gitignore
    git commit -m "Added .gitignore file."
    git status

### Committing a file (#1)

> New commands: `git show`

    vim hello.html  # Basic HTML template with 'Hello World'
    git add hello.html
    git status
    git commit -m "Added hello.html file."
    git status
    git show

### Amending a commit

> New commands: `git diff --cached`, `git commit --amend`, `git show <object>`

    vim hello.html  # Add missing '!' to 'Hello World'
    git diff
    git add hello.html
    git diff --cached
    git commit --amend
    git show
    git show HEAD
    git show master

### Viewing the commit history

> New commands: `git log`, `git log --stat`, `git log --oneline`

> New alias: `git tree`

    git log
    git log --stat
    git log --oneline
    git log --oneline --graph --decorate --all
    git config --global alias.tree 'log --oneline --graph --decorate --all'
    git tree

### Creating a branch (dev)

> New commands: `git branch`, `git branch <branchname>`. `git checkout <branchname>`

    git branch
    git branch dev
    git branch
    git checkout dev
    git branch
    git status

### Committing a file (#2)

    vim hello.html  # Add <header> section
    git add hello.html
    git diff --cached
    git commit -m "Added header section."
    git status
    git tree

### Committing a file (#3)

    vim hello.html  # Add <section> section
    git add hello.html
    git diff --cached
    git commit -m "Added main section."
    git status
    git tree

### Creating a branch (hotfix)

> New command: `git checkout -b <branchname>`

    git checkout master
    git checkout -b hotfix
    git branch
    vim hello.html  # Add missing <title>
    git add hello.html
    git diff --cached
    git commit -m "Added missing title tag."
    git status
    git tree

### Merging a branch in fast-forward (hotfix)

> New commands: `git merge <branchname>`, `git branch -d <branchname>`

    git checkout master
    git merge hotfix
    git branch -d hotfix
    git branch
    git tree

L'historique a divergé.

### Committing a file (#4)

    git checkout dev
    vim hello.html  # Add <footer> section
    git add hello.html
    git diff --cached
    git commit -m "Added footer section."
    git status
    git tree

### Merging a branch (dev)

    git checkout master
    git merge dev
    git tree

### Creating a new repository (Github)

Créer le dépôt sur Github et copier l'adresse du remote.

### Adding a remote

> New commands: `git remote add <name> <url>`, `git remote -v`

    git remote add origin git@github.com:pgrenaud/demo.git
    git remote -v

### Pushing to origin

> New commands: `git push -u <repository> <refspec>`, `git branch -a`

    git push -u origin master
    git status
    git branch -a

### Merging a branch in fast-forward (master)

    git checkout dev
    git merge master
    git tree

### Committing a file (#5)

    vim hello.html  # Add <p> inside <header> with wrong indent
    git add hello.html
    git diff --cached
    git commit -m "Added p tag."
    git status
    git tree

### Creating a branch (feature)

    git checkout -b feature
    vim hello.html  # Add <ul> inside <section>
    git add hello.html
    git diff --cached
    git commit -m "Added ul tag."
    git status
    git tree

### Adding using patch + Stashing + Committing a file (#6)

> New commands: `git add -p <pathspec>`, `git stash`

    vim hello.html  # Add <li> item and fix wrong indent from above
    git add -p hello.html  # Only stash the <li> item
    git diff
    git diff --cached
    git commit -m "Added second li tag."
    git show
    git status
    git stash  # Fix for wrong indent from above
    git status

### Committing a file (#7)

    vim hello.html  # Add <li> item
    git add hello.html
    git diff --cached
    git commit -m "Added third li tag."
    git status
    git tree

### Popping a stash + Committing a file (#8)

> New commands: `git stash list`, `git stash pop`

    git checkout dev
    git stash list
    git stash pop  # Fix for wrong indent from above
    git status
    git add hello.html
    git diff --cached
    git commit -m "Fixed p tag."
    git status
    git tree

L'historique a divergé.

### Interactive rebase

Operations:

* Reordering commits
* Rewording commits
* Editing (splitting) commits
* Squashing (fixingup) commits
* Removing commits

### Squashing multiple commits

> New command: `git rebase -i <commit>`

Dans la commande ci-dessous, l'expression `HEAD^^^` (équivalente à `HEAD~3`) signifie le 3e commit parent
du commit présent.

    git rebase -i HEAD^^^
    git tree

### Rebasing a branch (feature) + Merging a branch (feature)

> New command: `git rebase <branch>`

    git checkout feature
    git rebase dev
    git tree
    git checkout dev
    git merge feature
    git tree
    git branch -d feature
    git push
    git push -u origin dev
    git status

### Creating a new pull request (Github)

Créer un nouveau pull request avec la branche `dev`.
Montrer le processus d'évaluation du code et d'approbation avec thumbs up.
Approuver et fermer le pull request.

Un pull request fait toujours un merge, même dans les cas où un fast-forward aurait suffit.

### Pulling a branch (master)

> New command: `git pull`

Lorsqu'on effecture l'opération git-pull, git fait en réalité deux chose: un git-fetch suivie d'un git-merge.

    git tree
    git checkout master
    git pull
    git tree

### Rollback

Maintenant, je vais revenir en arrière, pour faire comme si nous n'avions jamais fait de `pull`.
À ne pas faire à la maison! Je fais uniquement ça dans le cadre de la démontration.

    ../git-demo/bin/git-pull-rollback.sh

### Fetching and merging a branch (master)

> New command: `git fetch`

    git tree
    git checkout master
    git fetch
    git merge origin/master

### Tagging a commit

> New commands: `git tag <tagname>`, `git push --tags`

    git tag v1.0
    git tree
    git push --tags
    git tree

### Cloning a repository

> New command: `git clone`

    cd ..
    git clone git@github.com:pgrenaud/demo.git demo2
    git status
    git tree

## Outro

### Resources

* <https://git-scm.com/book>
* <https://git-scm.com/docs>
* <https://help.github.com/>
