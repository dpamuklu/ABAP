*"* use this source file for your ABAP unit test classes
CLASS ltc_simulator DEFINITION FOR TESTING
                               RISK LEVEL HARMLESS
                               DURATION SHORT.
PUBLIC SECTION.
PROTECTED SECTION.
PRIVATE SECTION.
  DATA:
    cut TYPE REF TO zif_chl_simulator.
  METHODS:
    qualified_teams_are_correct FOR TESTING.
ENDCLASS.

CLASS ltc_simulator_inj DEFINITION.
PUBLIC SECTION.
  INTERFACES:
    zif_chl_simulator.
  ALIASES:
    tt_team       FOR zif_chl_simulator~tt_team,
    tt_team_names FOR zif_chl_simulator~tt_team_names,
    tt_draw       FOR zif_chl_simulator~tt_draw.
PROTECTED SECTION.
PRIVATE SECTION.
  DATA:
    initial_teams TYPE tt_team_names,
    teams         TYPE tt_team,
    draws         TYPE tt_draw,
    current_level TYPE i VALUE 4,
    initial_draw  TYPE boolean VALUE abap_true.
ENDCLASS.


CLASS ltc_simulator IMPLEMENTATION.

  METHOD qualified_teams_are_correct.
    "given
    DATA: lt_teams_exp TYPE zif_chl_simulator=>tt_team.

    DATA(lo_besiktas) = NEW zcl_chl_team( iv_name = 'Galatasaray' ).
    INSERT lo_besiktas INTO TABLE lt_teams_exp.

    DATA(lo_galatasaray) = NEW zcl_chl_team( iv_name = 'Besiktas' ).
    INSERT lo_galatasaray INTO TABLE lt_teams_exp.

    DATA(lo_object) = NEW ltc_simulator_inj( ).
    cut ?= lo_object.

    cut->set_initial_teams( ).
    cut->create_draws_next( ).
    cut->play_first_game( ).
    cut->play_second_game( ).

    DATA(lo_cut) = NEW zcl_chl_simulator(  ).
    lo_cut->set_draws( i_draws = cut->get_draws( )  ).
    cut ?= lo_cut.

    "when
    DATA(lt_teams_act) = cut->get_qualified_teams( ).

    "Then
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lt_teams_act[ 1 ]->get_name( )
        exp                  = 'Galatasaray'  ).

  ENDMETHOD.

ENDCLASS.

CLASS ltc_simulator_inj IMPLEMENTATION.
  METHOD zif_chl_simulator~create_draws.

  ENDMETHOD.

  METHOD zif_chl_simulator~create_draws_next.
    DATA(lv_first_team_index)  = -1.
    DATA(lv_second_team_index) = 0.

    DATA(lt_teams) = COND tt_team( WHEN initial_draw EQ abap_false
                                   THEN zif_chl_simulator~get_qualified_teams( )
                                   ELSE teams ).

    IF initial_draw EQ abap_false.
      current_level = current_level - 1.
    ENDIF.

    DO lines( lt_teams )  / 2 TIMES.
      lv_first_team_index = lv_first_team_index + 2.
      lv_second_team_index = lv_second_team_index + 2.
      DATA(lo_object) = NEW zcl_chl_draw( io_first_team   = lt_teams[ lv_first_team_index ]
                                          io_second_team  = lt_teams[ lv_second_team_index ]
                                          iv_level        = current_level ).
      APPEND lo_object TO draws.
    ENDDO.

    initial_draw = abap_false.
  ENDMETHOD.

  METHOD zif_chl_simulator~get_current_level.

  ENDMETHOD.

  METHOD zif_chl_simulator~get_draws.
    r_result = draws.
  ENDMETHOD.

  METHOD zif_chl_simulator~get_qualified_teams.

  ENDMETHOD.

  METHOD zif_chl_simulator~get_random_nr_instance.

  ENDMETHOD.

  METHOD zif_chl_simulator~play_first_game.

    DATA: lo_game_one TYPE REF TO zcl_chl_game,
          lo_draw     TYPE REF TO zcl_chl_draw.

    LOOP AT draws REFERENCE INTO DATA(lr_draw) .

      lo_draw ?= lr_draw->*.

      CHECK lo_draw->info-level EQ current_level.

      lo_game_one = NEW #( iv_first_team_id  = lo_draw->info-first_team->get_id( )
                           iv_second_team_id = lo_draw->info-second_team->get_id( ) ).

      lo_game_one->set_scores(
        EXPORTING
          iv_first_team_score  = 3
          iv_second_team_score = 0 ).

      lo_draw->set_first_game(
        EXPORTING
          io_game    = lo_game_one ).

    ENDLOOP.
  ENDMETHOD.

  METHOD zif_chl_simulator~play_second_game.

    DATA: lo_game_second TYPE REF TO zcl_chl_game,
          lo_object      TYPE REF TO zcl_chl_draw.

*    DATA(lo_random) = get_random_nr_instance( ).

    LOOP AT draws REFERENCE INTO DATA(lr_draw).

      lo_object ?= lr_draw->*.

      CHECK lo_object->info-level EQ current_level.

      lo_game_second = NEW #( iv_first_team_id  = lo_object->info-second_team->get_id( )
                              iv_second_team_id = lo_object->info-first_team->get_id( ) ).

      lo_game_second->set_scores(
        EXPORTING
          iv_first_team_score  = 4
          iv_second_team_score = 1 ).

      lo_object->set_second_game(
        EXPORTING
          io_game = lo_game_second ).

       lo_object->set_qualified_team( ).

    ENDLOOP.
  ENDMETHOD.

  METHOD zif_chl_simulator~set_initial_teams.
    initial_teams = VALUE tt_team_names( ( name = `Galatasaray` )
                                         ( name = `Fenerbahce` )
                                         ( name = `Besiktas` )
                                         ( name = `Trabzonspor` ) ).

    LOOP AT initial_teams REFERENCE INTO DATA(lr_team).
      DATA(lo_team) = NEW zcl_chl_team( iv_name = lr_team->name ).
      INSERT lo_team INTO TABLE teams.
    ENDLOOP.
  ENDMETHOD.

  METHOD zif_chl_simulator~set_draws.
  ENDMETHOD.

ENDCLASS.
