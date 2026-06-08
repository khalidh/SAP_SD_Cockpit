@EndUserText.label : 'SD Sales Order Items'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zsd_so_item {
  key client        : abap.clnt not null;
  key item_uuid     : sysuuid_x16 not null;
  parent_uuid       : sysuuid_x16 not null;
  item_no           : abap.char(6);
  material          : abap.char(18);
  description       : abap.char(100);
  @Semantics.quantity.unitOfMeasure : 'unit'
  quantity          : abap.quan(13,3);
  unit              : abap.unit(3);
  @Semantics.amount.currencyCode : 'currency'
  net_price         : abap.curr(15,2);
  currency          : abap.cuky;
  discount          : abap.dec(5,2);
  deliv_status_code : abap.char(20);
  deliv_status_text : abap.char(40);
  bill_status_code  : abap.char(20);
  bill_status_text  : abap.char(40);
  last_changed_at   : abp_locinst_lastchange_tstmpl;
}
