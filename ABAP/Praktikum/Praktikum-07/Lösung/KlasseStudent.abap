CLASS z070_tp_cl_student DEFINITION
  PUBLIC
  INHERITING FROM z070_tp_cl_person
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !iv_name         TYPE string
        !iv_gebdatum     TYPE dats
        !in_semesterzahl TYPE i
        !iv_bafoeg       TYPE c .

    METHODS vorstellen
        REDEFINITION .
    METHODS get_gehalt
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA mn_semesterzahl TYPE i .
    DATA mv_bafoeg TYPE c .
ENDCLASS.



CLASS Z070_TP_CL_STUDENT IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_STUDENT->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_NAME                        TYPE        STRING
* | [--->] IV_GEBDATUM                    TYPE        DATS
* | [--->] IN_SEMESTERZAHL                TYPE        I
* | [--->] IV_BAFOEG                      TYPE        C
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD constructor.
    super->constructor( iv_name = iv_name iv_gebdatum = iv_gebdatum ).
    mn_semesterzahl = in_semesterzahl.
    mv_bafoeg = iv_bafoeg.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_STUDENT->GET_GEHALT
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RN_GEHALT                      TYPE        DEC8_2
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_gehalt.
    rn_gehalt = 0.
    IF mv_bafoeg = 'X'.
      rn_gehalt = 500.
    ENDIF.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_STUDENT->VORSTELLEN
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_VORSTELLEN                  TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD vorstellen.
    rv_vorstellen = |{ super->vorstellen( ) } Ich studiere im { mn_semesterzahl }. Semester!|.
  ENDMETHOD.
ENDCLASS.
