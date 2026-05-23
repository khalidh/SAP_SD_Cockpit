sap.ui.define([
  "sap/ui/core/UIComponent",
  "sap/ui/Device",
  "sap/ui/model/json/JSONModel"
], function (UIComponent, Device, JSONModel) {
  "use strict";

  return UIComponent.extend("sd.sales.cockpit.Component", {
    metadata: {
      manifest: "json"
    },

    init: function () {
      UIComponent.prototype.init.apply(this, arguments);

      this.setModel(new JSONModel({
        isPhone: Device.system.phone,
        listMode: Device.system.phone ? "None" : "SingleSelectMaster"
      }), "device");

      this.getRouter().initialize();
    }
  });
});
