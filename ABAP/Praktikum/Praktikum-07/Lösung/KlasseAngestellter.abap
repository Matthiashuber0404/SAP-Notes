CLASS z070_tp_cl_angestellter DEFINITION
  PUBLIC
  INHERITING FROM z070_tp_cl_person
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !iv_name             TYPE string
        !iv_gebdatum         TYPE dats
        !in_besoldungsgruppe TYPE i .

    METHODS get_gehalt
        REDEFINITION .
    METHODS vorstellen
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA mn_besoldungsgruppe TYPE i .
ENDCLASS.



CLASS Z070_TP_CL_ANGESTELLTER IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_ANGESTELLTER->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_NAME                        TYPE        STRING
* | [--->] IV_GEBDATUM                    TYPE        DATS
* | [--->] IN_BESOLDUNGSGRUPPE            TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD constructor.
    super->constructor( iv_name = iv_name iv_gebdatum = iv_gebdatum ).

    DATA(ln_besoldungsgruppe) = in_besoldungsgruppe.
    IF ln_besoldungsgruppe > 16.
      ln_besoldungsgruppe = 16.
    ELSEIF ln_besoldungsgruppe < 1.
      ln_besoldungsgruppe = 1.
    ENDIF.

    mn_besoldungsgruppe = ln_besoldungsgruppe.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_ANGESTELLTER->GET_GEHALT
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RN_GEHALT                      TYPE        DEC8_2
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_gehalt.
    rn_gehalt = mn_besoldungsgruppe * get_alter( ) * 10.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_ANGESTELLTER->VORSTELLEN
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_VORSTELLEN                  TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD vorstellen.
    rv_vorstellen = |{ super->vorstellen( ) } Ich habe die Besoldungsgruppe { mn_besoldungsgruppe }.|.
  ENDMETHOD.
ENDCLASS.
