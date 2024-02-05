CLASS z070_tp_cl_bankkonto DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      tn_geldbetrag(8) TYPE p DECIMALS 2 .
    TYPES:
      BEGIN OF ts_bankkonto,
        kontonummer(10) TYPE n,
        kontostand(8)   TYPE p DECIMALS 2,
        kontoinhaber    TYPE string,
      END OF ts_bankkonto .

    METHODS constructor
      IMPORTING
        !iv_kontoinhaber TYPE ts_bankkonto-kontoinhaber .
    METHODS get_kontonr
      RETURNING
        VALUE(rn_kontonr) TYPE ts_bankkonto-kontonummer .
    METHODS get_kontostand
      RETURNING
        VALUE(rn_kontostand) TYPE ts_bankkonto-kontostand .
    METHODS get_data
      RETURNING
        VALUE(rv_data) TYPE string .
    METHODS abheben
          ABSTRACT
      IMPORTING
        !in_betrag TYPE tn_geldbetrag .
    METHODS einzahlen
      IMPORTING
        !in_betrag TYPE tn_geldbetrag .
    METHODS transfer
      IMPORTING
        !in_betrag    TYPE tn_geldbetrag
        !io_bankkonto TYPE REF TO z070_tp_cl_bankkonto .
  PROTECTED SECTION.

    METHODS set_kontostand
      IMPORTING
        !in_kontostand TYPE ts_bankkonto-kontostand .
  PRIVATE SECTION.

    DATA ms_bankkonto TYPE ts_bankkonto .
    CLASS-DATA gn_aktuelle_knr TYPE ts_bankkonto-kontonummer VALUE 0100000000 ##NO_TEXT.
ENDCLASS.



CLASS Z070_TP_CL_BANKKONTO IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_BANKKONTO->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_KONTOINHABER                TYPE        TS_BANKKONTO-KONTOINHABER
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD constructor.
    gn_aktuelle_knr = gn_aktuelle_knr + 1.

    ms_bankkonto-kontoinhaber = iv_kontoinhaber.
    ms_bankkonto-kontonummer = gn_aktuelle_knr.
    ms_bankkonto-kontostand = 5.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_BANKKONTO->EINZAHLEN
* +-------------------------------------------------------------------------------------------------+
* | [--->] IN_BETRAG                      TYPE        TN_GELDBETRAG
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD einzahlen.
    ms_bankkonto-kontostand = ms_bankkonto-kontostand + in_betrag.
    WRITE: / |Es wurden { in_betrag } € erfolgreich in das Konto { ms_bankkonto-kontonummer } eingezahlt.|.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_BANKKONTO->GET_DATA
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_DATA                        TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_data.
    rv_data = ms_bankkonto-kontoinhaber.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_BANKKONTO->GET_KONTONR
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RN_KONTONR                     TYPE        TS_BANKKONTO-KONTONUMMER
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_kontonr.
    rn_kontonr = ms_bankkonto-kontonummer.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_BANKKONTO->GET_KONTOSTAND
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RN_KONTOSTAND                  TYPE        TS_BANKKONTO-KONTOSTAND
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_kontostand.
    rn_kontostand = ms_bankkonto-kontostand.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method Z070_TP_CL_BANKKONTO->SET_KONTOSTAND
* +-------------------------------------------------------------------------------------------------+
* | [--->] IN_KONTOSTAND                  TYPE        TS_BANKKONTO-KONTOSTAND
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD set_kontostand.
    ms_bankkonto-kontostand = in_kontostand.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_BANKKONTO->TRANSFER
* +-------------------------------------------------------------------------------------------------+
* | [--->] IN_BETRAG                      TYPE        TN_GELDBETRAG
* | [--->] IO_BANKKONTO                   TYPE REF TO Z070_TP_CL_BANKKONTO
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD transfer.
    WRITE: / |Transfer von { in_betrag } € von Kontonr { me->get_kontonr( ) } nach Kontonr { io_bankkonto->get_kontonr( ) }|.
    ULINE.
    me->abheben( in_betrag ).
    io_bankkonto->einzahlen( in_betrag ).
    ULINE.
  ENDMETHOD.
ENDCLASS.
