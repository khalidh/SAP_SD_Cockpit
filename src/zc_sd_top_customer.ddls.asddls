@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Top Customer Projection'
define root view entity ZC_SD_TOP_CUSTOMER as projection on ZI_SD_TOP_CUSTOMER {
  key TopCustomerUUID, CustomerID, Name, Revenue, Currency, Orders, Trend, TrendStatus
}
