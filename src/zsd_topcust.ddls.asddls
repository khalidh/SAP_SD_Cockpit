@EndUserText.label : 'SD Top Customers'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zsd_topcust {
  key client        : abap.clnt not null;
  key topcust_uuid  : sysuuid_x16 not null;
  customer_id       : abap.char(10);
  customer_name     : abap.char(80);
  @Semantics.amount.currencyCode : 'currency'
  revenue           : abap.curr(15,2);
  currency          : abap.cuky;
  orders_count      : abap.int4;
  trend             : abap.char(40);
  trend_status      : abap.char(20);
}
