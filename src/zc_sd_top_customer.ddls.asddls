@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Top Customer Projection'
@Search.searchable: true
@UI.headerInfo: {
  typeName: 'Top client',
  typeNamePlural: 'Top clients',
  title: { value: 'Name' },
  description: { value: 'CustomerID' }
}
define root view entity ZC_SD_TOP_CUSTOMER
  provider contract transactional_query
  as projection on ZI_SD_TOP_CUSTOMER
{
  key TopCustomerUUID,

      @EndUserText.label: 'Client'
      @UI.lineItem: [{ position: 10, label: 'Client' }]
      @UI.identification: [{ position: 10, label: 'Client' }]
      CustomerID,

      @EndUserText.label: 'Nom'
      @Search.defaultSearchElement: true
      @UI.lineItem: [{ position: 20, label: 'Nom' }]
      @UI.identification: [{ position: 20, label: 'Nom' }]
      Name,

      @EndUserText.label: 'CA'
      @UI.dataPoint: { title: 'CA', criticality: #POSITIVE }
      @UI.lineItem: [{ position: 30, type: #AS_DATAPOINT, label: 'CA' }]
      @UI.identification: [{ position: 30, type: #AS_DATAPOINT, label: 'CA' }]
      Revenue,

      Currency,

      @EndUserText.label: 'Commandes'
      @UI.lineItem: [{ position: 40, label: 'Commandes' }]
      @UI.identification: [{ position: 40, label: 'Commandes' }]
      Orders,

      @EndUserText.label: 'Tendance'
      @UI.lineItem: [{ position: 50, label: 'Tendance' }]
      @UI.identification: [{ position: 50, label: 'Tendance' }]
      Trend,

      TrendStatus
}
