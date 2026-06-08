@EndUserText.label : 'SD Sales Order Process Steps'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zsd_so_step {
  key client     : abap.clnt not null;
  key step_uuid  : sysuuid_x16 not null;
  parent_uuid    : sysuuid_x16 not null;
  step_at        : abap.utclong;
  title          : abap.char(80);
  description    : abap.char(160);
  owner          : abap.char(60);
  icon           : abap.char(80);
  sequence       : abap.int4;
}
