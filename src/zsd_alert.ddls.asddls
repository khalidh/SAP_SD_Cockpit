@EndUserText.label : 'SD Alerts'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zsd_alert {
  key client      : abap.clnt not null;
  key alert_uuid  : sysuuid_x16 not null;
  alert_id        : abap.char(12);
  alert_type      : abap.char(30);
  type_text       : abap.char(60);
  severity        : abap.char(10);
  status_text     : abap.char(40);
  process_status  : abap.char(20);
  title           : abap.char(120);
  reference       : abap.char(20);
  customer_name   : abap.char(80);
  due_date        : abap.dats;
  owner           : abap.char(60);
  assignee        : abap.char(60);
  comment_text    : abap.char(255);
  resolved_at     : abap.utclong;
  @Semantics.amount.currencyCode : 'currency'
  amount          : abap.curr(15,2);
  currency        : abap.cuky;
  created_by      : abp_creation_user;
  created_at      : abp_creation_tstmpl;
  last_changed_by : abp_lastchange_user;
  last_changed_at : abp_locinst_lastchange_tstmpl;
}
