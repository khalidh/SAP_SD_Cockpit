@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Process Step Interface'
define view entity ZI_SD_PROCESS_STEP
  as select from zsd_so_step as Step
{
  key step_uuid   as StepUUID,
      parent_uuid as ParentUUID,
      step_at     as StepAt,
      title       as Title,
      description as Description,
      owner       as Owner,
      icon        as Icon,
      sequence    as Sequence
}
