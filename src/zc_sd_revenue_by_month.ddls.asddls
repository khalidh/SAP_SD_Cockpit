@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Revenue by Month Projection'
define root view entity ZC_SD_REVENUE_BY_MONTH as projection on ZI_SD_REVENUE_BY_MONTH {
  key RevenueByMonthUUID, Month, Revenue, Currency, SortNo
}
