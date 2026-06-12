# RAP backend objects for SD Sales Cockpit

This folder contains ABAP/RAP objects intended to mirror the local CAP service in
`db/schema.cds` and `srv/sales-service.cds`.

The target package can be named `ZSD_SALES_COCKPIT`. The repository `.abapgit.xml`
already points abapGit to `/src/`.

## Object model

- Transparent tables: `ZSD_SO`, `ZSD_SO_ITEM`, `ZSD_SO_STEP`, `ZSD_ALERT`,
  `ZSD_KPI`, `ZSD_TOPCUST`, `ZSD_TOPMAT`, `ZSD_REVMON`, `ZSD_REVCUST`,
  `ZSD_REVSORG`, `ZSD_OPTREND`
- Read-only CDS views for sales orders, alerts, KPI and analytical datasets
- Service definition: `ZSD_SALES_COCKPIT`
- OData V4 service binding metadata: `ZSD_SALES_COCKPIT_O4`
- UI annotations on the `ZC_*` projections for Fiori Elements previews and
  generated RAP applications.

## Activation order

1. Activate the `ZSD_*` transparent tables first.
2. Activate interface CDS views `ZI_*`.
3. Activate projection CDS views `ZC_*`.
4. Activate service definition `ZSD_SALES_COCKPIT`.
5. Activate and publish service binding `ZSD_SALES_COCKPIT_O4`.
6. Assign the UI5 Launchpad App Descriptor Item `ZSD_COCKPIT_UI5R` to a
   business catalog and business role.

The cockpit-oriented Fiori Elements mapping is documented in
`docs/rap-fiori-elements-screen.md`.

The freestyle UI5 Launchpad assignment is documented in
`docs/launchpad-abap-trial.md`.

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

After publishing the service binding, point `webapp/manifest.json` from the CAP
URL to the ABAP OData V4 URL, for example:

`/sap/opu/odata4/sap/zsd_sales_cockpit/srvd/sap/zsd_sales_cockpit/0001/`

For the deployed freestyle UI5 app, ABAP creates or updates the Launchpad App
Descriptor Item `ZSD_COCKPIT_UI5R` from the manifest inbound
`ZSD_COCKPIT-display`. Add it to a business catalog such as `ZBC_SD_COCKPIT`,
then assign that catalog to a business role such as `Z_BR_SD_COCKPIT`.
