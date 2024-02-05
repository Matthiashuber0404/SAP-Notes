class ZKOE2_12A_P_CL_FLUG definition
  public
  final
  create public .

public section.

  methods CONSTRUCTOR
    importing
      value(IV_NAME) type STRING
      value(IV_PLANETYPE) type SAPLANE-PLANETYPE .
  methods DISPLAY_ATTTRIBUTES .
  class-methods DISPLAY_N_O_AIRPLANES .
  class-methods GET_N_O_AIRPLANES
    returning
      value(RN_COUNT) type I .
protected section.
private section.

  data MV_NAME type STRING .
  data MV_PLANETYPE type SAPLANE-PLANETYPE .
  class-data GN_O_AIRPLANES type I .

  methods SET_ATTRIBUTES
    importing
      !IV_NAME type STRING
      !IV_PLANETYPE type SAPLANE-PLANETYPE .
  methods GET_TECHNICAL_ATTRIBUTES
    exporting
      !EN_WEIGHT type SAPLANE-WEIGHT
      !EN_TANKCAP type SAPLANE-TANKCAP .
ENDCLASS.



CLASS ZKOE2_12A_P_CL_FLUG IMPLEMENTATION.


  method CONSTRUCTOR.
    set_attributes(
      EXPORTING
        iv_name      = iv_name
        iv_planetype = iv_planetype                 " Flugzeugtyp
    ).
  endmethod.


  METHOD display_atttributes.
    WRITE:/'Name:', 6 mv_name, 20 'Planetype:', 32 mv_planetype.
    get_technical_attributes(
      IMPORTING
        en_weight  =  DATA(ln_weight)                 " Gewicht des Flugzeugs
        en_tankcap =  DATA(ln_tankcap)                " Maximale Treibstoffmenge
    ).

    WRITE: 42 'Gewicht:', (15) ln_weight, 70 'Tankkapazität:', (15) ln_tankcap.
  ENDMETHOD.


  METHOD DISPLAY_N_O_AIRPLANES.
    WRITE:/'Anzahl an Objekten:', gn_o_airplanes.
  ENDMETHOD.


  method GET_N_O_AIRPLANES.
    rn_count = gn_o_airplanes.
  endmethod.


  METHOD get_technical_attributes.

    SELECT SINGLE weight, tankcap FROM saplane
      INTO (@en_weight, @en_tankcap)
      WHERE planetype = @mv_planetype.
    IF sy-subrc <> 0.
      en_tankcap = 10000.
      en_weight = 100000.
    ENDIF.

  ENDMETHOD.


  METHOD SET_ATTRIBUTES.
    mv_name = iv_name.
    mv_planetype = iv_planetype.
    gn_o_airplanes = gn_o_airplanes + 1.
  ENDMETHOD.
ENDCLASS.