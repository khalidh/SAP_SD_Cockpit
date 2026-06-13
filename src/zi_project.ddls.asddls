@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project Interface'
define root view entity ZI_PROJECT
  as select from zprojects_rap as Project
{
  key proj_id  as ProjectID,
      name     as Name,
      @Semantics.amount.currencyCode: 'Currency'
      budget   as Budget,
      currency as Currency,
      status   as Status
}
