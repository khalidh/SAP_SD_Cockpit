sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sd/sales/cockpit/model/formatter"
], function (Controller, formatter) {
  "use strict";

  return Controller.extend("sd.sales.cockpit.controller.Dashboard", {
    formatter: formatter,

    onNavToSalesOrders: function () {
      this.getOwnerComponent().getRouter().navTo("salesOrders");
    },

    onNavToAlerts: function () {
      this.getOwnerComponent().getRouter().navTo("alerts");
    },

    onNavToAnalytics: function () {
      this.getOwnerComponent().getRouter().navTo("analytics");
    }
  });
});
