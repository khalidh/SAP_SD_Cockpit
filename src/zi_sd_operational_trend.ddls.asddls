@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Operational Trend Interface'
define root view entity ZI_SD_OPERATIONAL_TREND as select from zsd_optrend {
  key optrend_uuid as OperationalTrendUUID,
      week_text as Week,
      delays as Delays,
      open_orders as OpenOrders
}
