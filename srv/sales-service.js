const cds = require("@sap/cds");
const fs = require("fs");
const path = require("path");

function readLocalEnv() {
  const envPath = path.join(__dirname, "..", ".env");
  if (!fs.existsSync(envPath)) {
    return {};
  }

  return fs.readFileSync(envPath, "utf8").split(/\r?\n/).reduce((env, line) => {
    const trimmedLine = line.trim();
    if (!trimmedLine || trimmedLine.startsWith("#") || !trimmedLine.includes("=")) {
      return env;
    }

    const separatorIndex = trimmedLine.indexOf("=");
    const key = trimmedLine.slice(0, separatorIndex).trim();
    const value = trimmedLine.slice(separatorIndex + 1).trim().replace(/^["']|["']$/g, "");
    env[key] = value;
    return env;
  }, {});
}

function getRuntimeEnv(name) {
  return readLocalEnv()[name] || process.env[name];
}

const SAP_SANDBOX_APIS = {
  c4cSalesOrders: {
    label: "Commandes clients C4C",
    product: "SAP Cloud for Customer",
    service: "salesorder",
    entitySet: "CustomerOrderCollection",
    path: "CustomerOrderCollection",
    description: "Lecture des commandes clients SAP Cloud for Customer."
  },
  salesOrders: {
    label: "Commandes clients",
    product: "SAP S/4HANA Cloud",
    service: "API_SALES_ORDER_SRV",
    entitySet: "A_SalesOrder",
    description: "Lecture des commandes clients S/4HANA Cloud."
  },
  businessPartners: {
    label: "Clients / Business Partners",
    product: "SAP S/4HANA Cloud",
    service: "API_BUSINESS_PARTNER",
    entitySet: "A_BusinessPartner",
    description: "Lecture des clients et partenaires."
  },
  outboundDeliveries: {
    label: "Livraisons sortantes",
    product: "SAP S/4HANA Cloud",
    service: "API_OUTBOUND_DELIVERY_SRV",
    entitySet: "A_OutbDeliveryHeader",
    description: "Lecture des livraisons sortantes."
  },
  billingDocuments: {
    label: "Documents de facturation",
    product: "SAP S/4HANA Cloud",
    service: "API_BILLING_DOCUMENT_SRV",
    entitySet: "A_BillingDocument",
    description: "Lecture des documents de facturation."
  },
  products: {
    label: "Articles / produits",
    product: "SAP S/4HANA Cloud",
    service: "API_PRODUCT_SRV",
    entitySet: "A_Product",
    description: "Lecture du référentiel articles."
  }
};

function getSapSandboxApiList() {
  return Object.entries(SAP_SANDBOX_APIS).map(([id, api]) => ({
    id,
    label: api.label,
    service: api.service,
    entitySet: api.entitySet,
    method: "GET",
    sandboxUrl: buildSapSandboxUrl(api).toString(),
    description: `${api.product}: ${api.description}`
  }));
}

function buildSapSandboxUrl(api, query) {
  const base = api.path
    ? (getRuntimeEnv("SAP_C4C_SANDBOX_BASE_URL") || "https://sandbox.api.sap.com/sap/c4c/odata/v1/c4codataapi").replace(/\/$/, "")
    : (getRuntimeEnv("SAP_SANDBOX_BASE_URL") || "https://sandbox.api.sap.com/s4hanacloud").replace(/\/$/, "");
  const apiPath = api.path || `sap/opu/odata/sap/${api.service}/${api.entitySet}`;
  const url = new URL(`${base}/${apiPath}`);

  if (query) {
    const params = new URLSearchParams(query.replace(/^\?/, ""));
    params.forEach((value, key) => {
      url.searchParams.set(key, value);
    });
  }

  return url;
}

module.exports = cds.service.impl(async function () {
  const { KpiSnapshots } = cds.entities("sd.sales");

  this.on("dashboardKpis", async () => {
    const rows = await SELECT.from(KpiSnapshots).orderBy("snapshotDate desc").limit(1);
    const snapshot = rows[0];

    if (!snapshot) {
      return {
        monthlyRevenue: 0,
        monthlyRevenueScale: "K",
        currency: "EUR",
        openOrders: 0,
        delayedDeliveries: 0,
        pendingInvoices: 0,
        creditBlockedOrders: 0,
        serviceLevel: 0
      };
    }

    return {
      monthlyRevenue: snapshot.monthlyRevenue,
      monthlyRevenueScale: snapshot.monthlyRevenueScale,
      currency: snapshot.currency,
      openOrders: snapshot.openOrders,
      delayedDeliveries: snapshot.delayedDeliveries,
      pendingInvoices: snapshot.pendingInvoices,
      creditBlockedOrders: snapshot.creditBlockedOrders,
      serviceLevel: snapshot.serviceLevel
    };
  });

  this.on("sapSandboxApis", () => getSapSandboxApiList());

  this.on("callSapSandboxApi", async (req) => {
    const { api: apiId, top, query } = req.data;
    const api = SAP_SANDBOX_APIS[apiId];

    if (!api) {
      req.reject(400, `API SAP Sandbox inconnue: ${apiId}`);
    }

    const apiKey = getRuntimeEnv("SAP_SANDBOX_API_KEY");
    if (!apiKey) {
      req.reject(500, "Variable SAP_SANDBOX_API_KEY manquante pour appeler la SAP Sandbox.");
    }

    const url = buildSapSandboxUrl(api, query);
    if (top && Number.isInteger(top) && top > 0) {
      url.searchParams.set("$top", String(Math.min(top, 100)));
    }

    const response = await fetch(url, {
      headers: {
        APIKey: apiKey,
        apikey: apiKey,
        Accept: "application/json"
      }
    });
    const payload = await response.text();

    if (!response.ok) {
      req.reject(response.status, `Erreur SAP Sandbox ${response.status}: ${payload.slice(0, 500)}`);
    }

    return {
      api: apiId,
      status: response.status,
      sandboxUrl: url.toString(),
      payload
    };
  });
});
