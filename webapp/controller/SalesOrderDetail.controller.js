sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/m/MessageToast",
  "sd/sales/cockpit/model/formatter"
], function (Controller, MessageToast, formatter) {
  "use strict";

  return Controller.extend("sd.sales.cockpit.controller.SalesOrderDetail", {
    formatter: formatter,

    onInit: function () {
      this.getOwnerComponent().getRouter()
        .getRoute("salesOrderDetail")
        .attachPatternMatched(this._onRouteMatched, this);
    },

    _onRouteMatched: function (oEvent) {
      var sOrderId = oEvent.getParameter("arguments").orderId;
      var aOrders = this.getView().getModel().getProperty("/salesOrders") || [];
      var iIndex = aOrders.findIndex(function (oOrder) {
        return oOrder.orderId === sOrderId;
      });

      if (iIndex < 0) {
        this.getOwnerComponent().getRouter().navTo("salesOrders");
        return;
      }

      this.getView().bindElement("/salesOrders/" + iIndex);
    },

    onNavBack: function () {
      this.getOwnerComponent().getRouter().navTo("salesOrders");
    },

    onShowDelivery: function () {
      MessageToast.show("Ouverture de la livraison associée prévue via navigation SAP GUI/Fiori.");
    },

    onShowInvoice: function () {
      MessageToast.show("Ouverture de la facture associée prévue via intent-based navigation.");
    },

    onReportIssue: function () {
      MessageToast.show("Anomalie SD signalée à l'équipe ADV.");
    }
  });
});
