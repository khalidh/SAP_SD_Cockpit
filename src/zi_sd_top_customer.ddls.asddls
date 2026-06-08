@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Top Customer Interface'
define root view entity ZI_SD_TOP_CUSTOMER as select from zsd_topcust {
  key topcust_uuid as TopCustomerUUID,
      customer_id as CustomerID,
      customer_name as Name,
      @Semantics.amount.currencyCode: 'Currency'
      revenue as Revenue,
      currency as Currency,
      orders_count as Orders,
      trend as Trend,
      trend_status as TrendStatus
}
