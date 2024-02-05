CLASS z070_tp_cl_arbeiter DEFINITION
  PUBLIC
  INHERITING FROM z070_tp_cl_person
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !iv_name          TYPE string
        !iv_gebdatum      TYPE dats
        !in_wochenstunden TYPE i .

    METHODS vorstellen
        REDEFINITION .
    METHODS get_gehalt
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA mn_wochenstunden TYPE i .
ENDCLASS.



CLASS Z070_TP_CL_ARBEITER IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_ARBEITER->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_NAME                        TYPE        STRING
* | [--->] IV_GEBDATUM                    TYPE        DATS
* | [--->] IN_WOCHENSTUNDEN               TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD constructor.
    super->constructor( iv_name = iv_name iv_gebdatum = iv_gebdatum ).
    mn_wochenstunden = in_wochenstunden.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_ARBEITER->GET_GEHALT
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RN_GEHALT                      TYPE        DEC8_2
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_gehalt.
    DATA(ln_anz_stunden_pro_monat) = mn_wochenstunden * 4.
    rn_gehalt = ln_anz_stunden_pro_monat * 15.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_ARBEITER->VORSTELLEN
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_VORSTELLEN                  TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD vorstellen.
    rv_vorstellen = |Hallo, { super->vorstellen( ) } Ich arbeite { mn_wochenstunden } Stunden pro Woche!|.
  ENDMETHOD.
ENDCLASS.
