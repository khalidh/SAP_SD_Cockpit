CLASS zcl_sd_demo_data_load DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PRIVATE SECTION.
    CONSTANTS c_user TYPE syuname VALUE 'DEMO_LOAD'.
    CONSTANTS c_changed_at TYPE timestampl VALUE '20260523090000.0000000'.
ENDCLASS.

CLASS zcl_sd_demo_data_load IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA lt_sales_orders TYPE STANDARD TABLE OF zsd_so.
    DATA lt_sales_order_items TYPE STANDARD TABLE OF zsd_so_item.
    DATA lt_process_steps TYPE STANDARD TABLE OF zsd_so_step.
    DATA lt_alerts TYPE STANDARD TABLE OF zsd_alert.
    DATA lt_kpis TYPE STANDARD TABLE OF zsd_kpi.
    DATA lt_top_customers TYPE STANDARD TABLE OF zsd_topcust.
    DATA lt_top_materials TYPE STANDARD TABLE OF zsd_topmat.
    DATA lt_revenue_month TYPE STANDARD TABLE OF zsd_revmon.
    DATA lt_revenue_customer TYPE STANDARD TABLE OF zsd_revcust.
    DATA lt_revenue_sales_org TYPE STANDARD TABLE OF zsd_revsorg.
    DATA lt_operational_trend TYPE STANDARD TABLE OF zsd_optrend.

    lt_sales_orders = VALUE #(
      (
        order_uuid = x'22222222222222222222222222222281'
        order_id = '5000012481'
        sales_doc_type = 'OR - Commande standard'
        customer_id = '10000045'
        customer_name = 'Groupe Nova Retail'
        order_date = '20260502'
        amount = '48600.00'
        currency = 'EUR'
        sales_org = 'FR01'
        distr_channel = '10'
        division = '00'
        status_code = 'PARTIAL'
        status_text = 'Partiellement livrée'
        incoterms = 'DAP Paris'
        payment_terms = '30 jours fin de mois'
        created_by = c_user
        created_at = c_changed_at
        last_changed_by = c_user
        last_changed_at = c_changed_at
      )
      (
        order_uuid = x'22222222222222222222222222222507'
        order_id = '5000012507'
        sales_doc_type = 'OR - Commande standard'
        customer_id = '10000201'
        customer_name = 'Senso Habitat'
        order_date = '20260507'
        amount = '29500.00'
        currency = 'EUR'
        sales_org = 'FR02'
        distr_channel = '20'
        division = '00'
        status_code = 'BLOCKED'
        status_text = 'Bloquée crédit'
        incoterms = 'EXW Marseille'
        payment_terms = 'Paiement comptant'
        created_by = c_user
        created_at = c_changed_at
        last_changed_by = c_user
        last_changed_at = c_changed_at
      )
      (
        order_uuid = x'22222222222222222222222222222553'
        order_id = '5000012553'
        sales_doc_type = 'OR - Commande standard'
        customer_id = '10000072'
        customer_name = 'Atelier Martin Pro'
        order_date = '20260511'
        amount = '18400.00'
        currency = 'EUR'
        sales_org = 'FR01'
        distr_channel = '10'
        division = '01'
        status_code = 'INVOICED'
        status_text = 'Facturée'
        incoterms = 'CPT Lille'
        payment_terms = '45 jours'
        created_by = c_user
        created_at = c_changed_at
        last_changed_by = c_user
        last_changed_at = c_changed_at
      )
      (
        order_uuid = x'22222222222222222222222222222609'
        order_id = '5000012609'
        sales_doc_type = 'OR - Commande standard'
        customer_id = '10000118'
        customer_name = 'Medialux Distribution'
        order_date = '20260516'
        amount = '67200.00'
        currency = 'EUR'
        sales_org = 'DE01'
        distr_channel = '30'
        division = '00'
        status_code = 'OPEN'
        status_text = 'Ouverte'
        incoterms = 'DAP Berlin'
        payment_terms = '30 jours'
        created_by = c_user
        created_at = c_changed_at
        last_changed_by = c_user
        last_changed_at = c_changed_at
      )
    ).

    lt_sales_order_items = VALUE #(
      (
        item_uuid = x'33333333333333333333333333333310'
        parent_uuid = x'22222222222222222222222222222281'
        item_no = '10'
        material = 'MAT-100024'
        description = 'Kit installation premium'
        quantity = 120
        unit = 'PC'
        net_price = '300.00'
        currency = 'EUR'
        discount = 5
        deliv_status_code = 'DELIVERED'
        deliv_status_text = 'Livrée'
        bill_status_code = 'PENDING'
        bill_status_text = 'À facturer'
        last_changed_at = c_changed_at
      )
      (
        item_uuid = x'33333333333333333333333333333320'
        parent_uuid = x'22222222222222222222222222222281'
        item_no = '20'
        material = 'MAT-200481'
        description = 'Module connecté X4'
        quantity = 40
        unit = 'PC'
        net_price = '315.00'
        currency = 'EUR'
        discount = 2
        deliv_status_code = 'PARTIAL'
        deliv_status_text = 'Partielle'
        bill_status_code = 'OPEN'
        bill_status_text = 'Ouverte'
        last_changed_at = c_changed_at
      )
      (
        item_uuid = x'33333333333333333333333333333330'
        parent_uuid = x'22222222222222222222222222222507'
        item_no = '10'
        material = 'MAT-500045'
        description = 'Armoire technique standard'
        quantity = 15
        unit = 'PC'
        net_price = '1450.00'
        currency = 'EUR'
        discount = 0
        deliv_status_code = 'OPEN'
        deliv_status_text = 'Non livrée'
        bill_status_code = 'OPEN'
        bill_status_text = 'Ouverte'
        last_changed_at = c_changed_at
      )
      (
        item_uuid = x'33333333333333333333333333333340'
        parent_uuid = x'22222222222222222222222222222553'
        item_no = '10'
        material = 'MAT-300118'
        description = 'Pack maintenance annuel'
        quantity = 8
        unit = 'PC'
        net_price = '2300.00'
        currency = 'EUR'
        discount = 0
        deliv_status_code = 'DELIVERED'
        deliv_status_text = 'Livrée'
        bill_status_code = 'INVOICED'
        bill_status_text = 'Facturée'
        last_changed_at = c_changed_at
      )
      (
        item_uuid = x'33333333333333333333333333333350'
        parent_uuid = x'22222222222222222222222222222609'
        item_no = '10'
        material = 'MAT-200481'
        description = 'Module connecté X4'
        quantity = 160
        unit = 'PC'
        net_price = '420.00'
        currency = 'EUR'
        discount = 3
        deliv_status_code = 'OPEN'
        deliv_status_text = 'À préparer'
        bill_status_code = 'OPEN'
        bill_status_text = 'Ouverte'
        last_changed_at = c_changed_at
      )
    ).

    lt_process_steps = VALUE #(
      (
        step_uuid = x'AAAAAAAA111111111111111111111001'
        parent_uuid = x'22222222222222222222222222222281'
        step_at = '20260502091200.0000000'
        title = 'Commande créée'
        description = 'VA01 - Commande standard enregistrée'
        owner = 'ADV Lyon'
        icon = 'sap-icon://sales-order'
        sequence = 10
      )
      (
        step_uuid = x'AAAAAAAA111111111111111111111002'
        parent_uuid = x'22222222222222222222222222222281'
        step_at = '20260504154000.0000000'
        title = 'Livraison partielle'
        description = 'VL01N - Livraison 8000048120'
        owner = 'Logistique'
        icon = 'sap-icon://shipping-status'
        sequence = 20
      )
      (
        step_uuid = x'AAAAAAAA111111111111111111111003'
        parent_uuid = x'22222222222222222222222222222281'
        step_at = '20260505110500.0000000'
        title = 'Sortie marchandise'
        description = 'Post Goods Issue partiel'
        owner = 'Entrepôt FR01'
        icon = 'sap-icon://inventory'
        sequence = 30
      )
      (
        step_uuid = x'AAAAAAAA222222222222222222222001'
        parent_uuid = x'22222222222222222222222222222507'
        step_at = '20260507102100.0000000'
        title = 'Commande créée'
        description = 'Contrôle crédit déclenché automatiquement'
        owner = 'ADV Sud'
        icon = 'sap-icon://sales-order'
        sequence = 10
      )
      (
        step_uuid = x'AAAAAAAA222222222222222222222002'
        parent_uuid = x'22222222222222222222222222222507'
        step_at = '20260507102200.0000000'
        title = 'Blocage crédit'
        description = 'Horizon de crédit dépassé'
        owner = 'Crédit management'
        icon = 'sap-icon://credit-card'
        sequence = 20
      )
      (
        step_uuid = x'AAAAAAAA333333333333333333333001'
        parent_uuid = x'22222222222222222222222222222553'
        step_at = '20260511083600.0000000'
        title = 'Commande créée'
        description = 'VA01 - Commande service'
        owner = 'ADV Paris'
        icon = 'sap-icon://sales-order'
        sequence = 10
      )
      (
        step_uuid = x'AAAAAAAA333333333333333333333002'
        parent_uuid = x'22222222222222222222222222222553'
        step_at = '20260512141000.0000000'
        title = 'Facture créée'
        description = 'VF01 - Facture 9000084127'
        owner = 'Facturation'
        icon = 'sap-icon://customer-financial-fact-sheet'
        sequence = 20
      )
      (
        step_uuid = x'AAAAAAAA333333333333333333333003'
        parent_uuid = x'22222222222222222222222222222553'
        step_at = '20260518090000.0000000'
        title = 'Paiement reçu'
        description = 'Rapprochement bancaire effectué'
        owner = 'Comptabilité'
        icon = 'sap-icon://payment-approval'
        sequence = 30
      )
      (
        step_uuid = x'AAAAAAAA444444444444444444444001'
        parent_uuid = x'22222222222222222222222222222609'
        step_at = '20260516164400.0000000'
        title = 'Commande créée'
        description = 'Disponibilité ATP confirmée partiellement'
        owner = 'Inside Sales'
        icon = 'sap-icon://sales-order'
        sequence = 10
      )
    ).

    lt_alerts = VALUE #(
      (
        alert_uuid = x'44444444444444444444444444444001'
        alert_id = 'A-1001'
        alert_type = 'CREDIT_BLOCK'
        type_text = 'Blocage crédit'
        severity = 'Error'
        status_text = 'Bloqué'
        process_status = 'OPEN'
        title = 'Commande bloquée par contrôle crédit'
        reference = '5000012507'
        customer_name = 'Senso Habitat'
        due_date = '20260523'
        owner = 'Crédit management'
        assignee = 'Nadia ADV'
        comment_text = 'Contrôler limite et encours avant libération'
        resolved_at = 0
        amount = '29500.00'
        currency = 'EUR'
        created_by = c_user
        created_at = c_changed_at
        last_changed_by = c_user
        last_changed_at = c_changed_at
      )
      (
        alert_uuid = x'44444444444444444444444444444002'
        alert_id = 'A-1002'
        alert_type = 'DELIVERY_DELAY'
        type_text = 'Livraison en retard'
        severity = 'Error'
        status_text = 'En retard'
        process_status = 'IN_PROGRESS'
        title = 'Livraison non sortie marchandise'
        reference = '8000048152'
        customer_name = 'Medialux Distribution'
        due_date = '20260521'
        owner = 'Logistique DE01'
        assignee = 'Karim Logistique'
        comment_text = 'Relance entrepôt en cours'
        resolved_at = 0
        amount = '67200.00'
        currency = 'EUR'
        created_by = c_user
        created_at = c_changed_at
        last_changed_by = c_user
        last_changed_at = c_changed_at
      )
      (
        alert_uuid = x'44444444444444444444444444444003'
        alert_id = 'A-1003'
        alert_type = 'STOCK_SHORTAGE'
        type_text = 'Rupture de stock'
        severity = 'Warning'
        status_text = 'À surveiller'
        process_status = 'OPEN'
        title = 'ATP insuffisant pour module X4'
        reference = 'MAT-200481'
        customer_name = 'Groupe Nova Retail'
        due_date = '20260527'
        owner = 'Approvisionnement'
        assignee = 'Sofia Supply'
        comment_text = 'Proposition de livraison partielle à valider'
        resolved_at = 0
        amount = '0.00'
        currency = 'PC'
        created_by = c_user
        created_at = c_changed_at
        last_changed_by = c_user
        last_changed_at = c_changed_at
      )
      (
        alert_uuid = x'44444444444444444444444444444004'
        alert_id = 'A-1004'
        alert_type = 'BILLING_PENDING'
        type_text = 'Facture non générée'
        severity = 'Warning'
        status_text = 'À facturer'
        process_status = 'OPEN'
        title = 'Livraison facturable sans facture'
        reference = '8000048120'
        customer_name = 'Groupe Nova Retail'
        due_date = '20260524'
        owner = 'Facturation'
        assignee = 'Mehdi Facturation'
        comment_text = 'Vérifier blocage facture avant VF01'
        resolved_at = 0
        amount = '36000.00'
        currency = 'EUR'
        created_by = c_user
        created_at = c_changed_at
        last_changed_by = c_user
        last_changed_at = c_changed_at
      )
      (
        alert_uuid = x'44444444444444444444444444444005'
        alert_id = 'A-1005'
        alert_type = 'CREDIT_EXCEEDED'
        type_text = 'Dépassement crédit'
        severity = 'Error'
        status_text = 'Critique'
        process_status = 'IN_PROGRESS'
        title = 'Encours client au-dessus de la limite'
        reference = '10000201'
        customer_name = 'Senso Habitat'
        due_date = '20260523'
        owner = 'Crédit management'
        assignee = 'Nadia ADV'
        comment_text = 'Demande d''acompte transmise au commercial'
        resolved_at = 0
        amount = '118000.00'
        currency = 'EUR'
        created_by = c_user
        created_at = c_changed_at
        last_changed_by = c_user
        last_changed_at = c_changed_at
      )
    ).

    lt_kpis = VALUE #(
      (
        snapshot_uuid = x'11111111111111111111111111111111'
        snapshot_date = '20260523'
        monthly_revenue = '842.00'
        monthly_revenue_scale = 'K'
        open_orders = 128
        delayed_deliveries = 17
        pending_invoices = 36
        credit_blocked_orders = 9
        service_level = '94.60'
        currency = 'EUR'
      )
    ).

    lt_top_customers = VALUE #(
      (
        topcust_uuid = x'99999999111111111111111111111001'
        customer_id = '10000045'
        customer_name = 'Groupe Nova Retail'
        revenue = '184500.00'
        currency = 'EUR'
        orders_count = 28
        trend = 'Hausse'
        trend_status = 'OK'
      )
      (
        topcust_uuid = x'99999999111111111111111111111002'
        customer_id = '10000072'
        customer_name = 'Atelier Martin Pro'
        revenue = '142800.00'
        currency = 'EUR'
        orders_count = 19
        trend = 'Stable'
        trend_status = 'OPEN'
      )
      (
        topcust_uuid = x'99999999111111111111111111111003'
        customer_id = '10000118'
        customer_name = 'Medialux Distribution'
        revenue = '98600.00'
        currency = 'EUR'
        orders_count = 14
        trend = 'Attention'
        trend_status = 'PARTIAL'
      )
      (
        topcust_uuid = x'99999999111111111111111111111004'
        customer_id = '10000201'
        customer_name = 'Senso Habitat'
        revenue = '76300.00'
        currency = 'EUR'
        orders_count = 11
        trend = 'Risque crédit'
        trend_status = 'BLOCKED'
      )
    ).

    lt_top_materials = VALUE #(
      (
        topmat_uuid = x'99999999222222222222222222222001'
        material = 'MAT-100024'
        description = 'Kit installation premium'
        category = 'Accessoires'
        quantity = 420
        revenue = '126000.00'
        currency = 'EUR'
      )
      (
        topmat_uuid = x'99999999222222222222222222222002'
        material = 'MAT-200481'
        description = 'Module connecté X4'
        category = 'Électronique'
        quantity = 310
        revenue = '118900.00'
        currency = 'EUR'
      )
      (
        topmat_uuid = x'99999999222222222222222222222003'
        material = 'MAT-300118'
        description = 'Pack maintenance annuel'
        category = 'Service'
        quantity = 86
        revenue = '77400.00'
        currency = 'EUR'
      )
      (
        topmat_uuid = x'99999999222222222222222222222004'
        material = 'MAT-500045'
        description = 'Armoire technique standard'
        category = 'Équipement'
        quantity = 52
        revenue = '68100.00'
        currency = 'EUR'
      )
    ).

    lt_revenue_month = VALUE #(
      (
        revmon_uuid = x'55555555555555555555555555555001'
        month_text = 'Jan'
        revenue = '610000.00'
        currency = 'EUR'
        sort_no = 1
      )
      (
        revmon_uuid = x'55555555555555555555555555555002'
        month_text = 'Fév'
        revenue = '690000.00'
        currency = 'EUR'
        sort_no = 2
      )
      (
        revmon_uuid = x'55555555555555555555555555555003'
        month_text = 'Mar'
        revenue = '735000.00'
        currency = 'EUR'
        sort_no = 3
      )
      (
        revmon_uuid = x'55555555555555555555555555555004'
        month_text = 'Avr'
        revenue = '804000.00'
        currency = 'EUR'
        sort_no = 4
      )
      (
        revmon_uuid = x'55555555555555555555555555555005'
        month_text = 'Mai'
        revenue = '842000.00'
        currency = 'EUR'
        sort_no = 5
      )
    ).

    lt_revenue_customer = VALUE #(
      (
        revcust_uuid = x'66666666666666666666666666666001'
        customer_name = 'Nova Retail'
        revenue = '184500.00'
        currency = 'EUR'
      )
      (
        revcust_uuid = x'66666666666666666666666666666002'
        customer_name = 'Atelier Martin'
        revenue = '142800.00'
        currency = 'EUR'
      )
      (
        revcust_uuid = x'66666666666666666666666666666003'
        customer_name = 'Medialux'
        revenue = '98600.00'
        currency = 'EUR'
      )
      (
        revcust_uuid = x'66666666666666666666666666666004'
        customer_name = 'Senso Habitat'
        revenue = '76300.00'
        currency = 'EUR'
      )
    ).

    lt_revenue_sales_org = VALUE #(
      (
        revsorg_uuid = x'77777777777777777777777777777001'
        sales_org = 'FR01'
        revenue = '482000.00'
        currency = 'EUR'
      )
      (
        revsorg_uuid = x'77777777777777777777777777777002'
        sales_org = 'FR02'
        revenue = '214000.00'
        currency = 'EUR'
      )
      (
        revsorg_uuid = x'77777777777777777777777777777003'
        sales_org = 'DE01'
        revenue = '146000.00'
        currency = 'EUR'
      )
    ).

    lt_operational_trend = VALUE #(
      (
        optrend_uuid = x'88888888888888888888888888888001'
        week_text = 'S18'
        delays = 8
        open_orders = 96
      )
      (
        optrend_uuid = x'88888888888888888888888888888002'
        week_text = 'S19'
        delays = 11
        open_orders = 108
      )
      (
        optrend_uuid = x'88888888888888888888888888888003'
        week_text = 'S20'
        delays = 17
        open_orders = 128
      )
      (
        optrend_uuid = x'88888888888888888888888888888004'
        week_text = 'S21'
        delays = 13
        open_orders = 117
      )
    ).

    DELETE FROM zsd_so_step.
    DELETE FROM zsd_so_item.
    DELETE FROM zsd_alert.
    DELETE FROM zsd_kpi.
    DELETE FROM zsd_topcust.
    DELETE FROM zsd_topmat.
    DELETE FROM zsd_revmon.
    DELETE FROM zsd_revcust.
    DELETE FROM zsd_revsorg.
    DELETE FROM zsd_optrend.
    DELETE FROM zsd_so.

    INSERT zsd_so FROM TABLE @lt_sales_orders.
    INSERT zsd_so_item FROM TABLE @lt_sales_order_items.
    INSERT zsd_so_step FROM TABLE @lt_process_steps.
    INSERT zsd_alert FROM TABLE @lt_alerts.
    INSERT zsd_kpi FROM TABLE @lt_kpis.
    INSERT zsd_topcust FROM TABLE @lt_top_customers.
    INSERT zsd_topmat FROM TABLE @lt_top_materials.
    INSERT zsd_revmon FROM TABLE @lt_revenue_month.
    INSERT zsd_revcust FROM TABLE @lt_revenue_customer.
    INSERT zsd_revsorg FROM TABLE @lt_revenue_sales_org.
    INSERT zsd_optrend FROM TABLE @lt_operational_trend.

    COMMIT WORK.

    out->write( |Données de démonstration SD rechargées.| ).
    out->write( |Commandes : { lines( lt_sales_orders ) }| ).
    out->write( |Postes : { lines( lt_sales_order_items ) }| ).
    out->write( |Etapes : { lines( lt_process_steps ) }| ).
    out->write( |Alertes : { lines( lt_alerts ) }| ).
  ENDMETHOD.
ENDCLASS.
