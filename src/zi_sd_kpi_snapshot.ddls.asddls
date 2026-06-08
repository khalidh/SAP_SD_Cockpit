@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD KPI Snapshot Interface'
define root view entity ZI_SD_KPI_SNAPSHOT as select from zsd_kpi {
  key snapshot_uuid as SnapshotUUID,
      snapshot_date as SnapshotDate,
      @Semantics.amount.currencyCode: 'Currency'
      monthly_revenue as MonthlyRevenue,
      monthly_revenue_scale as MonthlyRevenueScale,
      open_orders as OpenOrders,
      delayed_deliveries as DelayedDeliveries,
      pending_invoices as PendingInvoices,
      credit_blocked_orders as CreditBlockedOrders,
      service_level as ServiceLevel,
      currency as Currency
}
