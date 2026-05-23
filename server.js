const path = require("path");
const express = require("express");
const cds = require("@sap/cds");

module.exports = async function (options) {
  const app = express();
  const root = __dirname;

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

  return cds.server({ ...options, app });
};
