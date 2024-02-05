*&---------------------------------------------------------------------*
*& Report ZXXX_TP_PROG_BANKKONTO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zxxx_tp_prog_bankkonto.

DATA: go_girokonto TYPE REF TO z070_tp_cl_girokonto,
      go_sparkonto TYPE REF TO z070_tp_cl_sparkonto,
      gt_konten    TYPE TABLE OF REF TO z070_tp_cl_bankkonto.

go_girokonto = NEW #(
  iv_kontoinhaber = 'Florian Maier'
  in_dispokredit = 1000
).
APPEND go_girokonto TO gt_konten.

go_girokonto = NEW #(
  iv_kontoinhaber = 'Sabine Huber'
  in_dispokredit = 2000
).
APPEND go_girokonto TO gt_konten.

go_sparkonto = NEW #(
 iv_kontoinhaber = 'Michael Oswald'
 in_einzahlbetrag = '3150.49'
).
APPEND go_sparkonto TO gt_konten.

go_sparkonto = NEW #(
 iv_kontoinhaber = 'Franziska Loibl'
 in_einzahlbetrag = '5005.90'
).
APPEND go_sparkonto TO gt_konten.

SKIP.
WRITE: / 'In jeds Konto werden 200 € eingezahlt:'.
LOOP AT gt_konten INTO DATA(go_konto).
  go_konto->einzahlen( 200 ).
  WRITE: / go_konto->get_kontonr( ), ':', (*) go_konto->get_kontostand( ), '€'.
ENDLOOP.

SKIP.
gt_konten[ 4 ]->abheben( in_betrag = 4000 ).
gt_konten[ 4 ]->abheben( in_betrag = 2000 ).

SKIP.
gt_konten[ 1 ]->transfer(
  EXPORTING
    in_betrag    = 350
    io_bankkonto = gt_konten[ 3 ]
).
SKIP.

LOOP AT gt_konten INTO go_konto.
  WRITE: / go_konto->get_data( ).
ENDLOOP.
