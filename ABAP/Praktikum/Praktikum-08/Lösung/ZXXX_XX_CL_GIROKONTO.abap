CLASS z070_tp_cl_girokonto DEFINITION
  PUBLIC
  INHERITING FROM z070_tp_cl_bankkonto
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !iv_kontoinhaber TYPE ts_bankkonto-kontoinhaber
        !in_dispokredit  TYPE tn_geldbetrag .

    METHODS get_data
        REDEFINITION .
    METHODS abheben
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA mn_dispokredit TYPE tn_geldbetrag .
ENDCLASS.



CLASS Z070_TP_CL_GIROKONTO IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_GIROKONTO->ABHEBEN
* +-------------------------------------------------------------------------------------------------+
* | [--->] IN_BETRAG                      TYPE        TN_GELDBETRAG
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD abheben.
    DATA ln_neuer_betrag TYPE tn_geldbetrag.

    ln_neuer_betrag = get_kontostand( ) - in_betrag.
    IF ln_neuer_betrag < ( - mn_dispokredit ).
      WRITE: / |Dieser Betrag kann vom Konto { get_kontonr( ) } nicht abgehoben werden. | &&
               |Der Dispokredit von { mn_dispokredit } € kann nicht überschritten werden.|.
    ELSE.
      me->set_kontostand( in_kontostand = ln_neuer_betrag ).
      WRITE: / |Es wurden { in_betrag } € erfolgreich vom Konto { get_kontonr( ) } abgehoben.|.
    ENDIF.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_GIROKONTO->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_KONTOINHABER                TYPE        TS_BANKKONTO-KONTOINHABER
* | [--->] IN_DISPOKREDIT                 TYPE        TN_GELDBETRAG
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD constructor.
    super->constructor( iv_kontoinhaber = iv_kontoinhaber ).
    mn_dispokredit = in_dispokredit.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_GIROKONTO->GET_DATA
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_DATA                        TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_data.
    rv_data = |Girokonto von { super->get_data( ) }, Kontonummer { get_kontonr( ) }, | &&
              |aktueller Kontostand { get_kontostand( ) } €, Disporahmen: { mn_dispokredit } €|.

  ENDMETHOD.
ENDCLASS.
