@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Process Step Projection'
@Metadata.allowExtensions: true
define view entity ZC_SD_PROCESS_STEP
  provider contract transactional_query
  as projection on ZI_SD_PROCESS_STEP
{
  key StepUUID,
      ParentUUID,
      StepAt,
      Title,
      Description,
      Owner,
      Icon,
      Sequence,

      _SalesOrder : redirected to parent ZC_SD_SALES_ORDER
}
