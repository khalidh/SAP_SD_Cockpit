const cds = require("@sap/cds");

module.exports = cds.service.impl(async function () {
  const { KpiSnapshots } = cds.entities("sd.sales");

  this.on("dashboardKpis", async () => {
    const rows = await SELECT.from(KpiSnapshots).orderBy("snapshotDate desc").limit(1);
    const snapshot = rows[0];

    if (!snapshot) {
      return {
        monthlyRevenue: 0,
        monthlyRevenueScale: "K",
        currency: "EUR",
        openOrders: 0,
        delayedDeliveries: 0,
        pendingInvoices: 0,
        creditBlockedOrders: 0,
        serviceLevel: 0
      };
    }

    return {
      monthlyRevenue: snapshot.monthlyRevenue,
      monthlyRevenueScale: snapshot.monthlyRevenueScale,
      currency: snapshot.currency,
      openOrders: snapshot.openOrders,
      delayedDeliveries: snapshot.delayedDeliveries,
      pendingInvoices: snapshot.pendingInvoices,
      creditBlockedOrders: snapshot.creditBlockedOrders,
      serviceLevel: snapshot.serviceLevel
    };
  });
});
