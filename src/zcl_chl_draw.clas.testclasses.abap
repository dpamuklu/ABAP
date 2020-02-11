*"* use this source file for your ABAP unit test classes
CLASS ltc_draw DEFINITION FOR TESTING
                          DURATION SHORT
                          RISK LEVEL HARMLESS.

PUBLIC SECTION.
PROTECTED SECTION.
PRIVATE SECTION.
  DATA:
    cut   TYPE REF TO zif_chl_draw,
    draw1 TYPE REF TO zcl_chl_draw,
    draw2 TYPE REF TO zcl_chl_draw.
  METHODS:
    setup,
    more_score_team_qualified FOR TESTING,
    if_deuce_away_advantage   FOR TESTING,
    create_draw1
      RETURNING
        VALUE(ro_result) TYPE REF TO zcl_chl_draw,
    create_draw2
      RETURNING
        VALUE(ro_result) TYPE REF TO zcl_chl_draw.

ENDCLASS.

CLASS ltc_draw IMPLEMENTATION.

  METHOD more_score_team_qualified.

     draw1 = create_draw1(  ).
     cut ?= draw1.

     "when
     cut->set_qualified_team(  ).
     DATA(lv_act_id) = cut->get_qualified_team_id( draw1->get_id( ) ).

     "then
     cl_abap_unit_assert=>assert_equals(
        act = lv_act_id
        exp = '4' ).


  ENDMETHOD.

  METHOD setup.
  ENDMETHOD.


  METHOD create_draw1.

    DATA: lo_draw        TYPE REF TO zcl_chl_draw,
          lo_first_team  TYPE REF TO zcl_chl_team,
          lo_second_team TYPE REF TO zcl_chl_team,
          lo_first_game  TYPE REF TO zcl_chl_game,
          lo_second_game TYPE REF TO zcl_chl_game.

     lo_first_team  = NEW #( iv_name = `Istanbul` ).
     lo_second_team = NEW #( iv_name = 'Paris' ).

     lo_draw = NEW #( io_first_team  = lo_first_team
                      io_second_team = lo_second_team
                      iv_level       = '4' ).

     lo_first_game = NEW #( iv_first_team_id = lo_first_team->get_id( )
                            iv_second_team_id = lo_second_team->get_id( ) ).

     lo_first_game->set_scores(
       EXPORTING
         iv_first_team_score  = 0
         iv_second_team_score = 3  ).

     lo_draw->set_first_game(
       EXPORTING
         io_game    = lo_first_game ).

     lo_second_game = NEW #( iv_first_team_id = lo_second_team->get_id( )
                             iv_second_team_id = lo_first_team->get_id( ) ).

     lo_second_game->set_scores(
       EXPORTING
         iv_first_team_score  = 3
         iv_second_team_score = 2 ).

     lo_draw->set_second_game(
       EXPORTING
         io_game    = lo_second_game  ).

    ro_result = lo_draw.

  ENDMETHOD.

  METHOD create_draw2.

    DATA: lo_draw        TYPE REF TO zcl_chl_draw,
          lo_first_team  TYPE REF TO zcl_chl_team,
          lo_second_team TYPE REF TO zcl_chl_team,
          lo_first_game  TYPE REF TO zcl_chl_game,
          lo_second_game TYPE REF TO zcl_chl_game.

     lo_first_team  = NEW #( iv_name = `Roma` ).
     lo_second_team = NEW #( iv_name = 'Madrid' ).

     lo_draw = NEW #( io_first_team  = lo_first_team
                      io_second_team = lo_second_team
                      iv_level       = '4' ).

     lo_first_game = NEW #( iv_first_team_id = lo_first_team->get_id( )
                            iv_second_team_id = lo_second_team->get_id( ) ).

     lo_first_game->set_scores(
       EXPORTING
         iv_first_team_score  = 3
         iv_second_team_score = 3  ).

     lo_draw->set_first_game(
       EXPORTING
         io_game    = lo_first_game ).

     lo_second_game = NEW #( iv_first_team_id  = lo_second_team->get_id( )
                             iv_second_team_id = lo_first_team->get_id( ) ).

     lo_second_game->set_scores(
       EXPORTING
         iv_first_team_score  = 4
         iv_second_team_score = 4 ).

     lo_draw->set_second_game(
       EXPORTING

         io_game    = lo_second_game  ).

    ro_result = lo_draw.

  ENDMETHOD.

  METHOD if_deuce_away_advantage.

     draw2 = create_draw2(  ).
     cut ?= draw2.

     "when
     cut->set_qualified_team( ).
     DATA(lv_act_id) = cut->get_qualified_team_id( draw2->get_id( ) ).

     "then
     cl_abap_unit_assert=>assert_equals(
        act = lv_act_id
        exp = '1' ).

  ENDMETHOD.

ENDCLASS.
