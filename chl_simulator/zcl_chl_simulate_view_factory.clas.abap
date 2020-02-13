CLASS zcl_chl_simulate_view_factory DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS get_instance
      IMPORTING
        out             TYPE any
      RETURNING
        VALUE(r_result) TYPE REF TO zif_chl_simulator_viewer.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_chl_simulate_view_factory IMPLEMENTATION.

  METHOD get_instance.
    r_result = COND #( WHEN out IS NOT INITIAL
                       THEN NEW zcl_chl_simulate_consol_viewer( i_out = out )
                       WHEN out IS INITIAL
                       THEN NEW zcl_chl_simulate_gui_writer(  ) ).
  ENDMETHOD.

ENDCLASS.
