CLASS z070_tp_cl_geschenk DEFINITION
  PUBLIC
  INHERITING FROM z070_tp_cl_einkauf
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !iv_bezeichnung TYPE string
        !in_listenpreis TYPE dec10_2
        !iv_beschenkter TYPE string .

    METHODS calc_preis
        REDEFINITION .
    METHODS get_bezeichnung
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA mv_beschenkter TYPE string .
ENDCLASS.



CLASS Z070_TP_CL_GESCHENK IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_GESCHENK->CALC_PREIS
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RN_GESAMTPREIS                 TYPE        DEC10_2
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD calc_preis.
    DATA(ln_listenpreis) = me->get_listenpreis( ).
    DATA: ln_rabatt TYPE i.

    IF ln_listenpreis > 500.
      ln_rabatt = 13.
    ELSEIF ln_listenpreis > 250.
      ln_rabatt = 9.
    ELSEIF ln_listenpreis > 50.
      ln_rabatt = 5.
    ENDIF.

    rn_gesamtpreis = ln_listenpreis * ( 1 - ln_rabatt / 100 ).
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_GESCHENK->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_BEZEICHNUNG                 TYPE        STRING
* | [--->] IN_LISTENPREIS                 TYPE        DEC10_2
* | [--->] IV_BESCHENKTER                 TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD constructor.
    super->constructor(
      EXPORTING
        iv_bezeichnung = iv_bezeichnung
        in_listenpreis       = in_listenpreis       " Minimalzeit in mikrosek.
    ).

    mv_beschenkter = iv_beschenkter.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_GESCHENK->GET_BEZEICHNUNG
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_BEZEICHNUNG                 TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_bezeichnung.
    rv_bezeichnung = |{ super->get_bezeichnung( ) } für { mv_beschenkter }|.
  ENDMETHOD.
ENDCLASS.
