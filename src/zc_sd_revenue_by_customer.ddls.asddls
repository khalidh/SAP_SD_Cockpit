@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Revenue by Customer Projection'
define root view entity ZC_SD_REVENUE_BY_CUSTOMER as projection on ZI_SD_REVENUE_BY_CUSTOMER {
  key RevenueByCustomerUUID, Customer, Revenue, Currency
}
