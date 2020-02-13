INTERFACE zif_chl_simulator_viewer
  PUBLIC .
    METHODS:
      print_results
        IMPORTING
          data TYPE zif_chl_simulator=>tt_draw
          current_level TYPE i,
      print_qualify
        IMPORTING
          data TYPE zif_chl_simulator=>tt_team
          current_level TYPE i.
ENDINTERFACE.
