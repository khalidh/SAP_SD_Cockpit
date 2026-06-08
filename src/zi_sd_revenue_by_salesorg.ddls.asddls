@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Revenue by Sales Org Interface'
define root view entity ZI_SD_REVENUE_BY_SALESORG as select from zsd_revsorg {
  key revsorg_uuid as RevenueBySalesOrgUUID,
      sales_org as SalesOrg,
      @Semantics.amount.currencyCode: 'Currency'
      revenue as Revenue,
      currency as Currency
}
