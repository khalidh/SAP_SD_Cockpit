# SD Sales Cockpit

Application SAPUI5 freestyle pour piloter les processus SAP SD : commandes clients, livraisons, factures, retards, blocages et indicateurs de performance.

## Architecture

Le projet suit un pattern SAPUI5 MVC classique :

- `webapp/manifest.json` : descriptor applicatif, dépendances UI5, modèles et routing.
- `webapp/Component.js` : bootstrap du composant et initialisation du router.
- `webapp/view/*.view.xml` : vues XML freestyle.
- `webapp/controller/*.controller.js` : logique de navigation, filtrage et interaction.
- `webapp/model/mockData.json` : données SD mockées conservées comme référence de prototypage.
- `webapp/model/formatter.js` : formatage des statuts, montants et icônes.
- `webapp/css/style.css` : ajustements visuels légers au-dessus du thème Fiori Horizon.

## Arborescence

```text
.
├── index.html
├── package.json
├── package-lock.json
├── ui5.yaml
├── README.md
├── db
│   ├── schema.cds
│   └── data
├── docs
│   └── odata-migration.md
├── srv
│   ├── sales-service.cds
│   └── sales-service.js
└── webapp
    ├── Component.js
    ├── manifest.json
    ├── controller
    │   ├── App.controller.js
    │   ├── Alerts.controller.js
    │   ├── Analytics.controller.js
    │   ├── Dashboard.controller.js
    │   ├── SalesOrderDetail.controller.js
    │   └── SalesOrders.controller.js
    ├── css
    │   └── style.css
    ├── i18n
    │   └── i18n.properties
    ├── model
    │   ├── formatter.js
    │   └── mockData.json
    └── view
        ├── App.view.xml
        ├── Alerts.view.xml
        ├── Analytics.view.xml
        ├── Dashboard.view.xml
        ├── SalesOrderDetail.view.xml
        └── SalesOrders.view.xml
```

## Routing

Le routing est déclaré dans `webapp/manifest.json`.

Routes principales :

- `""` -> `Dashboard`
- `"sales-orders"` -> `SalesOrders`
- `"sales-orders/{orderId}"` -> `SalesOrderDetail`
- `"alerts"` -> `Alerts`
- `"analytics"` -> `Analytics`

Le contrôle cible est le `sap.m.App` défini dans `App.view.xml` avec l'id `app`. Chaque navigation appelle `this.getOwnerComponent().getRouter().navTo(...)`.

Dans `SalesOrderDetail.controller.js`, le paramètre `{orderId}` est lu dans `_onRouteMatched`. Le contrôleur cherche la commande dans `/salesOrders`, puis fait un `bindElement` sur le chemin correspondant. Ce pattern est simple pour le mock et se remplace facilement par un binding OData du type `/SalesOrders('5000012481')`.

## Modèles de données

Le modèle par défaut est un `sap.ui.model.odata.v4.ODataModel` configuré dans `webapp/manifest.json`.

Service local attendu :

```text
http://localhost:4004/odata/v4/sd/
```

Principales entités OData :

- `/SalesOrders` : commandes, données d'en-tête, lignes et étapes du processus SD.
- `/SdAlerts` : alertes opérationnelles SD.
- `/RevenueByMonth`, `/RevenueByCustomer`, `/RevenueBySalesOrg`, `/OperationalTrend` : datasets des `VizFrame`.
- `/TopCustomers` et `/TopMaterials` : classements affichés dans le dashboard.
- `/dashboardKpis(...)` : action OData V4 utilisée pour alimenter les KPI cards.

Les modèles nommés `device`, `ui` et `dashboard` restent des `JSONModel` locaux pour l'état d'interface, les filtres et l'affichage synthétique des KPI.

Le fichier `formatter.js` centralise la conversion des codes métier vers les états UI5 :

- `OK` -> `Success`
- `PARTIAL` ou `PENDING` -> `Warning`
- `BLOCKED`, `DELAYED`, `CRITICAL` -> `Error`

## UX Fiori

L'application utilise des composants SAPUI5 standards :

- `sap.m.GenericTile` pour les KPI.
- `sap.m.Table`, `ObjectStatus`, `ObjectNumber`, `ObjectIdentifier` pour les listes métier.
- `sap.uxap.ObjectPageLayout` pour le détail commande.
- `sap.m.IconTabBar` pour les classements dashboard.
- `sap.viz.ui5.controls.VizFrame` pour les graphiques analytiques.
- `sap.m.MessageStrip` et `sap.m.List` pour les messages et alertes.
- `sap.m.Dialog`, `Select` et `TextArea` pour traiter les alertes SD directement depuis le cockpit.

Les codes couleur suivent les états Fiori :

- Vert : `Success`, processus OK.
- Orange : `Warning`/`Critical`, attention ou action attendue.
- Rouge : `Error`, blocage ou retard.

## Évolution CAP, CDS et OData

Un squelette CAP est disponible dans `db/` et `srv/`. Il expose les concepts métier du cockpit sous forme d'entités OData V4.

Pour connecter ensuite SAP S/4HANA :

1. Remplacer les CSV CAP par des vues CDS ou des appels vers S/4HANA.
2. Conserver des entités proches du modèle UI :
   - `SalesOrders`
   - `SalesOrderItems`
   - `Deliveries`
   - `BillingDocuments`
   - `SdAlerts`
   - `KpiSnapshots`
3. Exposer des vues CDS analytiques pour :
   - CA par mois
   - CA par client
   - CA par organisation commerciale
   - retards de livraison
   - commandes ouvertes
4. Ajouter des annotations Fiori Elements si une partie du cockpit devient standardisable.
5. Utiliser intent-based navigation vers les apps Fiori standard :
   - afficher commande client
   - afficher livraison
   - afficher facture
   - gérer blocage crédit

Le code actuel garde les chemins de binding OData simples afin de faciliter cette migration.

Voir aussi `docs/odata-migration.md`.

## Traitement des alertes

L'écran `Alertes SD` permet maintenant de mettre à jour une alerte via OData V4 :

- statut de traitement : ouverte, en cours, traitée ;
- assignation à un responsable ;
- commentaire ADV ;
- horodatage de résolution lorsque l'alerte est marquée comme traitée.

Ces changements sont persistés dans l'entité CAP `SdAlerts`.

## Lancement local

Avec les dépendances installées :

```bash
npm install
npm start
```

Pour tester le service CAP :

```bash
npm run cap
```

Service attendu : `http://localhost:4004/odata/v4/sd/`.

Sans UI5 CLI, un serveur statique suffit pour tester la structure :

```bash
python3 -m http.server 8080
```

Puis ouvrir `http://localhost:8080/index.html`.
