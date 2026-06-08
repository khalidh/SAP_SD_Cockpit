@EndUserText.label : 'SD KPI Snapshots'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zsd_kpi {
  key client           : abap.clnt not null;
  key snapshot_uuid    : sysuuid_x16 not null;
  snapshot_date        : abap.dats;
  @Semantics.amount.currencyCode : 'currency'
  monthly_revenue      : abap.curr(15,2);
  monthly_revenue_scale: abap.char(5);
  open_orders          : abap.int4;
  delayed_deliveries   : abap.int4;
  pending_invoices     : abap.int4;
  credit_blocked_orders: abap.int4;
  service_level        : abap.dec(5,2);
  currency             : abap.cuky;
}
