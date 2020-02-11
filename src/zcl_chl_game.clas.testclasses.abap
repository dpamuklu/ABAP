*"* use this source file for your ABAP unit test classes
CLASS ltc_game DEFINITION FOR TESTING
                          DURATION SHORT
                          RISK LEVEL HARMLESS.

PUBLIC SECTION.
PROTECTED SECTION.
PRIVATE SECTION.
  DATA:
    cut_game_one TYPE REF TO zif_chl_game.
  METHODS:
    game_one_created_expected FOR TESTING.
ENDCLASS.

CLASS ltc_game IMPLEMENTATION.

  METHOD game_one_created_expected.
  "GIVEN
    DATA: lo_game_one TYPE REF TO zcl_chl_game.

    lo_game_one = NEW #( iv_first_team_id  = '1'
                         iv_second_team_id = '2' ).

    cut_game_one ?= lo_game_one.

  "WHEN
    cut_game_one->set_scores(
      EXPORTING
        iv_first_team_score  = '1'
        iv_second_team_score = '3' ).

    DATA(lv_first_team_score)  = cut_game_one->get_first_team_score(  ).
    DATA(lv_second_team_score) = cut_game_one->get_second_team_score(  ).

  "THEN
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_first_team_score
        exp                  = '1'  ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_second_team_score
        exp                  = '3' ).
  ENDMETHOD.

ENDCLASS.
