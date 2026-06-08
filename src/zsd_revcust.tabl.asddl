@EndUserText.label : 'SD Revenue by Customer'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zsd_revcust {
  key client       : abap.clnt not null;
  key revcust_uuid : sysuuid_x16 not null;
  customer_name    : abap.char(80);
  @Semantics.amount.currencyCode : 'currency'
  revenue          : abap.curr(15,2);
  currency         : abap.cuky;
}
