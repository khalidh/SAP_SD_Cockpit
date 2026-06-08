@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SD KPI Snapshot Projection'
define root view entity ZC_SD_KPI_SNAPSHOT as projection on ZI_SD_KPI_SNAPSHOT {
  key SnapshotUUID, SnapshotDate, MonthlyRevenue, MonthlyRevenueScale, OpenOrders,
      DelayedDeliveries, PendingInvoices, CreditBlockedOrders, ServiceLevel, Currency
}
