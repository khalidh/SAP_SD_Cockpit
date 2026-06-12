@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Revenue by Customer Projection'
@Search.searchable: true
@UI.headerInfo: {
  typeName: 'CA client',
  typeNamePlural: 'CA par client',
  title: { value: 'Customer' }
}
define root view entity ZC_SD_REVENUE_BY_CUSTOMER
  provider contract transactional_query
  as projection on ZI_SD_REVENUE_BY_CUSTOMER
{
  key RevenueByCustomerUUID,

      @EndUserText.label: 'Client'
      @Search.defaultSearchElement: true
      @UI.lineItem: [{ position: 10, label: 'Client' }]
      @UI.identification: [{ position: 10, label: 'Client' }]
      Customer,

      @EndUserText.label: 'CA'
      @UI.dataPoint: { title: 'CA' }
      @UI.lineItem: [{ position: 20, type: #AS_DATAPOINT, label: 'CA' }]
      @UI.identification: [{ position: 20, type: #AS_DATAPOINT, label: 'CA' }]
      Revenue,

      Currency
}
