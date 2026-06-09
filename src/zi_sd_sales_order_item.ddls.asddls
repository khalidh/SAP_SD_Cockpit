@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Sales Order Item Interface'
define view entity ZI_SD_SALES_ORDER_ITEM
  as select from zsd_so_item as Item
  association to parent ZI_SD_SALES_ORDER as _SalesOrder
    on $projection.ParentUUID = _SalesOrder.OrderUUID
{
  key item_uuid       as ItemUUID,
      parent_uuid     as ParentUUID,
      item_no         as ItemNo,
      material        as Material,
      description     as Description,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      quantity        as Quantity,
      unit            as Unit,
      @Semantics.amount.currencyCode: 'Currency'
      net_price       as NetPrice,
      currency        as Currency,
      discount        as Discount,
      deliv_status_code as DeliveryStatusCode,
      deliv_status_text as DeliveryStatusText,
      bill_status_code  as BillingStatusCode,
      bill_status_text  as BillingStatusText,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at as ItemLastChangedAt,
      _SalesOrder
}
