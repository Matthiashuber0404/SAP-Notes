CLASS z070_tp_cl_einkauf DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ts_einkauf,
        nummer      TYPE i,
        bezeichnung TYPE string,
        listenpreis TYPE dec10_2,
      END OF ts_einkauf .

    METHODS constructor
      IMPORTING
        !iv_bezeichnung TYPE string
        !in_listenpreis TYPE dec10_2 .
    METHODS display_attributes .
    METHODS calc_preis
          ABSTRACT
      RETURNING
        VALUE(rn_gesamtpreis) TYPE dec10_2 .
    METHODS get_bezeichnung
      RETURNING
        VALUE(rv_bezeichnung) TYPE string .
    CLASS-METHODS get_akt_nummer
      RETURNING
        VALUE(rn_akt_nummer) TYPE i .
  PROTECTED SECTION.

    METHODS get_listenpreis
      RETURNING
        VALUE(rn_listenpreis) TYPE dec10_2 .
  PRIVATE SECTION.

    DATA ms_einkauf TYPE ts_einkauf .
    CLASS-DATA gn_akt_nummer TYPE i VALUE 0 ##NO_TEXT.
ENDCLASS.



CLASS Z070_TP_CL_EINKAUF IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_EINKAUF->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_BEZEICHNUNG                 TYPE        STRING
* | [--->] IN_LISTENPREIS                 TYPE        DEC10_2
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD constructor.
    gn_akt_nummer = gn_akt_nummer + 10.

    ms_einkauf-nummer = gn_akt_nummer.
    ms_einkauf-bezeichnung = iv_bezeichnung.
    ms_einkauf-listenpreis = in_listenpreis.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_EINKAUF->DISPLAY_ATTRIBUTES
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD display_attributes.
    WRITE: /(3) ms_einkauf-nummer, 6 get_bezeichnung( ), 45 calc_preis( ).
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method Z070_TP_CL_EINKAUF=>GET_AKT_NUMMER
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RN_AKT_NUMMER                  TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_akt_nummer.
    rn_akt_nummer = gn_akt_nummer.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z070_TP_CL_EINKAUF->GET_BEZEICHNUNG
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_BEZEICHNUNG                 TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_bezeichnung.
    rv_bezeichnung = ms_einkauf-bezeichnung.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method Z070_TP_CL_EINKAUF->GET_LISTENPREIS
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RN_LISTENPREIS                 TYPE        DEC10_2
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_listenpreis.
    rn_listenpreis = ms_einkauf-listenpreis.
  ENDMETHOD.
ENDCLASS.
