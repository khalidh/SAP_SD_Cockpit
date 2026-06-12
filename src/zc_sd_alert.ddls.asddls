@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Alert Projection'
@Metadata.allowExtensions: true
@Search.searchable: true
@UI.headerInfo: {
  typeName: 'Alerte',
  typeNamePlural: 'Alertes',
  title: { value: 'Title' },
  description: { value: 'Reference' }
}
define root view entity ZC_SD_ALERT
  provider contract transactional_query
  as projection on ZI_SD_ALERT
{
  key AlertUUID,

      @EndUserText.label: 'Alerte'
      @Search.defaultSearchElement: true
      @UI.lineItem: [{ position: 10, label: 'Alerte' }]
      @UI.identification: [{ position: 10, label: 'Alerte' }]
      AlertID,

      @EndUserText.label: 'Type'
      @UI.selectionField: [{ position: 10 }]
      AlertType,

      @EndUserText.label: 'Type'
      @UI.lineItem: [{ position: 20, label: 'Type' }]
      @UI.identification: [{ position: 20, label: 'Type' }]
      TypeText,

      @EndUserText.label: 'Severite'
      @UI.selectionField: [{ position: 20 }]
      @UI.lineItem: [{ position: 30, label: 'Severite' }]
      @UI.identification: [{ position: 30, label: 'Severite' }]
      Severity,

      @EndUserText.label: 'Statut'
      @UI.lineItem: [{ position: 40, label: 'Statut' }]
      @UI.identification: [{ position: 40, label: 'Statut' }]
      StatusText,

      ProcessStatus,

      @EndUserText.label: 'Sujet'
      @Search.defaultSearchElement: true
      @UI.lineItem: [{ position: 50, label: 'Sujet' }]
      @UI.identification: [{ position: 50, label: 'Sujet' }]
      Title,

      @EndUserText.label: 'Reference'
      @Search.defaultSearchElement: true
      @UI.lineItem: [{ position: 60, label: 'Reference' }]
      @UI.identification: [{ position: 60, label: 'Reference' }]
      Reference,

      @EndUserText.label: 'Client'
      @Search.defaultSearchElement: true
      @UI.lineItem: [{ position: 70, label: 'Client' }]
      @UI.identification: [{ position: 70, label: 'Client' }]
      CustomerName,

      @EndUserText.label: 'Echeance'
      @UI.selectionField: [{ position: 30 }]
      @UI.lineItem: [{ position: 80, label: 'Echeance' }]
      @UI.identification: [{ position: 80, label: 'Echeance' }]
      DueDate,

      @EndUserText.label: 'Responsable'
      @UI.lineItem: [{ position: 90, label: 'Responsable' }]
      @UI.identification: [{ position: 90, label: 'Responsable' }]
      Owner,

      @EndUserText.label: 'Assigne'
      @UI.identification: [{ position: 100, label: 'Assigne' }]
      Assignee,

      @EndUserText.label: 'Commentaire'
      @UI.identification: [{ position: 110, label: 'Commentaire' }]
      CommentText,

      ResolvedAt,

      @EndUserText.label: 'Montant'
      @UI.dataPoint: { title: 'Montant', criticality: #CRITICAL }
      @UI.lineItem: [{ position: 100, type: #AS_DATAPOINT, label: 'Montant' }]
      @UI.identification: [{ position: 120, type: #AS_DATAPOINT, label: 'Montant' }]
      Amount,

      Currency,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt
}
