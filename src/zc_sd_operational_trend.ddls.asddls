@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Operational Trend Projection'
define root view entity ZC_SD_OPERATIONAL_TREND as projection on ZI_SD_OPERATIONAL_TREND {
  key OperationalTrendUUID, Week, Delays, OpenOrders
}
