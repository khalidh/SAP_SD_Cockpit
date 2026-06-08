@EndUserText.label : 'SD Operational Trend'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zsd_optrend {
  key client        : abap.clnt not null;
  key optrend_uuid  : sysuuid_x16 not null;
  week_text         : abap.char(6);
  delays            : abap.int4;
  open_orders       : abap.int4;
}
