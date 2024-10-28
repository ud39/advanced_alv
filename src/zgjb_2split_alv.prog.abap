*&---------------------------------------------------------------------*
*& Report ZGJB_2SPLIT_ALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zgjb_2split_alv.

SELECT *
  INTO TABLE @DATA(it_scarr)
  FROM scarr.

SELECT *
  INTO TABLE @DATA(it_sflight)
  FROM sflight.

SELECT *
  INTO TABLE @DATA(it_spflight)
  FROM spfli.

DATA: o_splitter_main TYPE REF TO cl_gui_splitter_container.
DATA: o_splitter_sub TYPE REF TO cl_gui_splitter_container.
DATA: o_container_top TYPE REF TO cl_gui_container.
DATA: o_container_bottom_left TYPE REF TO cl_gui_container.
DATA: o_container_bottom_right TYPE REF TO cl_gui_container.


o_splitter_main = NEW #( parent = cl_gui_container=>default_screen
                         no_autodef_progid_dynnr = abap_true
                         rows = 2
                         columns = 1 ).

o_splitter_sub = NEW #( parent = o_splitter_main->get_container( row = 2 column = 1 )
                        no_autodef_progid_dynnr = abap_true
                        rows = 1
                        columns = 2 ).

o_container_top = o_splitter_main->get_container( row = 1 column = 1 ).
o_container_bottom_left = o_splitter_sub->get_container( row = 1 column = 1 ).
o_container_bottom_right = o_splitter_sub->get_container( row = 1 column = 2 ).


DATA: o_salv_top TYPE REF TO cl_salv_table.
TRY.
    cl_salv_table=>factory(
      EXPORTING
        r_container    = o_container_top                           " Abstracter Container fuer GUI Controls
      IMPORTING
        r_salv_table   = o_salv_top                          " Basisklasse einfache ALV Tabellen
      CHANGING
        t_table        = it_scarr
    ).

    o_salv_top->get_functions( )->set_all( abap_true ).
    o_salv_top->get_columns( )->set_optimize( abap_true ).
    o_salv_top->get_display_settings( )->set_list_header( value = 'Airline'  ).
    o_salv_top->get_display_settings( )->set_striped_pattern( abap_true ).
    o_salv_top->get_selections( )->set_selection_mode( if_salv_c_selection_mode=>row_column ).
    o_salv_top->display( ).
  CATCH cx_salv_msg. " ALV: Allg. Fehlerklasse  mit Meldung

ENDTRY.

DATA: o_salv_bottom_left TYPE REF TO cl_salv_table.
TRY.
    cl_salv_table=>factory(
      EXPORTING
        r_container    = o_container_bottom_left                           " Abstracter Container fuer GUI Controls
      IMPORTING
        r_salv_table   = o_salv_bottom_left                          " Basisklasse einfache ALV Tabellen
      CHANGING
        t_table        = it_sflight
    ).

    o_salv_bottom_left->get_functions( )->set_all( abap_true ).
    o_salv_bottom_left->get_columns( )->set_optimize( abap_true ).
    o_salv_bottom_left->get_display_settings( )->set_list_header( value = 'Flights'  ).
    o_salv_bottom_left->get_display_settings( )->set_striped_pattern( abap_true ).
    o_salv_bottom_left->get_selections( )->set_selection_mode( if_salv_c_selection_mode=>row_column ).
    o_salv_bottom_left->display( ).
  CATCH cx_salv_msg. " ALV: Allg. Fehlerklasse  mit Meldung

ENDTRY.


DATA: o_salv_bottom_right TYPE REF TO cl_salv_table.
TRY.
    cl_salv_table=>factory(
      EXPORTING
        r_container    = o_container_bottom_right                          " Abstracter Container fuer GUI Controls
      IMPORTING
        r_salv_table   = o_salv_bottom_right                          " Basisklasse einfache ALV Tabellen
      CHANGING
        t_table        = it_spflight
    ).

    o_salv_bottom_right->get_functions( )->set_all( abap_true ).
    o_salv_bottom_right->get_columns( )->set_optimize( abap_true ).
    o_salv_bottom_right->get_display_settings( )->set_list_header( value = 'Flights Plan'  ).
    o_salv_bottom_right->get_display_settings( )->set_striped_pattern( abap_true ).
    o_salv_bottom_right->get_selections( )->set_selection_mode( if_salv_c_selection_mode=>row_column ).
    o_salv_bottom_right->display( ).
  CATCH cx_salv_msg. " ALV: Allg. Fehlerklasse  mit Meldung

ENDTRY.

WRITE:space.
