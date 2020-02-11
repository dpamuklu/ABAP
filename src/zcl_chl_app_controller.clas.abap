CLASS zcl_chl_app_controller DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
  INTERFACES:
    if_oo_adt_classrun.
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.

CLASS zcl_chl_app_controller IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA(lo_simulator) = NEW zcl_chl_simulator( ).

    lo_simulator->set_initial_teams( ).
    lo_simulator->create_draws( ).
    lo_simulator->play_first_game( ).
    lo_simulator->play_second_game( ).

    DATA(lo_viewer) = NEW zcl_chl_simulate_consol_viewer( i_out = out ).
    lo_viewer->print_results(
      EXPORTING
        data          = lo_simulator->get_draws(  )
        current_level = lo_simulator->get_current_level( )  ).

    DATA(result) = lo_simulator->get_qualified_teams( ).

    lo_viewer->print_qualify(
      EXPORTING
        data          = lo_simulator->get_qualified_teams( )
        current_level = lo_simulator->get_current_level(  ) ).

    DO .
      IF lo_simulator->get_current_level( ) EQ 1.
        EXIT.
      ENDIF.

      lo_simulator->create_draws_next( ).
      lo_simulator->play_first_game( ).
      lo_simulator->play_second_game( ).

      lo_viewer->print_results(
        EXPORTING
          data          = lo_simulator->get_draws(  )
          current_level = lo_simulator->get_current_level( )  ).

      lo_viewer->print_qualify(
        EXPORTING
          data          = lo_simulator->get_qualified_teams( )
          current_level = lo_simulator->get_current_level(  ) ).
    ENDDO.

  ENDMETHOD.
ENDCLASS.
