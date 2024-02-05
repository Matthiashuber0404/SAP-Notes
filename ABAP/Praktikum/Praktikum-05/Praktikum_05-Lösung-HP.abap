*&---------------------------------------------------------------------*
*& Report ZKOE1_PRAKT_R_PR05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZKOE2_12A_P_R_PR05.

PARAMETERS: p_id TYPE z001_63_class-id.

DATA: go_class TYPE REF TO zkoe2_12a_p_cl_school,
      gn_count TYPE i,
      gv_kbez TYPE z001_63_class-shortname,
      gv_lbez TYPE z001_63_class-longterm,
      gt_pupil TYPE zkoe2_12a_p_cl_school=>tt_pupil,
      gs_teacher TYPE z001_63_teacher.

START-OF-SELECTION.
  gn_count =  zkoe2_12a_p_cl_school=>get_countclass( ).
  WRITE:/ 'Anzahl der Klassen:', gn_count.

  gn_count =  zkoe2_12a_p_cl_school=>get_pupils_all( ).
  FORMAT COLOR 1.
  WRITE:/ 'Anzahl der Schüler insgesamt:', gn_count.
  SKIP 2.

go_class = new zkoe2_12a_p_cl_school( p_id ).

  go_class->get_classtext(
   IMPORTING
     ev_kbez = gv_kbez
     ev_lbez = gv_lbez ).
  FORMAT COLOR 4.
  WRITE:/ p_id, gv_kbez, gv_lbez COLOR 4.

  gn_count =  go_class->get_pupils_cl( ).
  FORMAT COLOR 2.
  WRITE:/ 'Anzahl der Schüler in der Klasse:', gn_count COLOR 2.

  go_class->get_classteacher(
    IMPORTING
      es_teacher = gs_teacher ).

  ULINE.
  DATA gv_classteacher TYPE string.
  gv_classteacher = |{ go_class->get_classteacher2( )-name } { go_class->get_classteacher2( )-surname }|.
  FORMAT COLOR OFF.
  WRITE:/ 'Klassenlehrer:', gv_classteacher.
  ULINE.

  go_class->get_pupils(
     CHANGING
      et_pupil = gt_pupil ).
  FORMAT COLOR 3.
  WRITE:/1 'Name des Schülers', 35 'Alter'.
  FORMAT COLOR OFF.
  ULINE.
  LOOP AT gt_pupil into data(gs_pupil).
    WRITE:/1 |{ gs_pupil-surname } { gs_pupil-name }|, 35 gs_pupil-age.
  ENDLOOP.