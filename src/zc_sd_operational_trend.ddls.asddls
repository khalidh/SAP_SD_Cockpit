@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Operational Trend Projection'
@UI.headerInfo: {
  typeName: 'Tendance operationnelle',
  typeNamePlural: 'Tendances operationnelles',
  title: { value: 'Week' }
}
define root view entity ZC_SD_OPERATIONAL_TREND
  provider contract transactional_query
  as projection on ZI_SD_OPERATIONAL_TREND
{
  key OperationalTrendUUID,

      @EndUserText.label: 'Semaine'
      @UI.lineItem: [{ position: 10, label: 'Semaine' }]
      @UI.identification: [{ position: 10, label: 'Semaine' }]
      Week,

      @EndUserText.label: 'Retards'
      @UI.dataPoint: { title: 'Retards' }
      @UI.lineItem: [{ position: 20, type: #AS_DATAPOINT, label: 'Retards' }]
      @UI.identification: [{ position: 20, type: #AS_DATAPOINT, label: 'Retards' }]
      Delays,

      @EndUserText.label: 'Commandes ouvertes'
      @UI.dataPoint: { title: 'Commandes ouvertes' }
      @UI.lineItem: [{ position: 30, type: #AS_DATAPOINT, label: 'Commandes ouvertes' }]
      @UI.identification: [{ position: 30, type: #AS_DATAPOINT, label: 'Commandes ouvertes' }]
      OpenOrders
}
