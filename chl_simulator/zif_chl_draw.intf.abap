INTERFACE zif_chl_draw
  PUBLIC .
    TYPES:
      BEGIN OF ty_draw,
        id              TYPE i,
        first_team      TYPE REF TO zcl_chl_team,
        second_team     TYPE REF TO zcl_chl_team,
        first_game      TYPE REF TO zcl_chl_game,
        second_game     TYPE REF TO zcl_chl_game,
        level           TYPE i,
        qualified_team  TYPE i,
      END OF ty_draw,
      tt_draw TYPE TABLE OF ty_draw WITH KEY id.
    METHODS:
      set_qualified_team,
      get_qualified_team_id
        IMPORTING
          iv_id TYPE i
        RETURNING
          VALUE(r_result) TYPE i,
      set_first_game
        IMPORTING
          io_game    TYPE REF TO zcl_chl_game,
      set_second_game
        IMPORTING
          io_game    TYPE REF TO zcl_chl_game.
ENDINTERFACE.
