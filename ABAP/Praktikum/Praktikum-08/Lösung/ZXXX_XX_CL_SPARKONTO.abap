CLASS z070_tp_cl_sparkonto DEFINITION
  PUBLIC
  INHERITING FROM z070_tp_cl_bankkonto
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !iv_kontoinhaber  TYPE ts_bankkonto-kontoinhaber
        !in_einzahlbetrag TYPE tn_geldbetrag .

    METHODS abheben
        REDEFINITION .
    METHODS get_data
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z070_TP_CL_SPARKONTO IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_SPARKONTO->ABHEBEN
* +-------------------------------------------------------------------------------------------------+
* | [--->] IN_BETRAG                      TYPE        TN_GELDBETRAG
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD abheben.
    DATA ln_neuer_betrag TYPE tn_geldbetrag.

    ln_neuer_betrag = get_kontostand( ) - in_betrag.
    IF ln_neuer_betrag < 0.
      WRITE: / |Eine Überziehung des Kontos { get_kontonr( ) } ist nicht erlaubt. | &&
               |Abheben von { in_betrag } € daher nicht möglich.|.
    ELSE.
      me->set_kontostand( in_kontostand = ln_neuer_betrag ).
      WRITE: / |Es wurden { in_betrag } € erfolgreich vom Konto { get_kontonr( ) } abgehoben.|.
    ENDIF.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_SPARKONTO->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_KONTOINHABER                TYPE        TS_BANKKONTO-KONTOINHABER
* | [--->] IN_EINZAHLBETRAG               TYPE        TN_GELDBETRAG
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD constructor.
    super->constructor( iv_kontoinhaber = iv_kontoinhaber ).
    me->einzahlen( in_betrag = in_einzahlbetrag ).
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_SPARKONTO->GET_DATA
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_DATA                        TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_data.
    rv_data = |Sparkonto Nr. { get_kontonr( ) } von { super->get_data( ) }, | &&
              |aktueller Kontostand { get_kontostand( ) } €. |.
  ENDMETHOD.
ENDCLASS.
