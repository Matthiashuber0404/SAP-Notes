CLASS z070_tp_cl_nahrung DEFINITION
  PUBLIC
  INHERITING FROM z070_tp_cl_einkauf
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !iv_bezeichnung TYPE string
        !in_listenpreis TYPE dec10_2
        !in_menge       TYPE i .

    METHODS get_bezeichnung
        REDEFINITION .
    METHODS calc_preis
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA mn_menge TYPE i .
ENDCLASS.



CLASS Z070_TP_CL_NAHRUNG IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_NAHRUNG->CALC_PREIS
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RN_GESAMTPREIS                 TYPE        DEC10_2
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD calc_preis.
    rn_gesamtpreis = get_listenpreis( ) * mn_menge.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_NAHRUNG->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_BEZEICHNUNG                 TYPE        STRING
* | [--->] IN_LISTENPREIS                 TYPE        DEC10_2
* | [--->] IN_MENGE                       TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD constructor.
    super->constructor(
      EXPORTING
        iv_bezeichnung = iv_bezeichnung
        in_listenpreis = in_listenpreis " Minimalzeit in mikrosek.
    ).

    IF in_menge <= 0.
      mn_menge = 1.
    ELSE.
      mn_menge = in_menge.
    ENDIF.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_NAHRUNG->GET_BEZEICHNUNG
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_BEZEICHNUNG                 TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_bezeichnung.
    rv_bezeichnung = |{ super->get_bezeichnung( ) } a { me->get_listenpreis( ) } ({ mn_menge } Stück)|.
  ENDMETHOD.
ENDCLASS.
