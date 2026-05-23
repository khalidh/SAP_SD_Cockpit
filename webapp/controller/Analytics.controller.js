sap.ui.define([
  "sap/ui/core/mvc/Controller"
], function (Controller) {
  "use strict";

  return Controller.extend("sd.sales.cockpit.controller.Analytics", {
    onInit: function () {
      this._applyVizProperties();
    },

    onNavBack: function () {
      this.getOwnerComponent().getRouter().navTo("dashboard");
    },

    _applyVizProperties: function () {
      var oVizProps = {
        plotArea: {
          dataLabel: {
            visible: false
          },
          colorPalette: ["#107e3e", "#e9730c", "#0070f2", "#bb0000", "#5d36ff"]
        },
        title: {
          visible: false
        },
        legend: {
          visible: true
        }
      };

      ["revenueByMonthChart", "revenueByCustomerChart", "revenueBySalesOrgChart", "delaysChart"].forEach(function (sId) {
        var oChart = this.byId(sId);
        if (oChart) {
          oChart.setVizProperties(oVizProps);
        }
      }, this);
    }
  });
});
