@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Sales Order Projection'
@Metadata.allowExtensions: true
define root view entity ZC_SD_SALES_ORDER
  as projection on ZI_SD_SALES_ORDER
{
  key OrderUUID,
      OrderID,
      SalesDocumentType,
      CustomerID,
      CustomerName,
      OrderDate,
      Amount,
      Currency,
      SalesOrg,
      DistributionChannel,
      Division,
      StatusCode,
      StatusText,
      Incoterms,
      PaymentTerms,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      _Items : redirected to composition child ZC_SD_SALES_ORDER_ITEM
}
