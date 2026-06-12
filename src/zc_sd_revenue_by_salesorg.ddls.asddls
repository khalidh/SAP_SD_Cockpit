@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Revenue by Sales Org Projection'
@UI.headerInfo: {
  typeName: 'CA organisation',
  typeNamePlural: 'CA par organisation',
  title: { value: 'SalesOrg' }
}
define root view entity ZC_SD_REVENUE_BY_SALESORG
  provider contract transactional_query
  as projection on ZI_SD_REVENUE_BY_SALESORG
{
  key RevenueBySalesOrgUUID,

      @EndUserText.label: 'Organisation commerciale'
      @UI.lineItem: [{ position: 10, label: 'Organisation commerciale' }]
      @UI.identification: [{ position: 10, label: 'Organisation commerciale' }]
      SalesOrg,

      @EndUserText.label: 'CA'
      @UI.dataPoint: { title: 'CA' }
      @UI.lineItem: [{ position: 20, type: #AS_DATAPOINT, label: 'CA' }]
      @UI.identification: [{ position: 20, type: #AS_DATAPOINT, label: 'CA' }]
      Revenue,

      Currency
}
