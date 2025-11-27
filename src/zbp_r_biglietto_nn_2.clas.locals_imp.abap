CLASS lhc_zr_biglietto_nn_2 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Biglietto
        RESULT result,
      earlynumbering_create FOR NUMBERING
        IMPORTING entities FOR CREATE Biglietto,
      CheckStatus FOR VALIDATE ON SAVE
        IMPORTING keys FOR Biglietto~CheckStatus,
      GetDefaultsForCreate FOR READ
        IMPORTING keys FOR FUNCTION Biglietto~GetDefaultsForCreate RESULT result,
      get_instance_features FOR INSTANCE FEATURES
        IMPORTING keys REQUEST requested_features FOR Biglietto RESULT result,
      onSave FOR DETERMINE ON SAVE
        IMPORTING keys FOR Biglietto~onSave,
      CustomDelete FOR MODIFY
        IMPORTING keys FOR ACTION Biglietto~CustomDelete RESULT result.
ENDCLASS.

CLASS lhc_zr_biglietto_nn_2 IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD earlynumbering_create.
    DATA: lv_id TYPE zbiglietto_nn-id_biglietto.
*    WITH +big AS (
*        SELECT MAX(  id_biglietto ) AS max
*        FROM zbiglietto_nn_2
*        UNION
*        SELECT MAX(  idbiglietto ) AS max
*        FROM zbglietto_nn_2_D )
*        SELECT MAX(  max )
*        FROM +big AS big
*        INTO @DATA(lv_max).

    LOOP AT entities
    INTO DATA(ls_entity).
      IF ls_entity-idbiglietto IS INITIAL.
        cl_numberrange_runtime=>number_get(
          EXPORTING
*            ignore_buffer     = 'X'
            nr_range_nr       = '01'
            object            = 'ZID_RANGE'
            quantity          = 1
*    subobject         =
*    toyear            =
         IMPORTING
            number            =  DATA(lv_max)
*    returncode        =
*    returned_quantity =
        ).
**CATCH cx_nr_object_not_found.
**CATCH cx_number_ranges.
        lv_max += 1.
        lv_id = lv_max.
      ELSE.
        lv_id = ls_entity-idbiglietto.
      ENDIF.
      APPEND VALUE #(
        %cid = ls_entity-%cid
        %is_draft = ls_entity-%is_draft
        IdBiglietto = lv_id )
      TO mapped-biglietto.
    ENDLOOP.
  ENDMETHOD.

  METHOD CheckStatus.
    DATA: lt_biglietto TYPE TABLE FOR READ RESULT zr_biglietto_nn_2.
    READ ENTITIES OF zr_biglietto_nn_2 IN LOCAL MODE
    ENTITY Biglietto
    FIELDS (  Stato )
    WITH CORRESPONDING #(  keys )
    RESULT lt_biglietto.

    LOOP AT lt_biglietto
    INTO DATA(ls_biglietto)
    WHERE Stato <> 'BOZZA'.
      APPEND VALUE #( %tky = ls_biglietto-%tky )
      TO failed-biglietto." il FAILED determina errore bloccante; senza diventa WARNING
      APPEND VALUE #(
            %tky = ls_biglietto-%tky
            %msg = NEW zcx_error_bigl_mdc(
                textid = zcx_error_bigl_mdc=>invalid_stat
                iv_stato = ls_biglietto-Stato
                severity = if_abap_behv_message=>severity-error
        )
        %element-Stato = if_abap_behv=>mk-on )
      TO reported-biglietto.
    ENDLOOP.
  ENDMETHOD.

  METHOD GetDefaultsForCreate.
    result = VALUE #( FOR key IN keys (
             %cid = key-%cid
             %param-stato = 'BOZZA'
              ) ).
  ENDMETHOD.

  METHOD get_instance_features.
    DATA:
        ls_result LIKE LINE OF result.
    READ ENTITIES OF zr_biglietto_nn_2
        IN LOCAL MODE
        ENTITY Biglietto
        FIELDS ( Stato )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_biglietto).
    LOOP AT lt_biglietto
            INTO DATA(ls_biglietto).
      CLEAR ls_result.
      ls_result-%tky = ls_biglietto-%tky.
      ls_result-%field-Stato = if_abap_behv=>fc-f-read_only.
      ls_result-%action-CustomDelete = COND #(
        WHEN ls_biglietto-Stato = 'FINALE'
            THEN if_abap_behv=>fc-o-enabled
            ELSE if_abap_behv=>fc-o-disabled ).
      APPEND ls_result
        TO result.
    ENDLOOP.
  ENDMETHOD.

  METHOD onSave.
    DATA:
        lt_update TYPE TABLE FOR UPDATE zr_biglietto_nn_2.
    READ ENTITIES OF zr_biglietto_nn_2 IN LOCAL MODE
    ENTITY Biglietto
    FIELDS (  Stato )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_biglietto).

    LOOP AT lt_biglietto
    INTO DATA(ls_biglietto).
      APPEND VALUE #(
              %tky = ls_biglietto-%tky
              Stato = 'FINALE'
              %control-Stato = if_abap_behv=>mk-on )
              TO lt_update.
    ENDLOOP.

    IF lt_update IS NOT INITIAL.
      MODIFY ENTITIES OF zr_biglietto_nn_2
          IN LOCAL MODE
          ENTITY Biglietto
          UPDATE FROM lt_update.
    ENDIF.
  ENDMETHOD.

  METHOD CustomDelete.
    DATA:
      lt_update TYPE TABLE FOR UPDATE zr_biglietto_nn_2,
      ls_update LIKE LINE OF lt_update.

    READ ENTITIES OF zr_biglietto_nn_2
        IN LOCAL MODE
        ENTITY Biglietto
        ALL FIELDS
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_biglietto).
    LOOP AT lt_biglietto
            ASSIGNING FIELD-SYMBOL(<biglietto>).
      <biglietto>-Stato = 'CANC'.
      APPEND VALUE #(
              %tky = <biglietto>-%tky
              %param = <biglietto> )
          TO result.
      ls_update = CORRESPONDING #( <biglietto> ).
      ls_update-%control-Stato = if_abap_behv=>mk-on.
      APPEND ls_update
        TO lt_update.
    ENDLOOP.

    MODIFY ENTITIES OF zr_biglietto_nn_2
        IN LOCAL MODE
        ENTITY Biglietto
        UPDATE FROM lt_update.
  ENDMETHOD.
ENDCLASS.
