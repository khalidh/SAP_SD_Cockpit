# Fiori Launchpad on ABAP Trial

The SAPUI5 application repository is deployed as:

- UI5 repository: `ZSD_COCKPIT`
- Intent: `#ZSD_COCKPIT-display`
- Launchpad App Descriptor Item: `ZSD_COCKPIT_UI5R`
- Suggested business catalog: `ZBC_SD_COCKPIT`
- Suggested business role: `Z_BR_SD_COCKPIT`

## What is already versioned

The repository contains the UI5 descriptor inbound in `webapp/manifest.json`:

```json
"crossNavigation": {
  "inbounds": {
    "ZSD_COCKPIT-display": {
      "semanticObject": "ZSD_COCKPIT",
      "action": "display",
      "title": "SD Sales Cockpit",
      "subTitle": "Cockpit SAP SD",
      "icon": "sap-icon://sales-order"
    }
  }
}
```

During `fiori deploy`, ABAP converts this inbound to the Launchpad App
Descriptor Item `ZSD_COCKPIT_UI5R`.

## What must be assigned after abapGit import

If the Launchpad shows:

```text
Impossible de corriger la cible de navigation "#ZSD_COCKPIT-display"
```

the UI5 app exists, but the intent is not assigned to the current user through
a business catalog and business role.

In ADT:

1. Create a business catalog named `ZBC_SD_COCKPIT`.
2. Add the Launchpad App Descriptor Item `ZSD_COCKPIT_UI5R`.
3. Activate the business catalog.

In the Fiori Launchpad:

1. Open `Maintain Business Roles`.
2. Create or copy a role named `Z_BR_SD_COCKPIT`.
3. Add business catalog `ZBC_SD_COCKPIT`.
4. Assign the role to your user.

Then open:

```text
https://bb8534dd-13b7-4042-bba9-41728e5288ac.abap-web.us10.hana.ondemand.com/ui#ZSD_COCKPIT-display
```

## abapGit note

The open-source abapGit serializer in this workspace supports the ABAP/RAP
objects under `src/`, but it does not expose a public serializer for ABAP Cloud
IAM business role assignments. Keep the UI5 inbound in Git, import the ABAP
objects with abapGit, then create or reassign the business catalog/role in ADT
and the Launchpad.
