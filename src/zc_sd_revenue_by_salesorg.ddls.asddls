@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Revenue by Sales Org Projection'
define root view entity ZC_SD_REVENUE_BY_SALESORG
  as projection on ZI_SD_REVENUE_BY_SALESORG
{
  key RevenueBySalesOrgUUID, SalesOrg, Revenue, Currency
}
