@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD KPI Snapshot Projection'
@UI.headerInfo: {
  typeName: 'Pilotage ADV',
  typeNamePlural: 'Pilotage ADV',
  title: { value: 'SnapshotDate' },
  description: { value: 'Currency' }
}
define root view entity ZC_SD_KPI_SNAPSHOT
  provider contract transactional_query
  as projection on ZI_SD_KPI_SNAPSHOT
{
  key SnapshotUUID,

      @EndUserText.label: 'Date'
      @UI.lineItem: [{ position: 10, label: 'Date' }]
      @UI.identification: [{ position: 10, label: 'Date' }]
      SnapshotDate,

      @EndUserText.label: 'CA du mois'
      @UI.dataPoint: { title: 'CA du mois' }
      @UI.lineItem: [{ position: 20, type: #AS_DATAPOINT, label: 'CA du mois' }]
      @UI.identification: [{ position: 20, type: #AS_DATAPOINT, label: 'CA du mois' }]
      MonthlyRevenue,

      @EndUserText.label: 'Echelle CA'
      MonthlyRevenueScale,

      @EndUserText.label: 'Commandes ouvertes'
      @UI.dataPoint: { title: 'Commandes ouvertes' }
      @UI.lineItem: [{ position: 30, type: #AS_DATAPOINT, label: 'Commandes ouvertes' }]
      @UI.identification: [{ position: 30, type: #AS_DATAPOINT, label: 'Commandes ouvertes' }]
      OpenOrders,

      @EndUserText.label: 'Livraisons en retard'
      @UI.dataPoint: { title: 'Livraisons en retard' }
      @UI.lineItem: [{ position: 40, type: #AS_DATAPOINT, label: 'Livraisons en retard' }]
      @UI.identification: [{ position: 40, type: #AS_DATAPOINT, label: 'Livraisons en retard' }]
      DelayedDeliveries,

      @EndUserText.label: 'Factures en attente'
      @UI.dataPoint: { title: 'Factures en attente' }
      @UI.lineItem: [{ position: 50, type: #AS_DATAPOINT, label: 'Factures en attente' }]
      @UI.identification: [{ position: 50, type: #AS_DATAPOINT, label: 'Factures en attente' }]
      PendingInvoices,

      @EndUserText.label: 'Blocages credit'
      @UI.dataPoint: { title: 'Blocages credit' }
      @UI.lineItem: [{ position: 60, type: #AS_DATAPOINT, label: 'Blocages credit' }]
      @UI.identification: [{ position: 60, type: #AS_DATAPOINT, label: 'Blocages credit' }]
      CreditBlockedOrders,

      @EndUserText.label: 'Taux de service'
      @UI.dataPoint: { title: 'Taux de service' }
      @UI.lineItem: [{ position: 70, type: #AS_DATAPOINT, label: 'Taux de service' }]
      @UI.identification: [{ position: 70, type: #AS_DATAPOINT, label: 'Taux de service' }]
      ServiceLevel,

      Currency
}
