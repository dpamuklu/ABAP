*"* use this source file for your ABAP unit test classes
CLASS ltc_team DEFINITION FOR TESTING
                          DURATION SHORT
                          RISK LEVEL HARMLESS.
PUBLIC SECTION.
PROTECTED SECTION.
PRIVATE SECTION.
   DATA:
     cut TYPE REF TO zif_chl_team.
   METHODS:
     different_id_exp_for_multi FOR TESTING.
ENDCLASS.

CLASS ltc_team IMPLEMENTATION.

  METHOD different_id_exp_for_multi.
    "given
    DATA: lo_madrid    TYPE REF TO zcl_chl_team,
          lo_barcelona TYPE REF TO zcl_chl_team.

    lo_madrid    = NEW #( iv_name = 'Madrid'  ).
    lo_barcelona = NEW #( iv_name = 'Barcelona' ).

  "when
    cut ?= lo_madrid.
    DATA(lv_name_madrid) = cut->get_name(  ).
    DATA(lv_id_madrid)   = cut->get_id( ).

    cut ?= lo_barcelona.
    DATA(lv_name_barcelona) = cut->get_name(  ).
    DATA(lv_id_barcelona)   = cut->get_id( ).

  "then
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_name_madrid
        exp                  = 'Madrid' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_id_madrid
        exp                  = 1 ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_name_barcelona
        exp                  = 'Barcelona' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_id_barcelona
        exp                  = 2 ).

  ENDMETHOD.

ENDCLASS.
