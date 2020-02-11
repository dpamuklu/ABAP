INTERFACE zif_chl_game
  PUBLIC .
    METHODS:
      set_scores
        IMPORTING
          iv_first_team_score  TYPE i
          iv_second_team_score TYPE i,
      get_first_team_score
        RETURNING
          VALUE(r_result) TYPE i,
      get_second_team_score
        RETURNING
          VALUE(r_result) TYPE i,
      get_home_team_id
        RETURNING
          VALUE(r_result) TYPE i,
      get_second_team_id
        RETURNING VALUE(r_result) TYPE i,
      get_first_team_id
        RETURNING VALUE(r_result) TYPE i.

ENDINTERFACE.
