@EndUserText.label : 'SD Top Materials'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zsd_topmat {
  key client       : abap.clnt not null;
  key topmat_uuid  : sysuuid_x16 not null;
  material         : abap.char(18);
  description      : abap.char(100);
  category         : abap.char(40);
  quantity         : abap.int4;
  @Semantics.amount.currencyCode : 'currency'
  revenue          : abap.curr(15,2);
  currency         : abap.cuky;
}
