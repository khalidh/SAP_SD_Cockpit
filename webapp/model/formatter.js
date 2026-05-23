sap.ui.define([], function () {
  "use strict";

  var StatusState = {
    OK: "Success",
    OPEN: "Information",
    PARTIAL: "Warning",
    DELAYED: "Error",
    BLOCKED: "Error",
    INVOICED: "Success",
    DELIVERED: "Success",
    PENDING: "Warning",
    CRITICAL: "Error"
  };

  return {
    statusState: function (sStatus) {
      return StatusState[sStatus] || "None";
    },

    alertIcon: function (sSeverity) {
      return sSeverity === "Error" ? "sap-icon://error" : "sap-icon://alert";
    },

    processStatusText: function (sStatus) {
      var mText = {
        OPEN: "Ouverte",
        IN_PROGRESS: "En cours",
        RESOLVED: "Traitée"
      };
      return mText[sStatus] || sStatus || "";
    },

    processStatusState: function (sStatus) {
      var mState = {
        OPEN: "Error",
        IN_PROGRESS: "Warning",
        RESOLVED: "Success"
      };
      return mState[sStatus] || "None";
    },

    amount: function (nValue, sCurrency) {
      if (nValue === null || nValue === undefined) {
        return "";
      }
      return Number(nValue).toLocaleString("fr-FR", {
        minimumFractionDigits: 0,
        maximumFractionDigits: 0
      }) + " " + (sCurrency || "EUR");
    }
  };
});
