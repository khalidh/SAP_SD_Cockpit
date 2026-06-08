@EndUserText.label : 'SD Revenue by Sales Org'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zsd_revsorg {
  key client       : abap.clnt not null;
  key revsorg_uuid : sysuuid_x16 not null;
  sales_org        : abap.char(4);
  @Semantics.amount.currencyCode : 'currency'
  revenue          : abap.curr(15,2);
  currency         : abap.cuky;
}
