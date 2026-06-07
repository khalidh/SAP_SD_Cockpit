# Execution ADT et import abapGit

Ce projet est une application SAPUI5 freestyle avec un backend CAP local. Il peut etre versionne sur GitHub, execute localement avec Node.js, puis prepare pour un deploiement SAP ABAP. En revanche, abapGit importe des objets ABAP serialises. Il ne transforme pas automatiquement un dossier `webapp/` ou un backend CAP Node.js en objets ABAP.

## Package cible ADT

Le package ABAP cible a utiliser dans Eclipse ADT / abapGit est :

```text
ZSAP_SD_COCKPIT_FR
```

Important : abapGit ne stocke pas le nom du package racine dans le depot Git. Le package racine est defini dans ADT au moment de creer le depot abapGit online. Il faut donc saisir exactement `ZSAP_SD_COCKPIT_FR` dans le champ package lors du clone/import.

Le depot contient aussi `src/package.devc.xml`, qui fournit les metadonnees de description du package racine lorsqu'abapGit cree ou synchronise le package.

## Lancement local avant import ABAP

Depuis le dossier du projet :

```bash
npm install
npm run cap
```

Puis ouvrir :

```text
http://localhost:4004/index.html
```

Le service CAP local est expose ici :

```text
http://localhost:4004/odata/v4/sd/
```

## Build UI5 pour un systeme ABAP

Generer les artefacts statiques SAPUI5 :

```bash
npm run build
```

Le resultat est cree dans `dist/`. Ce dossier est deployable comme application BSP/UI5 repository dans un systeme ABAP avec les outils SAP habituels, par exemple SAP Fiori tools, `/UI5/UI5_REPOSITORY_LOAD`, ou un pipeline utilisant `/UI5/ABAP_REPOSITORY_SRV`.

## Utilisation avec Eclipse ADT et abapGit

1. Installer ou activer abapGit pour ADT dans Eclipse.
2. Creer un nouveau depot online abapGit depuis l'URL GitHub du projet.
3. Dans le champ package, saisir exactement `ZSAP_SD_COCKPIT_FR`.
4. Si le package n'existe pas, laisser abapGit le creer ou le creer au prealable dans ADT/SE80 selon les regles de transport de ton systeme.
5. Cloner le depot GitHub dans ce package.
6. Si le depot ne contient que les sources UI5/CAP, abapGit ne creera pas l'application BSP finale tout seul.
7. Deployer d'abord le contenu `dist/` en BSP dans le systeme ABAP.
8. Depuis le systeme ABAP, serialiser ensuite l'application BSP avec abapGit dans `ZSAP_SD_COCKPIT_FR`. Cette operation produira les objets ABAP/BSP attendus dans `src/`, notamment l'objet de type BSP application.
9. Pousser ces objets serialises dans GitHub.
10. Les prochains imports via abapGit ADT pourront alors recreer les objets ABAP/BSP dans le package `ZSAP_SD_COCKPIT_FR`.

## Points d'attention

- Le backend CAP (`srv/`, `db/`, `server.js`) ne s'execute pas dans ADT ni dans le serveur ABAP. Il sert au mode local et au prototype OData.
- Pour une execution 100% ABAP, il faut remplacer le service CAP par un service OData ABAP, par exemple RAP, SEGW, ou un service existant S/4HANA.
- L'URL OData actuelle est `http://localhost:4004/odata/v4/sd/`. Avant de deployer en ABAP, adapter `webapp/manifest.json` et `webapp/Component.js` vers l'URL OData ABAP cible.
- Le fichier `.env` ne doit pas etre pousse dans GitHub.

## Resume pratique

Pour developper :

```bash
npm run cap
```

Pour preparer les fichiers UI5 a deployer sur ABAP :

```bash
npm run build
```

Pour importer avec abapGit ADT, creer le depot online dans le package `ZSAP_SD_COCKPIT_FR`. Les objets ABAP serialises dans `src/` doivent etre generes depuis un systeme ABAP apres creation/deploiement du BSP.
