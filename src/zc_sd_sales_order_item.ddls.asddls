@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Sales Order Item Projection'
@Metadata.allowExtensions: true
define view entity ZC_SD_SALES_ORDER_ITEM
  as select from ZI_SD_SALES_ORDER_ITEM
{
  key ItemUUID,
      ParentUUID,

      @EndUserText.label: 'Poste'
      @UI.lineItem: [{ position: 10, label: 'Poste' }]
      @UI.identification: [{ position: 10, label: 'Poste' }]
      ItemNo,

      @EndUserText.label: 'Article'
      @UI.lineItem: [{ position: 20, label: 'Article' }]
      @UI.identification: [{ position: 20, label: 'Article' }]
      Material,

      @EndUserText.label: 'Libelle'
      @UI.lineItem: [{ position: 30, label: 'Libelle' }]
      @UI.identification: [{ position: 30, label: 'Libelle' }]
      Description,

      @EndUserText.label: 'Quantite'
      @UI.lineItem: [{ position: 40, label: 'Quantite' }]
      @UI.identification: [{ position: 40, label: 'Quantite' }]
      Quantity,

      Unit,

      @EndUserText.label: 'Prix net'
      @UI.dataPoint: { title: 'Prix net' }
      @UI.lineItem: [{ position: 50, type: #AS_DATAPOINT, label: 'Prix net' }]
      @UI.identification: [{ position: 50, type: #AS_DATAPOINT, label: 'Prix net' }]
      NetPrice,

      Currency,

      @EndUserText.label: 'Remise'
      @UI.lineItem: [{ position: 60, label: 'Remise' }]
      @UI.identification: [{ position: 60, label: 'Remise' }]
      Discount,

      DeliveryStatusCode,

      @EndUserText.label: 'Livraison'
      @UI.lineItem: [{ position: 70, label: 'Livraison' }]
      @UI.identification: [{ position: 70, label: 'Livraison' }]
      DeliveryStatusText,

      BillingStatusCode,

      @EndUserText.label: 'Facturation'
      @UI.lineItem: [{ position: 80, label: 'Facturation' }]
      @UI.identification: [{ position: 80, label: 'Facturation' }]
      BillingStatusText,

      LastChangedAt
}
