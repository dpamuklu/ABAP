CLASS zcl_chl_draw DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
  INTERFACES:
    zif_chl_draw.
  ALIASES:
    set_first_game
      FOR zif_chl_draw~set_first_game,
    set_second_game
      FOR zif_chl_draw~set_second_game,
    set_qualified_team
      FOR zif_chl_draw~set_qualified_team.
  METHODS:
    constructor
      IMPORTING
        io_first_team  TYPE zif_chl_draw=>ty_draw-first_team
        io_second_team TYPE zif_chl_draw=>ty_draw-second_team
        iv_level       TYPE zif_chl_draw=>ty_draw-level,
    get_id RETURNING VALUE(r_result) TYPE i.
  DATA:
    info TYPE zif_chl_draw=>ty_draw READ-ONLY.
PROTECTED SECTION.
PRIVATE SECTION.
   CLASS-DATA:
     counter TYPE i.
ENDCLASS.

CLASS zcl_chl_draw IMPLEMENTATION.

  METHOD constructor.
    counter = counter + 1.

    info = VALUE #( id           = counter
                    first_team   = io_first_team
                    second_team  = io_second_team
                    level        = iv_level  ).
  ENDMETHOD.

  METHOD zif_chl_draw~get_qualified_team_id.
    r_result = COND #( WHEN info-qualified_team IS NOT INITIAL
                       THEN info-qualified_team
                       ELSE space ).
  ENDMETHOD.

  METHOD get_id.
    r_result = info-id.
  ENDMETHOD.

  METHOD set_qualified_team.

    DATA(lv_first_team_score) = info-first_game->get_first_team_score( ).
    lv_first_team_score       = lv_first_team_score + info-second_game->get_second_team_score( ).

    DATA(lv_second_team_score) = info-first_game->get_second_team_score( ).
    lv_second_team_score       = lv_second_team_score + info-second_game->get_first_team_score( ).

    DATA(lv_first_game_home_score)  = info-first_game->get_first_team_score( ).
    DATA(lv_second_game_home_score) = info-second_game->get_first_team_score( ).

    IF lv_first_team_score EQ lv_second_team_score AND
       lv_first_game_home_score LT lv_second_game_home_score .
      lv_first_team_score = lv_first_team_score + 1.
    ELSEIF lv_first_team_score EQ lv_second_team_score AND
           lv_first_game_home_score GT lv_second_game_home_score .
      lv_second_team_score = lv_second_team_score + 1.
    ENDIF.

    info-qualified_team = COND #( WHEN lv_first_team_score GT lv_second_team_score
                                  THEN info-first_team->get_id( )
                                  WHEN lv_second_team_score GT lv_first_team_score
                                  THEN info-second_team->get_id( )
                                  WHEN lv_second_team_score EQ lv_first_team_score
                                  THEN info-second_team->get_id( ) ).
  ENDMETHOD.

  METHOD set_first_game.
    info-first_game = io_game.
  ENDMETHOD.

  METHOD set_second_game.
    info-second_game = io_game.
  ENDMETHOD.

ENDCLASS.
