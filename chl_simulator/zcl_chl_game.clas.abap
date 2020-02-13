CLASS zcl_chl_game DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
  INTERFACES:
    zif_chl_game.
  ALIASES:
    set_scores
      FOR zif_chl_game~set_scores,
    get_first_team_score
      FOR zif_chl_game~get_first_team_score,
    get_second_team_score
      FOR zif_chl_game~get_second_team_score,
    get_home_team_id
      FOR zif_chl_game~get_home_team_id,
    get_second_team_id
      FOR zif_chl_game~get_second_team_id,
    get_first_team_id
      FOR zif_chl_game~get_first_team_id.
  METHODS:
    constructor
      IMPORTING
        iv_first_team_id  TYPE i
        iv_second_team_id TYPE i
        iv_home_team_id   TYPE i OPTIONAL.
  DATA:
    first_team_id     TYPE i READ-ONLY,
    second_team_id    TYPE i READ-ONLY,
    first_team_score  TYPE i READ-ONLY,
    second_team_score TYPE i READ-ONLY,
    home_team_id      TYPE i READ-ONLY.

PROTECTED SECTION.
PRIVATE SECTION.
  CLASS-DATA:
    total_game TYPE i.
ENDCLASS.

CLASS zcl_chl_game IMPLEMENTATION.

  METHOD constructor.
    total_game = total_game + 1.
    first_team_id  = iv_first_team_id.
    second_team_id = iv_second_team_id.
    home_team_id   = COND #( WHEN iv_home_team_id IS NOT INITIAL
                                          THEN iv_home_team_id
                                          ELSE iv_first_team_id ).
  ENDMETHOD.

  METHOD set_scores.
    first_team_score  = iv_first_team_score.
    second_team_score = iv_second_team_score.
  ENDMETHOD.

  METHOD get_first_team_score.
    r_result = first_team_score.
  ENDMETHOD.

  METHOD get_second_team_score.
    r_result = second_team_score.
  ENDMETHOD.

  METHOD get_home_team_id.
    r_result = home_team_id.
  ENDMETHOD.

  METHOD get_first_team_id.
    r_result = first_team_id.
  ENDMETHOD.

  METHOD get_second_team_id.
    r_result = second_team_id.
  ENDMETHOD.

ENDCLASS.
