@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project Projection'
@Metadata.allowExtensions: true
@Search.searchable: true
@UI.headerInfo: {
  typeName: 'Projet',
  typeNamePlural: 'Projets',
  title: { value: 'Name' },
  description: { value: 'ProjectID' }
}
define root view entity ZC_PROJECT
  provider contract transactional_query
  as projection on ZI_PROJECT
{
      @EndUserText.label: 'Projet'
      @Search.defaultSearchElement: true
      @UI.lineItem: [{ position: 10, label: 'Projet' }]
      @UI.identification: [{ position: 10, label: 'Projet' }]
  key ProjectID,

      @EndUserText.label: 'Nom'
      @Search.defaultSearchElement: true
      @UI.lineItem: [{ position: 20, label: 'Nom' }]
      @UI.identification: [{ position: 20, label: 'Nom' }]
      Name,

      @EndUserText.label: 'Budget'
      @UI.dataPoint: { title: 'Budget' }
      @UI.lineItem: [{ position: 30, type: #AS_DATAPOINT, label: 'Budget' }]
      @UI.identification: [{ position: 30, type: #AS_DATAPOINT, label: 'Budget' }]
      Budget,

      @EndUserText.label: 'Devise'
      @UI.lineItem: [{ position: 40, label: 'Devise' }]
      @UI.identification: [{ position: 40, label: 'Devise' }]
      Currency,

      @EndUserText.label: 'Statut'
      @UI.lineItem: [{ position: 50, label: 'Statut' }]
      @UI.identification: [{ position: 50, label: 'Statut' }]
      Status
}
