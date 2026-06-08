@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Sales Order Item Projection'
@Metadata.allowExtensions: true
define view entity ZC_SD_SALES_ORDER_ITEM
  as projection on ZI_SD_SALES_ORDER_ITEM
{
  key ItemUUID,
      ParentUUID,
      ItemNo,
      Material,
      Description,
      Quantity,
      Unit,
      NetPrice,
      Currency,
      Discount,
      DeliveryStatusCode,
      DeliveryStatusText,
      BillingStatusCode,
      BillingStatusText,
      LastChangedAt,
      _SalesOrder : redirected to parent ZC_SD_SALES_ORDER
}
