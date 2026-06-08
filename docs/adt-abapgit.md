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

## Backend RAP fourni dans `src/`

Le depot contient maintenant une base backend RAP dans `src/` pour remplacer le
service CAP local par un service OData V4 ABAP.

Objets principaux :

- tables `ZSD_*` pour les commandes, postes, etapes, alertes, KPI et datasets analytiques ;
- vues CDS interface `ZI_SD_*` ;
- vues CDS projection `ZC_SD_*` ;
- behaviors transactionnels pour `ZI_SD_SALES_ORDER` et `ZI_SD_ALERT` ;
- service definition `ZSD_SALES_COCKPIT` ;
- service binding OData V4 `ZSD_SALES_COCKPIT_O4`.

Ordre conseille dans ADT apres import abapGit :

1. Activer d'abord les tables transparentes `ZSD_*`.
2. Activer les vues `ZI_*`.
3. Activer les vues `ZC_*`.
4. Activer les behaviors et classes `ZBP_*`.
5. Activer `ZSD_SALES_COCKPIT`.
6. Publier le binding `ZSD_SALES_COCKPIT_O4`.

Si les tables `ZSD_*` ne sont pas actives, les vues `ZI_SD_*` echoueront avec
`The data source 'ZSD_*' does not exist or is not active`.

## Diagnostic des erreurs d'activation courantes

Si le protocole d'activation contient des messages comme :

```text
The data source 'ZSD_ALERT' does not exist or is not active
The data source 'ZSD_SO' does not exist or is not active
The data source 'ZI_SD_SALES_ORDER' does not exist or is not active
```

la cause racine est presque toujours que les tables transparentes `ZSD_*` n'ont
pas ete creees ou activees avant les vues CDS. Les erreurs sur `ZI_SD_*`, puis
sur `ZC_SD_*`, sont ensuite des erreurs en cascade.

Checklist dans ADT :

1. Dans le package `ZSAP_SD_COCKPIT_FR`, verifier que les objets `TABL`
   suivants existent : `ZSD_SO`, `ZSD_SO_ITEM`, `ZSD_SO_STEP`, `ZSD_ALERT`,
   `ZSD_KPI`, `ZSD_TOPCUST`, `ZSD_TOPMAT`, `ZSD_REVMON`, `ZSD_REVCUST`,
   `ZSD_REVSORG`, `ZSD_OPTREND`.
2. Si ces tables n'existent pas, refaire l'import via abapGit. Ne pas copier
   seulement les fichiers `*.asddls` dans ADT, car les tables sont livrees ici
   comme objets abapGit `TABL` serialises en `*.tabl.xml`.
3. Activer uniquement les tables `ZSD_*`.
4. Activer ensuite les vues interface `ZI_SD_*`.
5. Activer les vues projection `ZC_SD_*`.
6. Activer les behaviors `*.bdef`, les classes `ZBP_*`, puis le service
   `ZSD_SALES_COCKPIT`.

Les messages sur `ZC_CUSTOMER`, `ZI_TRAVEL`, `ZI_BOOKING` ou
`ZI_BOOKING_SUPPLEMENT` ne viennent pas de ce projet. Ils correspondent a des
objets RAP differents deja presents dans le systeme ou dans la meme reserve de
travail. Pour eviter de masquer le vrai probleme, les retirer de la reserve ou
les activer/corriger separement.

Corrections typiques pour ces objets externes :

- `ROOT keyword missing ... since 'ZI_CUSTOMER' has the root property` :
  la projection `ZC_CUSTOMER` doit aussi etre declaree avec
  `define root view entity`.
- `The child entity 'ZI_BOOKING' of a composition cannot be ROOT` :
  une entite enfant de composition ne doit pas etre declaree `root`.
- `The column ... is unknown` ou `The association ... is unknown` :
  la projection selectionne des champs ou associations qui n'existent pas dans
  l'interface CDS source active.

Erreurs corrigees dans les sources ABAP du projet :

- `COMMENT est un mot reserve` : le champ CDS expose est `CommentText`, mappe
  vers la colonne table `comment_text`.
- `MONTH est un mot reserve` : le champ CDS expose est `MonthText`, mappe vers
  la colonne table `month_text`.
- `Provider contract not modifiable if view contains 'REDIRECTED TO PARENT'
  associations` : les projections enfants `ZC_SD_SALES_ORDER_ITEM` et
  `ZC_SD_PROCESS_STEP` ne declarent pas de `provider contract
  transactional_query`; seul le root projection `ZC_SD_SALES_ORDER` le porte.

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
