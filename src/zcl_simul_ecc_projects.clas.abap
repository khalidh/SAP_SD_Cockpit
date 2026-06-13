*" Dernière modification : 2026-06-13 20:30:42 CEST
CLASS zcl_simul_ecc_projects DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    " C'est cette interface qui rend la classe exécutable via la touche F9
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_simul_ecc_projects IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " 1. SIMULATION DE L'ÉCRAN DE SÉLECTION (Simule PARAMETERS en ECC)
    DATA(lv_p_id)   = '00000001'.
    DATA lv_p_name TYPE zprojects_rap-name VALUE 'Projet Test ECC via Console' ##NO_TEXT.
    DATA(lv_p_budg) = 150000.  " Supérieur à 100 000 -> Devrait passer à 'A'
    DATA(lv_p_curr) = 'EUR'.

    " Structure locale pour préparer l'enregistrement
    DATA: wa_project TYPE zprojects_rap. " On pointe sur la table créée sur BTP

    " 2. LOGIQUE MÉTIER (Copie conforme du style procédural ECC)
    wa_project-proj_id  = lv_p_id.
    wa_project-name     = lv_p_name.
    wa_project-budget   = lv_p_budg.
    wa_project-currency = lv_p_curr.

    IF wa_project-budget > 100000.
      wa_project-status = 'A'. " Actif
    ELSE.
      wa_project-status = 'N'. " Nouveau
    ENDIF.

    " 3. INSCRIPTION DIRECTE EN BASE (Interdit en RAP, mais toléré ici pour simuler l'ECC)
    " On nettoie la table avant pour le test
    DELETE FROM zprojects_rap WHERE proj_id = @lv_p_id.

    INSERT zprojects_rap FROM @wa_project.

    " 4. AFFICHAGE DU RÉSULTAT (Simule l'instruction WRITE de l'ECC)
    " L'objet 'out' est fourni nativement par l'interface pour écrire dans la console
    IF sy-subrc = 0.
      out->write( |[SUCCÈS] Projet enregistré dans la table !| ) ##NO_TEXT.
      out->write( |ID     : { wa_project-proj_id }| ) ##NO_TEXT.
      out->write( |Statut : { wa_project-status } (Calculé en fonction du budget)| ) ##NO_TEXT.
    ELSE.
      out->write( |[ERREUR] Impossible d'insérer le projet.| ) ##NO_TEXT.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
