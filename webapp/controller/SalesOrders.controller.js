sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/ui/model/Filter",
  "sap/ui/model/FilterOperator",
  "sd/sales/cockpit/model/formatter"
], function (Controller, Filter, FilterOperator, formatter) {
  "use strict";

  return Controller.extend("sd.sales.cockpit.controller.SalesOrders", {
    formatter: formatter,

    onNavBack: function () {
      this.getOwnerComponent().getRouter().navTo("dashboard");
    },

    onOrderPress: function (oEvent) {
      var oContext = oEvent.getParameter("listItem").getBindingContext();
      this.getOwnerComponent().getRouter().navTo("salesOrderDetail", {
        orderId: oContext.getProperty("orderId")
      });
    },

    onSearch: function () {
      var aFilters = [];
      var sQuery = this.byId("customerSearch").getValue();
      var sSalesOrg = this.byId("salesOrgFilter").getSelectedKey();
      var sStatus = this.byId("statusFilter").getSelectedKey();
      var sDateFrom = this.byId("dateFromFilter").getValue();
      var sMinAmount = this.byId("minAmountFilter").getValue();

      if (sQuery) {
        aFilters.push(new Filter({
          filters: [
            new Filter("orderId", FilterOperator.Contains, sQuery),
            new Filter("customerName", FilterOperator.Contains, sQuery),
            new Filter("customerId", FilterOperator.Contains, sQuery)
          ],
          and: false
        }));
      }

      if (sSalesOrg) {
        aFilters.push(new Filter("salesOrg", FilterOperator.EQ, sSalesOrg));
      }

      if (sStatus) {
        aFilters.push(new Filter("statusCode", FilterOperator.EQ, sStatus));
      }

      if (sDateFrom) {
        aFilters.push(new Filter("orderDate", FilterOperator.GE, sDateFrom));
      }

      if (sMinAmount) {
        aFilters.push(new Filter("amount", FilterOperator.GE, Number(sMinAmount)));
      }

      this.byId("ordersTable").getBinding("items").filter(aFilters);
    },

    onResetFilters: function () {
      ["customerSearch", "salesOrgFilter", "statusFilter", "dateFromFilter", "minAmountFilter"].forEach(function (sId) {
        var oControl = this.byId(sId);
        if (oControl.setValue) {
          oControl.setValue("");
        }
        if (oControl.setSelectedKey) {
          oControl.setSelectedKey("");
        }
      }, this);
      this.onSearch();
    }
  });
});
