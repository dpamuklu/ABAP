*&---------------------------------------------------------------------*
*& Report ZSIMULATOR_EXAMPLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsimulator_example.

START-OF-SELECTION.

  DATA:out TYPE REF TO if_oo_adt_intrnl_classrun.

  DATA(controller) = NEW zcl_chl_app_controller( ).

  controller->execute( ).
