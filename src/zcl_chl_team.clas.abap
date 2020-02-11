CLASS zcl_chl_team DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
   INTERFACES:
     zif_chl_team.
   ALIASES: get_name FOR zif_chl_team~get_name,
            get_id   FOR zif_chl_team~get_id.
   METHODS:
     constructor
       IMPORTING
         iv_name TYPE string.
PROTECTED SECTION.
PRIVATE SECTION.
  CLASS-DATA:
    counter  TYPE i.
  DATA:
    id   TYPE i,
    name TYPE string.
ENDCLASS.

CLASS zcl_chl_team IMPLEMENTATION.

  METHOD constructor.
    IF iv_name IS NOT INITIAL.
      counter = counter + 1.
      id = counter.
      name    = iv_name.
    ENDIF.
  ENDMETHOD.

  METHOD zif_chl_team~get_id.
    r_result = id.
  ENDMETHOD.

  METHOD zif_chl_team~get_name.
    r_result = name.
  ENDMETHOD.

ENDCLASS.
