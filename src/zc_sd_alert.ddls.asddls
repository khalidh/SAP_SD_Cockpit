@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Alert Projection'
@Metadata.allowExtensions: true
define root view entity ZC_SD_ALERT
  provider contract transactional_query
  as projection on ZI_SD_ALERT
{
  key AlertUUID,
      AlertID,
      AlertType,
      TypeText,
      Severity,
      StatusText,
      ProcessStatus,
      Title,
      Reference,
      CustomerName,
      DueDate,
      Owner,
      Assignee,
      CommentText,
      ResolvedAt,
      Amount,
      Currency,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt
}
