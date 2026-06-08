@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Revenue by Customer Interface'
define root view entity ZI_SD_REVENUE_BY_CUSTOMER as select from zsd_revcust {
  key revcust_uuid as RevenueByCustomerUUID,
      customer_name as Customer,
      @Semantics.amount.currencyCode: 'Currency'
      revenue as Revenue,
      currency as Currency
}
