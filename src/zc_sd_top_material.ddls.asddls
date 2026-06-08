@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Top Material Projection'
define root view entity ZC_SD_TOP_MATERIAL as projection on ZI_SD_TOP_MATERIAL {
  key TopMaterialUUID, Material, Description, Category, Quantity, Revenue, Currency
}
