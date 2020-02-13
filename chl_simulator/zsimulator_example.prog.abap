*&---------------------------------------------------------------------*
*& Report ZSIMULATOR_EXAMPLE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsimulator_example.

START-OF-SELECTION.

  DATA(controller) = NEW zcl_chl_app_controller( ).

  controller->execute( ).
