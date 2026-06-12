sap.ui.define([], function () {
  "use strict";

  var DEFAULT_SERVICE_URL = "http://localhost:4004/odata/v4/sd/";
  var STORAGE_KEY = "sd.sales.cockpit.serviceUrl";

  function normalizeServiceUrl(sUrl) {
    if (!sUrl) {
      return DEFAULT_SERVICE_URL;
    }
    return sUrl.slice(-1) === "/" ? sUrl : sUrl + "/";
  }

  function readQueryServiceUrl() {
    var oParams = new URLSearchParams(window.location.search);
    return oParams.get("serviceUrl");
  }

  function getServiceUrl() {
    var sQueryUrl = readQueryServiceUrl();

    if (sQueryUrl) {
      window.localStorage.setItem(STORAGE_KEY, sQueryUrl);
      return normalizeServiceUrl(sQueryUrl);
    }

    return normalizeServiceUrl(window.localStorage.getItem(STORAGE_KEY));
  }

  function buildUrl(sResourcePath) {
    return getServiceUrl() + sResourcePath.replace(/^\//, "");
  }

  return {
    getServiceUrl: getServiceUrl,
    buildUrl: buildUrl
  };
});
