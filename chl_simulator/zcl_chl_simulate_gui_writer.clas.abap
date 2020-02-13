CLASS zcl_chl_simulate_gui_writer DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES:
      zif_chl_simulator_viewer.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_chl_simulate_gui_writer IMPLEMENTATION.
  METHOD zif_chl_simulator_viewer~print_qualify.
    DATA: lo_object TYPE REF TO zcl_chl_team.

    WRITE |------------------------------------------|.
    NEW-LINE.
    WRITE |WINNERS:|.
    LOOP AT data REFERENCE INTO DATA(lr_team).
      lo_object ?= lr_team->*.
      IF current_level EQ 1.
        WRITE |Congrulations { lo_object->get_name(  ) }! You became a Champion!| .
      ELSE.
        WRITE lo_object->get_name( ).
      ENDIF.
    ENDLOOP.
    SKIP.
    SKIP.
  ENDMETHOD.

  METHOD zif_chl_simulator_viewer~print_results.
    DATA: lo_object TYPE REF TO zcl_chl_draw.

    LOOP AT data REFERENCE INTO DATA(lr_draw).
      lo_object ?= lr_draw->*.

      CHECK lo_object->info-level EQ current_level.

      IF lo_object->info-first_game IS BOUND.

        NEW-LINE.
        WRITE `----------------FIRST_GAME_RESULT----------------`.
        NEW-LINE.

        WRITE |{ lo_object->info-first_team->get_name( ) } {
                 lo_object->info-first_game->get_first_team_score( ) } - {
                 lo_object->info-first_game->get_second_team_score( ) } {
                 lo_object->info-second_team->get_name( ) }| .

        NEW-LINE.
      ENDIF.

      IF lo_object->info-second_game IS BOUND.

        NEW-LINE.
        WRITE `----------------SECOND_GAME_RESULT----------------`.
        NEW-LINE.

        WRITE |{ lo_object->info-second_team->get_name( ) } {
                 lo_object->info-second_game->get_first_team_score( ) } - {
                 lo_object->info-second_game->get_second_team_score( ) } {
                 lo_object->info-first_team->get_name( ) }| .

        NEW-LINE.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
