@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Sales Order Projection'
@Metadata.allowExtensions: true
@Search.searchable: true
@UI.headerInfo: {
  typeName: 'Commande',
  typeNamePlural: 'Commandes',
  title: { value: 'OrderID' },
  description: { value: 'CustomerName' }
}
define root view entity ZC_SD_SALES_ORDER
  provider contract transactional_query
  as projection on ZI_SD_SALES_ORDER
{
  key OrderUUID,

      @EndUserText.label: 'Commande'
      @Search.defaultSearchElement: true
      @UI.selectionField: [{ position: 10 }]
      @UI.lineItem: [{ position: 10, label: 'Commande' }]
      @UI.identification: [{ position: 10, label: 'Commande' }]
      OrderID,

      @EndUserText.label: 'Type'
      @UI.identification: [{ position: 20, label: 'Type' }]
      SalesDocumentType,

      @EndUserText.label: 'Client'
      @Search.defaultSearchElement: true
      @UI.selectionField: [{ position: 20 }]
      @UI.lineItem: [{ position: 20, label: 'Client' }]
      @UI.identification: [{ position: 30, label: 'Client' }]
      CustomerID,

      @EndUserText.label: 'Nom client'
      @Search.defaultSearchElement: true
      @UI.lineItem: [{ position: 30, label: 'Nom client' }]
      @UI.identification: [{ position: 40, label: 'Nom client' }]
      CustomerName,

      @EndUserText.label: 'Date commande'
      @UI.selectionField: [{ position: 30 }]
      @UI.lineItem: [{ position: 40, label: 'Date commande' }]
      @UI.identification: [{ position: 50, label: 'Date commande' }]
      OrderDate,

      @EndUserText.label: 'Montant'
      @UI.lineItem: [{ position: 50, label: 'Montant' }]
      @UI.identification: [{ position: 60, label: 'Montant' }]
      Amount,

      Currency,

      @EndUserText.label: 'Organisation commerciale'
      @UI.selectionField: [{ position: 40 }]
      @UI.lineItem: [{ position: 60, label: 'Org. commerciale' }]
      @UI.identification: [{ position: 70, label: 'Organisation commerciale' }]
      SalesOrg,

      @EndUserText.label: 'Canal'
      @UI.identification: [{ position: 80, label: 'Canal' }]
      DistributionChannel,

      @EndUserText.label: 'Secteur'
      @UI.identification: [{ position: 90, label: 'Secteur' }]
      Division,

      StatusCode,

      @EndUserText.label: 'Statut'
      @UI.selectionField: [{ position: 50 }]
      @UI.lineItem: [{ position: 70, label: 'Statut' }]
      @UI.identification: [{ position: 100, label: 'Statut' }]
      StatusText,

      @EndUserText.label: 'Incoterms'
      @UI.identification: [{ position: 110, label: 'Incoterms' }]
      Incoterms,

      @EndUserText.label: 'Conditions paiement'
      @UI.identification: [{ position: 120, label: 'Conditions paiement' }]
      PaymentTerms,

      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt
}
