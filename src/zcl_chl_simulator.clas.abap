CLASS zcl_chl_simulator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
  INTERFACES:
    zif_chl_simulator.
  ALIASES:
    get_random_nr_instance FOR zif_chl_simulator~get_random_nr_instance, "methods
    create_draws           FOR zif_chl_simulator~create_draws,
    create_draws_next      FOR zif_chl_simulator~create_draws_next,
    play_first_game        FOR zif_chl_simulator~play_first_game,
    play_second_game       FOR zif_chl_simulator~play_second_game,
    get_qualified_teams    FOR zif_chl_simulator~get_qualified_teams,
    set_initial_teams      FOR zif_chl_simulator~set_initial_teams,
    get_draws              FOR zif_chl_simulator~get_draws,
    get_current_level      FOR zif_chl_simulator~get_current_level,
    tt_draw                FOR zif_chl_simulator~tt_draw,           "types
    tt_team                FOR zif_chl_simulator~tt_team,
    tt_team_names          FOR zif_chl_simulator~tt_team_names.

PROTECTED SECTION.
PRIVATE SECTION.
  DATA: random        TYPE REF TO cl_abap_random_int,
        draws         TYPE tt_draw,
        current_level TYPE i VALUE 4,
        initial_teams TYPE tt_team_names.
ENDCLASS.

CLASS zcl_chl_simulator IMPLEMENTATION.

  METHOD create_draws.

     DATA: lv_team_finder_index TYPE i VALUE 0.

     DO lines( initial_teams ) / 2 TIMES.
       lv_team_finder_index = lv_team_finder_index + 1 .
       DATA(lo_first_team)  = NEW zcl_chl_team( iv_name = initial_teams[ lv_team_finder_index ]-name ).
       lv_team_finder_index = lv_team_finder_index + 1 .
       DATA(lo_second_team) = NEW zcl_chl_team( iv_name = initial_teams[ lv_team_finder_index ]-name ).

       DATA(lo_draw) = NEW zcl_chl_draw( io_first_team  = lo_first_team
                                         io_second_team = lo_second_team
                                         iv_level       = current_level ).

       INSERT lo_draw INTO TABLE draws.
     ENDDO.

  ENDMETHOD.

  METHOD create_draws_next.

    DATA(lv_first_team_index)  = -1.
    DATA(lv_second_team_index) = 0.
    DATA(lt_teams) = get_qualified_teams( ).

    current_level = current_level - 1.

    DO lines( lt_teams )  / 2 TIMES.
      lv_first_team_index = lv_first_team_index + 2.
      lv_second_team_index = lv_second_team_index + 2.
      DATA(lo_object) = NEW zcl_chl_draw( io_first_team   = lt_teams[ lv_first_team_index ]
                                          io_second_team  = lt_teams[ lv_second_team_index ]
                                          iv_level        = current_level ).
      APPEND lo_object TO draws.
    ENDDO.

  ENDMETHOD.

  METHOD get_qualified_teams.
    DATA: lo_object TYPE REF TO zcl_chl_draw,
          lo_team_object TYPE REF TO zcl_chl_team.

    LOOP AT draws REFERENCE INTO DATA(lr_draw).

      lo_object ?= lr_draw->*.

      CHECK lo_object->info-level EQ current_level.
      lo_team_object ?= COND #( WHEN lo_object->info-first_team->get_id( ) EQ lo_object->info-qualified_team
                                THEN lo_object->info-first_team
                                WHEN lo_object->info-second_team->get_id( ) EQ lo_object->info-qualified_team
                                THEN lo_object->info-second_team ).
      INSERT lo_team_object INTO TABLE r_result.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_random_nr_instance.
    IF random IS NOT BOUND.
      DATA(seed) = cl_abap_random=>seed( ).
      random = cl_abap_random_int=>create(
        EXPORTING
          seed           = seed
          min            = 1
          max            = 6 ).
   ENDIF.
   r_object = random.
  ENDMETHOD.

  METHOD play_first_game.

    DATA: lo_game_one TYPE REF TO zcl_chl_game,
          lo_draw     TYPE REF TO zcl_chl_draw.

    DATA(lo_random) = get_random_nr_instance( ).

    LOOP AT draws REFERENCE INTO DATA(lr_draw) .

      lo_draw ?= lr_draw->*.

      CHECK lo_draw->info-level EQ current_level.

      lo_game_one = NEW #( iv_first_team_id  = lo_draw->info-first_team->get_id( )
                           iv_second_team_id = lo_draw->info-second_team->get_id( ) ).

      lo_game_one->set_scores(
        EXPORTING
          iv_first_team_score  = lo_random->get_next( )
          iv_second_team_score = lo_random->get_next( ) ).

      lo_draw->set_first_game(
        EXPORTING
          io_game    = lo_game_one ).

    ENDLOOP.

  ENDMETHOD.

  METHOD play_second_game.

    DATA: lo_game_second TYPE REF TO zcl_chl_game,
          lo_object      TYPE REF TO zcl_chl_draw.

    DATA(lo_random) = get_random_nr_instance( ).

    LOOP AT draws REFERENCE INTO DATA(lr_draw).

      lo_object ?= lr_draw->*.

      CHECK lo_object->info-level EQ current_level.

      lo_game_second = NEW #( iv_first_team_id  = lo_object->info-second_team->get_id( )
                              iv_second_team_id = lo_object->info-first_team->get_id( ) ).

      lo_game_second->set_scores(
        EXPORTING
          iv_first_team_score  = lo_random->get_next( )
          iv_second_team_score = lo_random->get_next( ) ).

      lo_object->set_second_game(
        EXPORTING
          io_game = lo_game_second ).

       lo_object->set_qualified_team( ).

    ENDLOOP.
  ENDMETHOD.

  METHOD set_initial_teams.

    initial_teams = VALUE tt_team_names( ( name = `Napoli` )
                                         ( name = `Barcelona` )
                                         ( name = `Chelsea` )
                                         ( name = `Bayern Munih` )
                                         ( name = `Real Madrid` )
                                         ( name = `Man City` )
                                         ( name = `Lyon` )
                                         ( name = `Juventus` )
                                         ( name = `Valencia` )
                                         ( name = `Atalanta` )
                                         ( name = `Leipzig` )
                                         ( name = `Tottenham` )
                                         ( name = `Paris SG` )
                                         ( name = `Dortmund` )
                                         ( name = `Liverpool` )
                                         ( name = `Atletico Madrid` ) ).
  ENDMETHOD.

  METHOD get_draws.
    r_result = draws.
  ENDMETHOD.

  METHOD get_current_level.
    r_result = current_level.
  ENDMETHOD.
ENDCLASS.
