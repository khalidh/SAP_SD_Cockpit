# Ecran RAP/Fiori Elements pour le cockpit SD

Ce depot contient les annotations CDS necessaires pour obtenir un ecran Fiori
Elements proche du cockpit SAPUI5 freestyle :

- tuiles KPI depuis `KpiSnapshots` ;
- listes `TopCustomers` et `TopMaterials` ;
- navigation vers `SalesOrders` et `SdAlerts` ;
- datasets analytiques `RevenueByMonth`, `RevenueByCustomer`,
  `RevenueBySalesOrg` et `OperationalTrend`.

## Objets RAP concernes

Les annotations UI sont portees directement par les projections CDS suivantes :

```text
ZC_SD_KPI_SNAPSHOT
ZC_SD_TOP_CUSTOMER
ZC_SD_TOP_MATERIAL
ZC_SD_SALES_ORDER
ZC_SD_SALES_ORDER_ITEM
ZC_SD_ALERT
ZC_SD_REVENUE_BY_MONTH
ZC_SD_REVENUE_BY_CUSTOMER
ZC_SD_REVENUE_BY_SALESORG
ZC_SD_OPERATIONAL_TREND
```

Le service RAP reste :

```text
ZSD_SALES_COCKPIT
```

Le binding OData V4 reste :

```text
ZSD_SALES_COCKPIT_O4
```

## Activation dans Eclipse ADT

Apres import abapGit dans le package `ZSAP_SD_COCKPIT_FR2` :

1. Activer les tables `ZSD_*`.
2. Activer les vues interface `ZI_*`.
3. Activer les projections annotees `ZC_*`.
4. Activer `ZSD_SALES_COCKPIT`.
5. Activer puis publier `ZSD_SALES_COCKPIT_O4`.
6. Executer `ZCL_SD_DEMO_DATA_LOAD` avec **Run As > ABAP Application**.
7. Ouvrir le service binding, puis lancer **Preview** sur les entites :
   - `KpiSnapshots` pour les KPI ;
   - `TopCustomers` et `TopMaterials` pour les tableaux ;
   - `SalesOrders` et `SdAlerts` pour les listes operationnelles.

## Pour un ecran vraiment similaire a la capture

La preview ADT affiche une application Fiori Elements standard par entite. Pour
un tableau de bord multi-cartes dans le meme ecran, creer une app Fiori Elements
Overview Page ou une app SAPUI5 freestyle en consommant le service OData V4 RAP :

```text
/sap/opu/odata4/sap/zsd_sales_cockpit/srvd/sap/zsd_sales_cockpit/0001/
```

Mapping recommande :

| Zone de l'ecran | Entite RAP |
| --- | --- |
| CA du mois, commandes ouvertes, retards, factures, blocages, taux service | `KpiSnapshots` |
| Onglet Top clients | `TopCustomers` |
| Onglet Top articles | `TopMaterials` |
| Bouton Commandes | `SalesOrders` |
| Bouton Alertes | `SdAlerts` |
| Bouton Analytique | `RevenueByMonth`, `RevenueByCustomer`, `RevenueBySalesOrg`, `OperationalTrend` |

Pour un rendu pixel proche de la capture, conserver l'application SAPUI5
freestyle existante et remplacer uniquement la source de donnees CAP par l'URL
OData V4 RAP. Pour un rendu zero-code cote frontend, utiliser les annotations
CDS ajoutees ici avec Fiori Elements.
