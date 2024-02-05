*&---------------------------------------------------------------------*
*& Report Z070_TP_PROBE_SA1_2023
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z070_tp_probe_sa1_2023.

DATA: go_geschenk TYPE REF TO z070_tp_cl_geschenk,
      go_nahrung  TYPE REF TO z070_tp_cl_nahrung,
      gt_einkauf  TYPE TABLE OF REF TO z070_tp_cl_einkauf,
      gn_summe    TYPE dec10_2.

go_geschenk = NEW #( iv_bezeichnung = 'Buch' in_listenpreis = '59.90' iv_beschenkter = 'Maxi' ).
APPEND go_geschenk TO gt_einkauf.
go_geschenk = NEW #( iv_bezeichnung = 'Schlemmerkiste' in_listenpreis = '279.99' iv_beschenkter = 'Romina' ).
APPEND go_geschenk TO gt_einkauf.
go_nahrung = NEW #( iv_bezeichnung = 'Kasten Augustiner' in_listenpreis = '19.99' in_menge = 3 ).
APPEND go_nahrung TO gt_einkauf.
go_nahrung = NEW #( iv_bezeichnung = '1 Kilo Rinderfilet' in_listenpreis = '26.00' in_menge = -5 ).
APPEND go_nahrung TO gt_einkauf.

WRITE: / 'Meine Einkaufsliste für Weihnachten'.
ULINE.
WRITE: / 'Nummer des letzten Einkaufs:', z070_tp_cl_einkauf=>get_akt_nummer( ).
ULINE.
LOOP AT gt_einkauf INTO DATA(go_einkauf).
  go_einkauf->display_attributes( ).
  gn_summe = gn_summe + go_einkauf->calc_preis( ).
ENDLOOP.

ULINE.
WRITE: /30 'Summe gesamt:', 45 gn_summe.
