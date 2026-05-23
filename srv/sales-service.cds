using sd.sales as db from '../db/schema';

@path: '/odata/v4/sd'
service SalesCockpitService {
  entity SalesOrders       as projection on db.SalesOrders;
  entity SalesOrderItems   as projection on db.SalesOrderItems;
  entity ProcessSteps      as projection on db.ProcessSteps;
  entity SdAlerts          as projection on db.SdAlerts;
  entity KpiSnapshots      as projection on db.KpiSnapshots;
  entity TopCustomers      as projection on db.TopCustomers;
  entity TopMaterials      as projection on db.TopMaterials;
  entity RevenueByMonth    as projection on db.RevenueByMonth;
  entity RevenueByCustomer as projection on db.RevenueByCustomer;
  entity RevenueBySalesOrg as projection on db.RevenueBySalesOrg;
  entity OperationalTrend  as projection on db.OperationalTrend;

  action dashboardKpis() returns {
    monthlyRevenue      : Decimal(15, 2);
    monthlyRevenueScale : String(5);
    currency            : String(3);
    openOrders          : Integer;
    delayedDeliveries   : Integer;
    pendingInvoices     : Integer;
    creditBlockedOrders : Integer;
    serviceLevel        : Decimal(5, 2);
  };
}
