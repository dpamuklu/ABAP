CLASS zcl_chl_simulate_consol_viewer DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
  INTERFACES:
    zif_chl_simulator_viewer.
  ALIASES:
    print_qualify  FOR zif_chl_simulator_viewer~print_qualify,
    print_results  FOR zif_chl_simulator_viewer~print_results.
  METHODS:
    constructor
      IMPORTING
        i_out TYPE REF TO if_oo_adt_intrnl_classrun.
PROTECTED SECTION.
PRIVATE SECTION.
  DATA:
    out TYPE REF TO if_oo_adt_intrnl_classrun.
ENDCLASS.

CLASS zcl_chl_simulate_consol_viewer IMPLEMENTATION.
  METHOD print_qualify.
    DATA: lo_object TYPE REF TO zcl_chl_team.

    out->write( '------------------------------------------' ).
    LOOP AT data REFERENCE INTO DATA(lr_team).
      lo_object ?= lr_team->*.
      IF current_level EQ 1.
        out->write( |Congrulations { lo_object->get_name(  ) }! You became a Champion!| ).
      ELSE.
        out->write( lo_object->get_name( ) ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD print_results.
    DATA: lo_object TYPE REF TO zcl_chl_draw.

    LOOP AT data REFERENCE INTO DATA(lr_draw).
      lo_object ?= lr_draw->*.

      CHECK lo_object->info-level EQ current_level.

      IF lo_object->info-first_game IS BOUND.

        out->write( '----------------FIRST_GAME_RESULT----------------' ).

        out->write( |{ lo_object->info-first_team->get_name( ) } {
                       lo_object->info-first_game->get_first_team_score( ) } - {
                       lo_object->info-first_game->get_second_team_score( ) } {
                       lo_object->info-second_team->get_name( ) }| ).
      ENDIF.

      IF lo_object->info-second_game IS BOUND.

        out->write( '----------------SECOND_GAME_RESULT----------------' ).

        out->write( |{ lo_object->info-second_team->get_name( ) } {
                       lo_object->info-second_game->get_first_team_score( ) } - {
                       lo_object->info-second_game->get_second_team_score( ) } {
                       lo_object->info-first_team->get_name( ) }| ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD constructor.
    out = i_out.
  ENDMETHOD.

ENDCLASS.
