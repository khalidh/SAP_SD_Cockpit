sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/ui/model/Filter",
  "sap/ui/model/FilterOperator",
  "sap/m/MessageToast",
  "sd/sales/cockpit/model/formatter"
], function (Controller, Filter, FilterOperator, MessageToast, formatter) {
  "use strict";

  return Controller.extend("sd.sales.cockpit.controller.Alerts", {
    formatter: formatter,

    onNavBack: function () {
      this.getOwnerComponent().getRouter().navTo("dashboard");
    },

    onFilter: function () {
      var aFilters = [];
      var sSeverity = this.byId("severityFilter").getSelectedKey();
      var sType = this.byId("alertTypeFilter").getSelectedKey();

      if (sSeverity) {
        aFilters.push(new Filter("severity", FilterOperator.EQ, sSeverity));
      }
      if (sType) {
        aFilters.push(new Filter("type", FilterOperator.EQ, sType));
      }

      this.byId("alertsList").getBinding("items").filter(aFilters);
    },

    onAlertPress: function (oEvent) {
      var sReference = oEvent.getSource().getBindingContext().getProperty("reference");
      MessageToast.show("Analyse de l'alerte " + sReference);
    },

    onRefresh: function () {
      MessageToast.show("Données mock rechargées depuis le JSONModel.");
    }
  });
});
