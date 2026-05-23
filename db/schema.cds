namespace sd.sales;

using {
  cuid,
  managed
} from '@sap/cds/common';

type StatusCode : String(20);
type CurrencyCode : String(3);

entity SalesOrders : cuid, managed {
  orderId             : String(10) @assert.unique;
  salesDocumentType   : String(40);
  customerId          : String(10);
  customerName        : String(80);
  orderDate           : Date;
  amount              : Decimal(15, 2);
  currency            : CurrencyCode default 'EUR';
  salesOrg            : String(4);
  distributionChannel : String(2);
  division            : String(2);
  statusCode          : StatusCode;
  statusText          : String(40);
  incoterms           : String(40);
  paymentTerms        : String(60);
  items               : Composition of many SalesOrderItems on items.parent = $self;
  processSteps        : Composition of many ProcessSteps on processSteps.parent = $self;
}

entity SalesOrderItems : cuid, managed {
  parent             : Association to SalesOrders;
  itemNo             : String(6);
  material           : String(18);
  description        : String(100);
  quantity           : Decimal(13, 3);
  unit               : String(3);
  netPrice           : Decimal(15, 2);
  currency           : CurrencyCode default 'EUR';
  discount           : Decimal(5, 2);
  deliveryStatusCode : StatusCode;
  deliveryStatusText : String(40);
  billingStatusCode  : StatusCode;
  billingStatusText  : String(40);
}

entity ProcessSteps : cuid, managed {
  parent      : Association to SalesOrders;
  stepDate    : Timestamp;
  title       : String(80);
  description : String(160);
  owner       : String(60);
  icon        : String(80);
  sequence    : Integer;
}

entity SdAlerts : cuid, managed {
  alertId      : String(12) @assert.unique;
  type         : String(30);
  typeText     : String(60);
  severity     : String(10);
  statusText   : String(40);
  title        : String(120);
  reference    : String(20);
  customerName : String(80);
  dueDate      : Date;
  owner        : String(60);
  amount       : Decimal(15, 2);
  currency     : String(3);
}

entity KpiSnapshots : cuid, managed {
  snapshotDate        : Date;
  monthlyRevenue      : Decimal(15, 2);
  monthlyRevenueScale : String(5);
  openOrders          : Integer;
  delayedDeliveries   : Integer;
  pendingInvoices     : Integer;
  creditBlockedOrders : Integer;
  serviceLevel        : Decimal(5, 2);
  currency            : CurrencyCode default 'EUR';
}

entity TopCustomers : cuid {
  customerId  : String(10);
  name        : String(80);
  revenue     : Decimal(15, 2);
  orders      : Integer;
  trend       : String(40);
  trendStatus : StatusCode;
}

entity TopMaterials : cuid {
  material    : String(18);
  description : String(100);
  category    : String(40);
  quantity    : Integer;
  revenue     : Decimal(15, 2);
}

entity RevenueByMonth : cuid {
  month   : String(10);
  revenue : Decimal(15, 2);
  sortNo  : Integer;
}

entity RevenueByCustomer : cuid {
  customer : String(80);
  revenue  : Decimal(15, 2);
}

entity RevenueBySalesOrg : cuid {
  salesOrg : String(4);
  revenue  : Decimal(15, 2);
}

entity OperationalTrend : cuid {
  week       : String(6);
  delays     : Integer;
  openOrders : Integer;
}
