const path = require("path");
const fs = require("fs");
const os = require("os");
const express = require("express");
const cds = require("@sap/cds");

module.exports = async function (options) {
  const app = express();
  const root = __dirname;
  const frameworkRoot = path.join(os.homedir(), ".ui5", "framework", "packages");

  app.use((req, res, next) => {
    const origin = req.headers.origin;
    if (origin) {
      res.setHeader("Access-Control-Allow-Origin", origin);
      res.setHeader("Access-Control-Allow-Methods", "GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS");
      res.setHeader("Access-Control-Allow-Headers", "accept,authorization,content-type,odata-maxversion,odata-version,x-csrf-token");
    }
    if (req.method === "OPTIONS") {
      res.status(204).end();
      return;
    }
    next();
  });

  app.get("/index.html", (req, res) => {
    res.sendFile(path.join(root, "index.html"));
  });
  app.use("/webapp", express.static(path.join(root, "webapp")));

  [
    "@openui5/sap.ui.core",
    "@openui5/sap.m",
    "@openui5/sap.f",
    "@openui5/sap.ui.layout",
    "@openui5/sap.ui.table",
    "@openui5/sap.ui.unified",
    "@openui5/sap.uxap",
    "@sapui5/sap.viz"
  ].forEach((pkg) => {
    const src = path.join(frameworkRoot, pkg, "1.124.0", "src");
    if (fs.existsSync(src)) {
      app.use("/resources", express.static(src));
    }
  });

  return cds.server({ ...options, app });
};
