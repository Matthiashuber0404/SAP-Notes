*&---------------------------------------------------------------------*
*& Report Z070_TP_PROG_PERSONEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z070_tp_prog_personen.

DATA: gt_personen     TYPE TABLE OF REF TO z070_tp_cl_person,
      go_person       TYPE REF TO z070_tp_cl_person,
      go_student      TYPE REF TO z070_tp_cl_student,
      go_arbeiter     TYPE REF TO z070_tp_cl_arbeiter,
      go_angestellter TYPE REF TO z070_tp_cl_angestellter,
      gn_ges_gehalt   TYPE dec8_2.

*go_person = NEW #( iv_name = 'Laura' iv_gebdatum = '20090529' ).
go_student = NEW #( iv_name = 'Max' iv_gebdatum = '20020701' in_semesterzahl = 3 iv_bafoeg = 'X' ).
APPEND go_student TO gt_personen.
go_student = NEW #( iv_name = 'Eva' iv_gebdatum = '20010701' in_semesterzahl = 2 iv_bafoeg = ' ' ).
APPEND go_student TO gt_personen.

go_arbeiter = NEW #( iv_name = 'Tom' iv_gebdatum = '19960810' in_wochenstunden = 40 ).
APPEND go_arbeiter TO gt_personen.
go_arbeiter = NEW #( iv_name = 'Nicole' iv_gebdatum = '19920915' in_wochenstunden = 20 ).
APPEND go_arbeiter TO gt_personen.

go_angestellter = NEW #( iv_name = 'Franziska' iv_gebdatum = '19950915' in_besoldungsgruppe = 5 ).
APPEND go_angestellter TO gt_personen.
go_angestellter = NEW #( iv_name = 'Johannes' iv_gebdatum = '19930621' in_besoldungsgruppe = 18 ).
APPEND go_angestellter TO gt_personen.

LOOP AT gt_personen INTO go_person.
  WRITE: / go_person->vorstellen( ), 95 'Gehalt:', (*) go_person->get_gehalt( ).
  gn_ges_gehalt = gn_ges_gehalt + go_person->get_gehalt( ).
ENDLOOP.
ULINE.
WRITE: /87 'Gesamtgehälter:', (*) gn_ges_gehalt.
