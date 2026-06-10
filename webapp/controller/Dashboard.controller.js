sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/ui/model/json/JSONModel",
  "sd/sales/cockpit/model/formatter"
], function (Controller, JSONModel, formatter) {
  "use strict";

  var SERVICE_URL = "http://localhost:4004/odata/v4/sd/";

  return Controller.extend("sd.sales.cockpit.controller.Dashboard", {
    formatter: formatter,

    onInit: function () {
      this.getView().setModel(new JSONModel({
        topCustomers: [],
        topMaterials: []
      }), "dashboardLists");
      this._loadDashboardKpis();
      this._loadDashboardLists();
    },

    _loadDashboardKpis: function () {
      var oDashboardModel = this.getOwnerComponent().getModel("dashboard");

      this._fetchJson(SERVICE_URL + "KpiSnapshots?$orderby=snapshotDate%20desc&$top=1")
        .then(function (oPayload) {
          var oSnapshot = (oPayload.value && oPayload.value[0]) || {};
          oDashboardModel.setData({
            monthlyRevenue: oSnapshot.monthlyRevenue || 0,
            monthlyRevenueScale: oSnapshot.monthlyRevenueScale || "K",
            currency: oSnapshot.currency || "EUR",
            openOrders: oSnapshot.openOrders || 0,
            delayedDeliveries: oSnapshot.delayedDeliveries || 0,
            pendingInvoices: oSnapshot.pendingInvoices || 0,
            creditBlockedOrders: oSnapshot.creditBlockedOrders || 0,
            serviceLevel: oSnapshot.serviceLevel || 0
          });
        })
        .catch(function () {
          this._loadMockDashboard();
        }.bind(this));
    },

    _loadDashboardLists: function () {
      Promise.all([
        this._fetchJson(SERVICE_URL + "TopCustomers?$orderby=revenue%20desc"),
        this._fetchJson(SERVICE_URL + "TopMaterials?$orderby=revenue%20desc")
      ]).then(function (aPayloads) {
        this.getView().getModel("dashboardLists").setData({
          topCustomers: (aPayloads[0].value || []).map(function (oCustomer) {
            return Object.assign({}, oCustomer, {
              customerId: oCustomer.customerId || oCustomer.id
            });
          }),
          topMaterials: aPayloads[1].value || []
        });
      }.bind(this)).catch(function () {
        this._loadMockDashboard();
      }.bind(this));
    },

    _fetchJson: function (sUrl) {
      return fetch(sUrl, {
        headers: {
          Accept: "application/json"
        }
      }).then(function (oResponse) {
        if (!oResponse.ok) {
          throw new Error("HTTP " + oResponse.status);
        }
        return oResponse.json();
      });
    },

    _loadMockDashboard: function () {
      fetch("model/mockData.json").then(function (oResponse) {
        if (!oResponse.ok) {
          throw new Error("Mock data unavailable");
        }
        return oResponse.json();
      }).then(function (oMock) {
        this.getOwnerComponent().getModel("dashboard").setData({
          monthlyRevenue: oMock.kpis.monthlyRevenue.value,
          monthlyRevenueScale: "K",
          currency: oMock.kpis.monthlyRevenue.currency,
          openOrders: oMock.kpis.openOrders,
          delayedDeliveries: oMock.kpis.delayedDeliveries,
          pendingInvoices: oMock.kpis.pendingInvoices,
          creditBlockedOrders: oMock.kpis.creditBlockedOrders,
          serviceLevel: oMock.kpis.serviceLevel
        });
        this.getView().getModel("dashboardLists").setData({
          topCustomers: oMock.topCustomers.map(function (oCustomer) {
            return Object.assign({}, oCustomer, {
              customerId: oCustomer.customerId || oCustomer.id
            });
          }),
          topMaterials: oMock.topMaterials
        });
      }.bind(this));
    },

    onNavToSalesOrders: function () {
      this.getOwnerComponent().getRouter().navTo("salesOrders");
    },

    onNavToAlerts: function () {
      this.getOwnerComponent().getRouter().navTo("alerts");
    },

    onNavToAnalytics: function () {
      this.getOwnerComponent().getRouter().navTo("analytics");
    },

    onNavToSapSandbox: function () {
      this.getOwnerComponent().getRouter().navTo("sapSandbox");
    }
  });
});
