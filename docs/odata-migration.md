# Migration vers CAP / OData V4

Ce projet contient maintenant deux couches :

- `webapp/` : cockpit SAPUI5 freestyle branché sur un `JSONModel`.
- `db/` et `srv/` : squelette CAP exposant les mêmes concepts en OData V4.

## Service exposé

Le service CAP est déclaré dans `srv/sales-service.cds` :

```text
/odata/v4/sd/SalesOrders
/odata/v4/sd/SalesOrderItems
/odata/v4/sd/SdAlerts
/odata/v4/sd/KpiSnapshots
/odata/v4/sd/RevenueByMonth
/odata/v4/sd/RevenueByCustomer
/odata/v4/sd/RevenueBySalesOrg
/odata/v4/sd/OperationalTrend
/odata/v4/sd/dashboardKpis()
```

## Bascule UI5

Dans `manifest.json`, remplacer le modèle JSON par un modèle OData V4 :

```json
{
  "dataSources": {
    "sdService": {
      "uri": "/odata/v4/sd/",
      "type": "OData",
      "settings": {
        "odataVersion": "4.0"
      }
    }
  },
  "models": {
    "": {
      "dataSource": "sdService",
      "settings": {
        "synchronizationMode": "None",
        "operationMode": "Server",
        "autoExpandSelect": true
      }
    }
  }
}
```

Ensuite, adapter les bindings :

- `/salesOrders` devient `/SalesOrders`.
- `/alerts` devient `/SdAlerts`.
- `/analytics/revenueByMonth` devient `/RevenueByMonth`.
- Le détail commande peut utiliser `/SalesOrders(ID)` ou une route par `orderId` avec filtre serveur.

## Commandes

Installer les dépendances :

```bash
npm install
```

Démarrer CAP :

```bash
npm run cap
```

Le service CAP est utile pour itérer sur le modèle métier avant de connecter SAP S/4HANA.
