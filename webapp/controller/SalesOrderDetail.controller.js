sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/ui/model/Filter",
  "sap/ui/model/FilterOperator",
  "sap/m/MessageToast",
  "sd/sales/cockpit/model/formatter"
], function (Controller, Filter, FilterOperator, MessageToast, formatter) {
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
      var oListBinding = this.getView().getModel().bindList("/SalesOrders", null, null, [
        new Filter("orderId", FilterOperator.EQ, sOrderId)
      ], {
        $expand: "items,processSteps"
      });

      oListBinding.requestContexts(0, 1).then(function (aContexts) {
        if (!aContexts.length) {
          this.getOwnerComponent().getRouter().navTo("salesOrders");
          return;
        }
        this.getView().setBindingContext(aContexts[0]);
      }.bind(this));
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
