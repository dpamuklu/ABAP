INTERFACE zif_chl_simulator
  PUBLIC .
    TYPES:
      tt_draw TYPE STANDARD TABLE OF REF TO zcl_chl_draw WITH DEFAULT KEY,
      tt_team TYPE STANDARD TABLE OF REF TO zcl_chl_team WITH DEFAULT KEY,
      BEGIN OF ty_team_names,
        name TYPE string,
      END OF ty_team_names,
      tt_team_names TYPE TABLE OF ty_team_names WITH DEFAULT KEY.
   METHODS:
     create_draws,
     get_random_nr_instance
       RETURNING
         VALUE(r_object) TYPE REF TO cl_abap_random_int,
     play_second_game,
     get_qualified_teams
       RETURNING
         VALUE(r_result) TYPE tt_team,
     create_draws_next,
     set_initial_teams,
     play_first_game,
     get_draws
       RETURNING
         VALUE(r_result) TYPE zif_chl_simulator=>tt_draw,
     get_current_level
       RETURNING
         VALUE(r_result) TYPE i.

ENDINTERFACE.
