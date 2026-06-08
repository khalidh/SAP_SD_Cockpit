@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Revenue by Month Interface'
define root view entity ZI_SD_REVENUE_BY_MONTH as select from zsd_revmon {
  key revmon_uuid as RevenueByMonthUUID,
      month_text as Month,
      @Semantics.amount.currencyCode: 'Currency'
      revenue as Revenue,
      currency as Currency,
      sort_no as SortNo
}
