sap.ui.define([
  "sap/ui/core/UIComponent",
  "sap/ui/Device",
  "sap/ui/model/json/JSONModel",
  "sap/ui/model/odata/v4/ODataModel",
  "sd/sales/cockpit/model/serviceConfig"
], function (UIComponent, Device, JSONModel, ODataModel, serviceConfig) {
  "use strict";

  return UIComponent.extend("sd.sales.cockpit.Component", {
    metadata: {
      manifest: "json"
    },

    init: function () {
      UIComponent.prototype.init.apply(this, arguments);

      if (serviceConfig.useMockModel()) {
        this._setMockModel();
      } else {
        this.setModel(new ODataModel({
          serviceUrl: serviceConfig.getServiceUrl(),
          synchronizationMode: "None",
          groupId: "$direct",
          operationMode: "Server",
          updateGroupId: "alerts",
          autoExpandSelect: true
        }));
      }

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
          ],
          alertProcessStatuses: [
            { key: "OPEN", text: "Ouverte" },
            { key: "IN_PROGRESS", text: "En cours" },
            { key: "RESOLVED", text: "Traitée" }
          ],
          assignees: [
            { key: "Nadia ADV", text: "Nadia ADV" },
            { key: "Karim Logistique", text: "Karim Logistique" },
            { key: "Sofia Supply", text: "Sofia Supply" },
            { key: "Mehdi Facturation", text: "Mehdi Facturation" },
            { key: "Crédit management", text: "Crédit management" }
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

      this.setModel(new JSONModel({
        apis: [],
        selectedApi: "c4cSalesOrders",
        top: 5,
        query: "$select=ObjectID",
        busy: false,
        lastStatus: "",
        lastUrl: "",
        response: ""
      }), "sandbox");

      this.getRouter().initialize();
    },

    _setMockModel: function () {
      var oModel = new JSONModel(this._toAppData({}));

      this.setModel(oModel);

      fetch(sap.ui.require.toUrl("sd/sales/cockpit/model/mockData.json"))
        .then(function (oResponse) {
          if (!oResponse.ok) {
            throw new Error("Mock data unavailable");
          }
          return oResponse.json();
        })
        .then(function (oData) {
          oModel.setData(this._toAppData(oData));
        }.bind(this))
        .catch(function () {
          oModel.setData(this._toAppData({}));
        }.bind(this));
    },

    _toAppData: function (oData) {
      var oKpis = oData.kpis || {};
      var oAnalytics = oData.analytics || {};

      return {
        KpiSnapshots: [{
          monthlyRevenue: oKpis.monthlyRevenue && oKpis.monthlyRevenue.value || 0,
          monthlyRevenueScale: "K",
          currency: oKpis.monthlyRevenue && oKpis.monthlyRevenue.currency || "EUR",
          openOrders: oKpis.openOrders || 0,
          delayedDeliveries: oKpis.delayedDeliveries || 0,
          pendingInvoices: oKpis.pendingInvoices || 0,
          creditBlockedOrders: oKpis.creditBlockedOrders || 0,
          serviceLevel: oKpis.serviceLevel || 0
        }],
        TopCustomers: oData.topCustomers || [],
        TopMaterials: oData.topMaterials || [],
        SalesOrders: oData.salesOrders || [],
        SdAlerts: oData.alerts || [],
        RevenueByMonth: oAnalytics.revenueByMonth || [],
        RevenueByCustomer: oAnalytics.revenueByCustomer || [],
        RevenueBySalesOrg: oAnalytics.revenueBySalesOrg || [],
        OperationalTrend: oAnalytics.operationalTrend || []
      };
    }
  });
});
