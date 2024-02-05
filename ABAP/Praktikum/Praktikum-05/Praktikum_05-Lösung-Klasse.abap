CLASS zkoe2_12a_p_cl_school DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ts_pupil.
        INCLUDE TYPE z001_63_pupil.
        TYPES: age TYPE i,
      END OF ts_pupil .
    TYPES:
      tt_pupil TYPE TABLE OF ts_pupil .

    CLASS-METHODS get_countclass
      RETURNING
        VALUE(rn_countcl) TYPE i .
    CLASS-METHODS get_pupils_all
      RETURNING
        VALUE(rn_countpa) TYPE i .
    METHODS constructor
      IMPORTING
        !in_id TYPE z001_63_class-id .
    METHODS get_classtext
      EXPORTING
        !ev_kbez TYPE z001_63_class-shortname
        !ev_lbez TYPE z001_63_class-longterm .
    METHODS get_pupils_cl
      RETURNING
        VALUE(rn_countpcl) TYPE i .
    METHODS get_classteacher
      EXPORTING
        !es_teacher TYPE z001_63_teacher .
    METHODS get_classteacher2
      RETURNING
        VALUE(rs_teacher) TYPE z001_63_teacher .
*             get_pupils CHANGING et_pupil TYPE tt_pupil.
    METHODS get_pupils
      CHANGING
        !et_pupil TYPE tt_pupil .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA mn_id TYPE z001_63_class-id .
    CLASS-DATA gn_countcl TYPE i .
    CLASS-DATA gn_countpa TYPE i .

    CLASS-METHODS get_age
      IMPORTING
        !in_gebdat TYPE z001_63_pupil-birthday
      EXPORTING
        !en_age    TYPE i .
ENDCLASS.



CLASS ZKOE2_12A_P_CL_SCHOOL IMPLEMENTATION.


  METHOD constructor.
    mn_id = in_id.
  ENDMETHOD.                    "constructor


  METHOD get_age.
*    en_age = floor( ( sy-datum - in_gebdat ) / '365.25' ).

    CALL FUNCTION 'COMPUTE_YEARS_BETWEEN_DATES'
      EXPORTING
        first_date          = in_gebdat
        second_date         = sy-datum
      IMPORTING
        years_between_dates = en_age.

  ENDMETHOD.                    "get_age


  METHOD get_classteacher.
    SELECT SINGLE * FROM z001_63_teacher AS l INNER JOIN z001_63_class AS k
      ON k~ctid = l~id
      INTO CORRESPONDING FIELDS OF es_teacher
      WHERE k~id = mn_id.

  ENDMETHOD.                    "get_classteacher


  METHOD get_classteacher2.
    SELECT SINGLE * FROM z001_63_teacher AS l INNER JOIN z001_63_class AS k
      ON k~ctid = l~id
      INTO CORRESPONDING FIELDS OF rs_teacher
      WHERE k~id = mn_id.

  ENDMETHOD.                    "get_classteacher


  METHOD get_classtext.

    SELECT SINGLE shortname longterm FROM z001_63_class
      INTO (ev_kbez, ev_lbez)
      WHERE id = mn_id.
    IF sy-subrc <> 0.
      CLEAR: ev_kbez, ev_lbez.

    ENDIF.
  ENDMETHOD.                    "get_classtext


  METHOD get_countclass.
    SELECT COUNT(*) FROM z001_63_class INTO rn_countcl.
  ENDMETHOD.                    "get_countclass


  METHOD get_pupils.
    DATA: ln_age TYPE i.
*    FIELD-SYMBOLS: <fs_pupil> TYPE ts_pupil.
    SELECT * FROM z001_63_pupil
      INTO CORRESPONDING FIELDS OF TABLE et_pupil
      WHERE cid = mn_id.
    LOOP AT et_pupil INTO DATA(ls_pupil).
      me->get_age( EXPORTING in_gebdat = ls_pupil-birthday
                   IMPORTING en_age    = ls_pupil-age ).
      MODIFY et_pupil FROM ls_pupil INDEX sy-tabix.
    ENDLOOP.
*    LOOP AT et_pupil ASSIGNING <fs_pupil>.
*      me->get_age( EXPORTING in_gebdat = <fs_pupil>-birthday
*                   IMPORTING en_age    = ln_age ).
*      <fs_pupil>-age = ln_age.
*    ENDLOOP.

  ENDMETHOD.                    "get_pupils


  METHOD get_pupils_all.
    SELECT COUNT(*) FROM z001_63_pupil INTO rn_countpa.
  ENDMETHOD.                    "get_countclass


  METHOD get_pupils_cl.
    SELECT COUNT(*) FROM z001_63_pupil INTO rn_countpcl
      WHERE cid = mn_id.
  ENDMETHOD.                    "get_countclass
ENDCLASS.