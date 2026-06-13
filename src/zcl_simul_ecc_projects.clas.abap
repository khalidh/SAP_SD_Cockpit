*" Dernière modification : 2026-06-13 20:49:25 CEST
"! Classe de simulation pour créer ou mettre à jour un projet via le BO RAP.
"! Elle évite les écritures SQL directes afin de rester alignée avec le modèle SAP BTP ABAP Cloud.
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

    " 1. Données de test pour la simulation console
    DATA(lv_p_id)   = '00000001'.
    DATA lv_p_name TYPE zi_project-Name VALUE 'Projet Test ECC via Console' ##NO_TEXT.
    DATA(lv_p_budg) = 150000.  " Supérieur à 100 000 -> Devrait passer à 'A'
    DATA(lv_p_curr) = 'EUR'.
    DATA(lv_status) = COND zi_project-Status( WHEN lv_p_budg > 100000 THEN 'A' ELSE 'N' ).
    DATA lv_cid TYPE string VALUE 'PROJECT_1' ##NO_TEXT.

    " 2. Lecture par EML pour décider entre création et mise à jour via le BO RAP
    READ ENTITIES OF zi_project
      ENTITY Project
      FIELDS ( ProjectID )
      WITH VALUE #( ( ProjectID = lv_p_id ) )
      RESULT DATA(existing_projects)
      FAILED DATA(failed_read).

    IF failed_read IS NOT INITIAL.
      out->write( |[ERREUR] Lecture RAP impossible.| ) ##NO_TEXT.
      RETURN.
    ENDIF.

    IF existing_projects IS INITIAL.
      MODIFY ENTITIES OF zi_project
        ENTITY Project
        CREATE FIELDS ( ProjectID Name Budget Currency Status )
        WITH VALUE #( ( %cid      = lv_cid
                        ProjectID = lv_p_id
                        Name      = lv_p_name
                        Budget    = lv_p_budg
                        Currency  = lv_p_curr
                        Status    = lv_status ) )
        FAILED DATA(failed_create).

      IF failed_create IS NOT INITIAL.
        out->write( |[ERREUR] Création RAP impossible.| ) ##NO_TEXT.
        RETURN.
      ENDIF.
    ELSE.
      MODIFY ENTITIES OF zi_project
        ENTITY Project
        UPDATE FIELDS ( Name Budget Currency Status )
        WITH VALUE #( ( ProjectID = lv_p_id
                        Name      = lv_p_name
                        Budget    = lv_p_budg
                        Currency  = lv_p_curr
                        Status    = lv_status ) )
        FAILED DATA(failed_update).

      IF failed_update IS NOT INITIAL.
        out->write( |[ERREUR] Mise à jour RAP impossible.| ) ##NO_TEXT.
        RETURN.
      ENDIF.
    ENDIF.

    COMMIT ENTITIES
      RESPONSE OF zi_project
      FAILED DATA(failed_commit).

    IF failed_commit IS INITIAL.
      out->write( |[SUCCÈS] Projet enregistré via RAP.| ) ##NO_TEXT.
      out->write( |ID     : { lv_p_id }| ) ##NO_TEXT.
      out->write( |Statut : { lv_status } (Calculé en fonction du budget)| ) ##NO_TEXT.
    ELSE.
      out->write( |[ERREUR] Commit RAP impossible.| ) ##NO_TEXT.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
