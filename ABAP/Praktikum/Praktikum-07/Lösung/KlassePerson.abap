CLASS z070_tp_cl_person DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !iv_name     TYPE string
        !iv_gebdatum TYPE dats .
    METHODS get_alter
          FINAL
      RETURNING
        VALUE(rn_alter) TYPE i .
    METHODS vorstellen
      RETURNING
        VALUE(rv_vorstellen) TYPE string .
    METHODS get_gehalt
          ABSTRACT
      RETURNING
        VALUE(rn_gehalt) TYPE dec8_2 .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA mv_name TYPE string .
    DATA mv_gebdatum TYPE dats .
ENDCLASS.



CLASS Z070_TP_CL_PERSON IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_PERSON->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_NAME                        TYPE        STRING
* | [--->] IV_GEBDATUM                    TYPE        DATS
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD constructor.
    mv_name = iv_name.
    mv_gebdatum = iv_gebdatum.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_PERSON->GET_ALTER
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RN_ALTER                       TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_alter.
    DATA: lv_first_date          TYPE prel-begda,
          lv_second_date         TYPE prel-endda,
          ln_years_between_dates TYPE i.

    lv_first_date = mv_gebdatum.
    lv_second_date = sy-datum.

    CALL FUNCTION 'COMPUTE_YEARS_BETWEEN_DATES'
      EXPORTING
        first_date                  = lv_first_date
        second_date                 = lv_second_date
      IMPORTING
        years_between_dates         = ln_years_between_dates
      EXCEPTIONS
        sequence_of_dates_not_valid = 1
        OTHERS                      = 2.
    IF sy-subrc <> 0.
* Implement suitable error handling here
      rn_alter = -1.
    ELSE.
      rn_alter = ln_years_between_dates.
    ENDIF.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_PERSON->VORSTELLEN
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_VORSTELLEN                  TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD vorstellen.
    rv_vorstellen = |Hallo, ich heiﬂe { mv_name } und bin { get_alter( ) } Jahre alt.|.
  ENDMETHOD.
ENDCLASS.
