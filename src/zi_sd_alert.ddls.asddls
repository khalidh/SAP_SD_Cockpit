@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Alert Interface'
define root view entity ZI_SD_ALERT
  as select from zsd_alert as Alert
{
  key alert_uuid    as AlertUUID,
      alert_id      as AlertID,
      alert_type    as AlertType,
      type_text     as TypeText,
      severity      as Severity,
      status_text   as StatusText,
      process_status as ProcessStatus,
      title         as Title,
      reference     as Reference,
      customer_name as CustomerName,
      due_date      as DueDate,
      owner         as Owner,
      assignee      as Assignee,
      comment_text  as Comment,
      resolved_at   as ResolvedAt,
      @Semantics.amount.currencyCode: 'Currency'
      amount        as Amount,
      currency      as Currency,
      @Semantics.user.createdBy: true
      created_by    as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at    as CreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      last_changed_by as LastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at as LastChangedAt
}
