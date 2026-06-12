sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/ui/model/json/JSONModel",
  "sd/sales/cockpit/model/formatter",
  "sd/sales/cockpit/model/serviceConfig"
], function (Controller, JSONModel, formatter, serviceConfig) {
  "use strict";

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

      this._fetchJson(serviceConfig.buildUrl("KpiSnapshots?$top=1"))
        .then(function (oPayload) {
          var oSnapshot = (oPayload.value && oPayload.value[0]) || {};
          oDashboardModel.setData({
            monthlyRevenue: this._read(oSnapshot, "monthlyRevenue", "MonthlyRevenue") || 0,
            monthlyRevenueScale: this._read(oSnapshot, "monthlyRevenueScale", "MonthlyRevenueScale") || "K",
            currency: this._read(oSnapshot, "currency", "Currency") || "EUR",
            openOrders: this._read(oSnapshot, "openOrders", "OpenOrders") || 0,
            delayedDeliveries: this._read(oSnapshot, "delayedDeliveries", "DelayedDeliveries") || 0,
            pendingInvoices: this._read(oSnapshot, "pendingInvoices", "PendingInvoices") || 0,
            creditBlockedOrders: this._read(oSnapshot, "creditBlockedOrders", "CreditBlockedOrders") || 0,
            serviceLevel: this._read(oSnapshot, "serviceLevel", "ServiceLevel") || 0
          });
        }.bind(this))
        .catch(function () {
          this._loadMockDashboard();
        }.bind(this));
    },

    _loadDashboardLists: function () {
      Promise.all([
        this._fetchJson(serviceConfig.buildUrl("TopCustomers")),
        this._fetchJson(serviceConfig.buildUrl("TopMaterials"))
      ]).then(function (aPayloads) {
        this.getView().getModel("dashboardLists").setData({
          topCustomers: (aPayloads[0].value || []).map(function (oCustomer) {
            return {
              customerId: this._read(oCustomer, "customerId", "CustomerId", "id"),
              name: this._read(oCustomer, "name", "customerName", "CustomerName"),
              revenue: this._read(oCustomer, "revenue", "Revenue"),
              orders: this._read(oCustomer, "orders", "ordersCount", "OrdersCount"),
              trend: this._read(oCustomer, "trend", "Trend"),
              trendStatus: this._read(oCustomer, "trendStatus", "TrendStatus")
            };
          }, this),
          topMaterials: (aPayloads[1].value || []).map(function (oMaterial) {
            return {
              material: this._read(oMaterial, "material", "Material"),
              category: this._read(oMaterial, "category", "Category"),
              description: this._read(oMaterial, "description", "Description"),
              quantity: this._read(oMaterial, "quantity", "Quantity"),
              revenue: this._read(oMaterial, "revenue", "Revenue")
            };
          }, this)
        });
      }.bind(this)).catch(function () {
        this._loadMockDashboard();
      }.bind(this));
    },

    _read: function (oObject) {
      var aKeys = Array.prototype.slice.call(arguments, 1);
      var i;

      for (i = 0; i < aKeys.length; i += 1) {
        if (oObject[aKeys[i]] !== undefined && oObject[aKeys[i]] !== null) {
          return oObject[aKeys[i]];
        }
      }

      return undefined;
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
