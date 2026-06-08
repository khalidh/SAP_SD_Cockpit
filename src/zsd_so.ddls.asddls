@EndUserText.label : 'SD Sales Orders'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zsd_so {
  key client      : abap.clnt not null;
  key order_uuid  : sysuuid_x16 not null;
  order_id        : abap.char(10);
  sales_doc_type  : abap.char(40);
  customer_id     : abap.char(10);
  customer_name   : abap.char(80);
  order_date      : abap.dats;
  @Semantics.amount.currencyCode : 'currency'
  amount          : abap.curr(15,2);
  currency        : abap.cuky;
  sales_org       : abap.char(4);
  distr_channel   : abap.char(2);
  division        : abap.char(2);
  status_code     : abap.char(20);
  status_text     : abap.char(40);
  incoterms       : abap.char(40);
  payment_terms   : abap.char(60);
  created_by      : abp_creation_user;
  created_at      : abp_creation_tstmpl;
  last_changed_by : abp_lastchange_user;
  last_changed_at : abp_locinst_lastchange_tstmpl;
}
