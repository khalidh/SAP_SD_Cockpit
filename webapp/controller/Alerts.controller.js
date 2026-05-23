sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/ui/model/Filter",
  "sap/ui/model/FilterOperator",
  "sap/ui/model/json/JSONModel",
  "sap/m/Dialog",
  "sap/m/Button",
  "sap/m/Label",
  "sap/m/MessageToast",
  "sap/m/Select",
  "sap/m/Text",
  "sap/m/TextArea",
  "sap/m/VBox",
  "sap/ui/core/Item",
  "sd/sales/cockpit/model/formatter"
], function (Controller, Filter, FilterOperator, JSONModel, Dialog, Button, Label, MessageToast, Select, Text, TextArea, VBox, Item, formatter) {
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
      var sProcessStatus = this.byId("processStatusFilter").getSelectedKey();

      if (sSeverity) {
        aFilters.push(new Filter("severity", FilterOperator.EQ, sSeverity));
      }
      if (sType) {
        aFilters.push(new Filter("type", FilterOperator.EQ, sType));
      }
      if (sProcessStatus) {
        aFilters.push(new Filter("processStatus", FilterOperator.EQ, sProcessStatus));
      }

      this.byId("alertsList").getBinding("items").filter(aFilters);
    },

    onAlertPress: function (oEvent) {
      var oContext = oEvent.getSource().getBindingContext();
      this._openProcessingDialog(oContext);
    },

    onRefresh: function () {
      this.byId("alertsList").getBinding("items").refresh();
      MessageToast.show("Alertes OData rechargées.");
    },

    _openProcessingDialog: function (oContext) {
      var oAlert = oContext.getObject();
      var oDialogModel = new JSONModel({
        alertId: oAlert.alertId,
        title: oAlert.title,
        reference: oAlert.reference,
        customerName: oAlert.customerName,
        processStatus: oAlert.processStatus || "OPEN",
        assignee: oAlert.assignee || "",
        comment: oAlert.comment || ""
      });

      if (!this._oProcessingDialog) {
        this._oProcessingDialog = this._createProcessingDialog();
        this.getView().addDependent(this._oProcessingDialog);
      }

      this._oProcessingDialog.setModel(oDialogModel, "dialog");
      this._oProcessingDialog.setBindingContext(oContext);
      this._oProcessingDialog.open();
    },

    _createProcessingDialog: function () {
      return new Dialog({
        title: "Traiter l'alerte SD",
        contentWidth: "34rem",
        content: [
          new VBox({
            class: "sapUiSmallMargin",
            items: [
              new Text({ text: "{dialog>/title}" }),
              new Text({ text: "Référence : {dialog>/reference} - {dialog>/customerName}" }),
              new Label({ text: "Statut de traitement", labelFor: "processStatusSelect" }),
              new Select("processStatusSelect", {
                width: "100%",
                selectedKey: "{dialog>/processStatus}",
                items: {
                  path: "ui>/filters/alertProcessStatuses",
                  template: new Item({ key: "{ui>key}", text: "{ui>text}" })
                }
              }),
              new Label({ text: "Assigné à", labelFor: "assigneeSelect" }),
              new Select("assigneeSelect", {
                width: "100%",
                selectedKey: "{dialog>/assignee}",
                items: {
                  path: "ui>/filters/assignees",
                  template: new Item({ key: "{ui>key}", text: "{ui>text}" })
                }
              }),
              new Label({ text: "Commentaire ADV", labelFor: "alertCommentArea" }),
              new TextArea("alertCommentArea", {
                width: "100%",
                rows: 5,
                maxLength: 255,
                value: "{dialog>/comment}"
              })
            ]
          })
        ],
        beginButton: new Button({
          text: "Enregistrer",
          type: "Emphasized",
          press: this.onSaveAlertProcessing.bind(this)
        }),
        endButton: new Button({
          text: "Annuler",
          press: function () {
            this._oProcessingDialog.close();
          }.bind(this)
        })
      });
    },

    onSaveAlertProcessing: function () {
      var oDialog = this._oProcessingDialog;
      var oContext = oDialog.getBindingContext();
      var oDialogData = oDialog.getModel("dialog").getData();
      var sResolvedAt = oDialogData.processStatus === "RESOLVED" ? new Date().toISOString() : null;

      Promise.all([
        oContext.setProperty("processStatus", oDialogData.processStatus, "alerts"),
        oContext.setProperty("assignee", oDialogData.assignee, "alerts"),
        oContext.setProperty("comment", oDialogData.comment, "alerts"),
        oContext.setProperty("resolvedAt", sResolvedAt, "alerts")
      ]).then(function () {
        return this.getView().getModel().submitBatch("alerts");
      }.bind(this)).then(function () {
        this.byId("alertsList").getBinding("items").refresh();
        oDialog.close();
        MessageToast.show("Alerte " + oDialogData.alertId + " mise à jour.");
      }.bind(this)).catch(function (oError) {
        MessageToast.show("Mise à jour impossible : " + (oError.message || oError));
      });
    }
  });
});
