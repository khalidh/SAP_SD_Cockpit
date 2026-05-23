sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sd/sales/cockpit/model/formatter"
], function (Controller, formatter) {
  "use strict";

  return Controller.extend("sd.sales.cockpit.controller.Dashboard", {
    formatter: formatter,

    onInit: function () {
      this._loadDashboardKpis();
    },

    _loadDashboardKpis: function () {
      var oModel = this.getOwnerComponent().getModel();
      var oDashboardModel = this.getOwnerComponent().getModel("dashboard");
      if (!oModel) {
        return;
      }
      var oAction = oModel.bindContext("/dashboardKpis(...)");

      oAction.execute().then(function () {
        oDashboardModel.setData(oAction.getBoundContext().getObject());
      });
    },

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
