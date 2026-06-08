@EndUserText.label : 'SD Revenue by Month'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zsd_revmon {
  key client      : abap.clnt not null;
  key revmon_uuid : sysuuid_x16 not null;
  month_text      : abap.char(10);
  @Semantics.amount.currencyCode : 'currency'
  revenue         : abap.curr(15,2);
  currency        : abap.cuky;
  sort_no         : abap.int4;
}
