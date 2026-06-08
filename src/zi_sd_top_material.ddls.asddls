@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Top Material Interface'
define root view entity ZI_SD_TOP_MATERIAL as select from zsd_topmat {
  key topmat_uuid as TopMaterialUUID,
      material as Material,
      description as Description,
      category as Category,
      quantity as Quantity,
      @Semantics.amount.currencyCode: 'Currency'
      revenue as Revenue,
      currency as Currency
}
