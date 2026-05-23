sap.ui.define([
  "sap/ui/core/UIComponent",
  "sap/ui/Device",
  "sap/ui/model/json/JSONModel"
], function (UIComponent, Device, JSONModel) {
  "use strict";

  return UIComponent.extend("sd.sales.cockpit.Component", {
    metadata: {
      manifest: "json"
    },

    init: function () {
      UIComponent.prototype.init.apply(this, arguments);

      this.setModel(new JSONModel({
        isPhone: Device.system.phone,
        listMode: Device.system.phone ? "None" : "SingleSelectMaster"
      }), "device");

      this.setModel(new JSONModel({
        filters: {
          salesOrganizations: [
            { key: "FR01", text: "FR01 - France Nord" },
            { key: "FR02", text: "FR02 - France Sud" },
            { key: "DE01", text: "DE01 - Allemagne" }
          ],
          orderStatuses: [
            { key: "OPEN", text: "Ouverte" },
            { key: "PARTIAL", text: "Partiellement livrée" },
            { key: "DELIVERED", text: "Livrée" },
            { key: "INVOICED", text: "Facturée" },
            { key: "BLOCKED", text: "Bloquée" }
          ],
          alertTypes: [
            { key: "CREDIT_BLOCK", text: "Blocage crédit" },
            { key: "DELIVERY_DELAY", text: "Livraison en retard" },
            { key: "STOCK_SHORTAGE", text: "Rupture de stock" },
            { key: "BILLING_PENDING", text: "Facture non générée" },
            { key: "CREDIT_EXCEEDED", text: "Dépassement crédit" }
          ]
        }
      }), "ui");

      this.setModel(new JSONModel({
        monthlyRevenue: 0,
        monthlyRevenueScale: "K",
        currency: "EUR",
        openOrders: 0,
        delayedDeliveries: 0,
        pendingInvoices: 0,
        creditBlockedOrders: 0,
        serviceLevel: 0
      }), "dashboard");

      this.getRouter().initialize();
    }
  });
});
