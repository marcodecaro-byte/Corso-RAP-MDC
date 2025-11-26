CLASS zcl_mdc_hello_cloud DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS:
      _m_test
        IMPORTING
                  iv_input       TYPE char3
        RETURNING VALUE(rv_test) TYPE char10.
ENDCLASS.

CLASS zcl_mdc_hello_cloud IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    out->write( _m_test( 'MDC' )  ).
  ENDMETHOD.

  METHOD _m_test.
    rv_test = |Ciao ( iv_input )|.
  ENDMETHOD.
ENDCLASS.
