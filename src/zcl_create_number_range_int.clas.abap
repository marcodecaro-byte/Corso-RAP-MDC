CLASS zcl_create_number_range_int DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_create_number_range_int IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA: lv_object   TYPE cl_numberrange_objects=>nr_attributes-object,
          lt_interval TYPE cl_numberrange_intervals=>nr_interval,
          ls_interval TYPE cl_numberrange_intervals=>nr_nriv_line.

    lv_object = 'ZID_RANGE'.

*   intervals
    ls_interval-nrrangenr  = '01'.
    ls_interval-fromnumber = '0000000004'.
    ls_interval-tonumber   = '1999999999'.
    ls_interval-procind    = 'I'.
    APPEND ls_interval TO lt_interval.

    ls_interval-nrrangenr  = '02'.
    ls_interval-fromnumber = '2000000000'.
    ls_interval-tonumber   = '2999999999'.
    APPEND ls_interval TO lt_interval.

*   create intervals
    TRY.

        out->write( |Create Intervals for Object: { lv_object } | ).

        CALL METHOD cl_numberrange_intervals=>create
          EXPORTING
            interval  = lt_interval
            object    = lv_object
            subobject = ' '
          IMPORTING
            error     = DATA(lv_error)
            error_inf = DATA(ls_error)
            error_iv  = DATA(lt_error_iv)
            warning   = DATA(lv_warning).
      CATCH cx_nr_object_not_found INTO DATA(lo_exec).

    ENDTRY.
  ENDMETHOD.
ENDCLASS.
