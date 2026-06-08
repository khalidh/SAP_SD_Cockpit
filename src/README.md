# RAP backend objects for SD Sales Cockpit

This folder contains ABAP/RAP objects intended to mirror the local CAP service in
`db/schema.cds` and `srv/sales-service.cds`.

The target package can be named `ZSD_SALES_COCKPIT`. The repository `.abapgit.xml`
already points abapGit to `/src/`.

## Object model

- Transparent tables: `ZSD_SO`, `ZSD_SO_ITEM`, `ZSD_SO_STEP`, `ZSD_ALERT`,
  `ZSD_KPI`, `ZSD_TOPCUST`, `ZSD_TOPMAT`, `ZSD_REVMON`, `ZSD_REVCUST`,
  `ZSD_REVSORG`, `ZSD_OPTREND`
- Transactional RAP BO: `ZI_SD_SALES_ORDER` with items and process steps
- Transactional RAP BO: `ZI_SD_ALERT`
- Read-only CDS views: KPI and analytical datasets
- Service definition: `ZSD_SALES_COCKPIT`
- OData V4 service binding metadata: `ZSD_SALES_COCKPIT_O4`

## Activation order

1. Activate the `ZSD_*` transparent tables first.
2. Activate interface CDS views `ZI_*`.
3. Activate projection CDS views `ZC_*`.
4. Activate behavior definitions `ZI_SD_SALES_ORDER`, `ZC_SD_SALES_ORDER`,
   `ZI_SD_ALERT`, `ZC_SD_ALERT`.
5. Activate behavior pool classes `ZBP_I_SD_SALES_ORDER` and `ZBP_I_SD_ALERT`.
6. Activate service definition `ZSD_SALES_COCKPIT`.
7. Publish service binding `ZSD_SALES_COCKPIT_O4`.

## Notes

The `ZSD_*` database tables are delivered as classic abapGit `TABL` XML objects.
If these objects are not active, every `ZI_SD_*` view that selects from `ZSD_*`
will fail with "data source does not exist or is not active".

If ADT only shows activation errors for `ZI_SD_*` and `ZC_SD_*`, first check
that the `TABL` objects `ZSD_SO`, `ZSD_SO_ITEM`, `ZSD_SO_STEP`, `ZSD_ALERT`,
`ZSD_KPI`, `ZSD_TOPCUST`, `ZSD_TOPMAT`, `ZSD_REVMON`, `ZSD_REVCUST`,
`ZSD_REVSORG`, and `ZSD_OPTREND` exist in the target package and are active.
Do not copy only the `*.asddls` files into ADT; import the repository with
abapGit so that the `*.tabl.xml` table objects are created too.

Errors for `ZC_CUSTOMER`, `ZI_TRAVEL`, `ZI_BOOKING`, or
`ZI_BOOKING_SUPPLEMENT` are not part of this SD cockpit backend. They belong to
other RAP sample objects in the same system or activation request and should be
fixed or removed from the request separately.

After publishing the service binding, point `webapp/manifest.json` from the CAP
URL to the ABAP OData V4 URL, for example:

`/sap/opu/odata4/sap/zsd_sales_cockpit/srvd/sap/zsd_sales_cockpit/0001/`
