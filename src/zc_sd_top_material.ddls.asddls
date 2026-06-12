@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Top Material Projection'
@Search.searchable: true
@UI.headerInfo: {
  typeName: 'Top article',
  typeNamePlural: 'Top articles',
  title: { value: 'Material' },
  description: { value: 'Description' }
}
define root view entity ZC_SD_TOP_MATERIAL
  provider contract transactional_query
  as projection on ZI_SD_TOP_MATERIAL
{
  key TopMaterialUUID,

      @EndUserText.label: 'Article'
      @Search.defaultSearchElement: true
      @UI.lineItem: [{ position: 10, label: 'Article' }]
      @UI.identification: [{ position: 10, label: 'Article' }]
      Material,

      @EndUserText.label: 'Libelle'
      @Search.defaultSearchElement: true
      @UI.lineItem: [{ position: 20, label: 'Libelle' }]
      @UI.identification: [{ position: 20, label: 'Libelle' }]
      Description,

      @EndUserText.label: 'Categorie'
      @UI.lineItem: [{ position: 30, label: 'Categorie' }]
      @UI.identification: [{ position: 30, label: 'Categorie' }]
      Category,

      @EndUserText.label: 'Quantite'
      @UI.lineItem: [{ position: 40, label: 'Quantite' }]
      @UI.identification: [{ position: 40, label: 'Quantite' }]
      Quantity,

      @EndUserText.label: 'CA'
      @UI.dataPoint: { title: 'CA', criticality: #POSITIVE }
      @UI.lineItem: [{ position: 50, type: #AS_DATAPOINT, label: 'CA' }]
      @UI.identification: [{ position: 50, type: #AS_DATAPOINT, label: 'CA' }]
      Revenue,

      Currency
}
