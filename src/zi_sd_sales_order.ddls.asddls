@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD Sales Order Interface'
define root view entity ZI_SD_SALES_ORDER
  as select from zsd_so as SalesOrder
  composition [0..*] of ZI_SD_SALES_ORDER_ITEM as _Items
  composition [0..*] of ZI_SD_PROCESS_STEP as _ProcessSteps
{
  key order_uuid      as OrderUUID,
      order_id        as OrderID,
      sales_doc_type  as SalesDocumentType,
      customer_id     as CustomerID,
      customer_name   as CustomerName,
      order_date      as OrderDate,
      @Semantics.amount.currencyCode: 'Currency'
      amount          as Amount,
      currency        as Currency,
      sales_org       as SalesOrg,
      distr_channel   as DistributionChannel,
      division        as Division,
      status_code     as StatusCode,
      status_text     as StatusText,
      incoterms       as Incoterms,
      payment_terms   as PaymentTerms,
      @Semantics.user.createdBy: true
      created_by      as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at      as CreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      last_changed_by as LastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at as LastChangedAt,
      _Items,
      _ProcessSteps
}
