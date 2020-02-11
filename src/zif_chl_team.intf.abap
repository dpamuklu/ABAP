INTERFACE zif_chl_team
  PUBLIC .
  METHODS:
    get_name
      RETURNING
        VALUE(r_result) TYPE string,
    get_id
      RETURNING
        VALUE(r_result) TYPE i.

ENDINTERFACE.
