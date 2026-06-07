sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/m/MessageToast"
], function (Controller, MessageToast) {
  "use strict";

  return Controller.extend("sd.sales.cockpit.controller.SapSandbox", {
    onInit: function () {
      this._loadApis();
    },

    _loadApis: function () {
      var oModel = this.getOwnerComponent().getModel();
      var oSandboxModel = this.getOwnerComponent().getModel("sandbox");
      var oAction = oModel.bindContext("/sapSandboxApis(...)");

      oSandboxModel.setProperty("/busy", true);

      oAction.execute().then(function () {
        var aApis = oAction.getBoundContext().getObject().value || [];
        oSandboxModel.setProperty("/apis", aApis);
      }).catch(function (oError) {
        MessageToast.show(oError.message || "Chargement des APIs impossible.");
      }).finally(function () {
        oSandboxModel.setProperty("/busy", false);
      });
    },

    onApiChange: function (oEvent) {
      var sKey = oEvent.getSource().getSelectedKey();
      var oSandboxModel = this.getOwnerComponent().getModel("sandbox");
      var mDefaultQueries = {
        c4cSalesOrders: "$select=ObjectID",
        businessPartners: "$select=BusinessPartner,BusinessPartnerFullName",
        salesOrders: "$select=SalesOrder,SoldToParty,TotalNetAmount,TransactionCurrency",
        products: "$select=Product,ProductType,BaseUnit",
        outboundDeliveries: "$select=OutboundDelivery,ShipToParty,DeliveryDate",
        billingDocuments: "$select=BillingDocument,SoldToParty,TotalNetAmount,TransactionCurrency"
      };

      oSandboxModel.setProperty("/selectedApi", sKey);
      oSandboxModel.setProperty("/query", mDefaultQueries[sKey] || "");
    },

    onCallApi: function () {
      var oModel = this.getOwnerComponent().getModel();
      var oSandboxModel = this.getOwnerComponent().getModel("sandbox");
      var oAction = oModel.bindContext("/callSapSandboxApi(...)");

      oAction.setParameter("api", oSandboxModel.getProperty("/selectedApi"));
      oAction.setParameter("top", Number(oSandboxModel.getProperty("/top")) || 5);
      oAction.setParameter("query", oSandboxModel.getProperty("/query") || "");

      oSandboxModel.setProperty("/busy", true);

      oAction.execute().then(function () {
        var oResult = oAction.getBoundContext().getObject();
        var sResponse = oResult.payload;

        try {
          sResponse = JSON.stringify(JSON.parse(oResult.payload), null, 2);
        } catch (oError) {
          // Keep non-JSON payloads readable as returned by the sandbox.
        }

        oSandboxModel.setProperty("/lastStatus", String(oResult.status));
        oSandboxModel.setProperty("/lastUrl", oResult.sandboxUrl);
        oSandboxModel.setProperty("/response", sResponse);
      }).catch(function (oError) {
        MessageToast.show(oError.message || "Appel SAP Sandbox impossible.");
      }).finally(function () {
        oSandboxModel.setProperty("/busy", false);
      });
    },

    onRefreshApis: function () {
      this._loadApis();
    },

    onNavBack: function () {
      this.getOwnerComponent().getRouter().navTo("dashboard");
    }
  });
});
