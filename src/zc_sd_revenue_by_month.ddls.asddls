@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Revenue by Month Projection'
@UI.headerInfo: {
  typeName: 'CA mensuel',
  typeNamePlural: 'CA mensuel',
  title: { value: 'MonthText' }
}
define root view entity ZC_SD_REVENUE_BY_MONTH
  provider contract transactional_query
  as projection on ZI_SD_REVENUE_BY_MONTH
{
  key RevenueByMonthUUID,

      @EndUserText.label: 'Mois'
      @UI.lineItem: [{ position: 10, label: 'Mois' }]
      @UI.identification: [{ position: 10, label: 'Mois' }]
      MonthText,

      @EndUserText.label: 'CA'
      @UI.dataPoint: { title: 'CA' }
      @UI.lineItem: [{ position: 20, type: #AS_DATAPOINT, label: 'CA' }]
      @UI.identification: [{ position: 20, type: #AS_DATAPOINT, label: 'CA' }]
      Revenue,

      Currency,
      SortNo
}
