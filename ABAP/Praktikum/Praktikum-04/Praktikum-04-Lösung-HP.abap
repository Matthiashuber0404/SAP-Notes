*&---------------------------------------------------------------------*
*& Report ZKOE2_12A_P_R_FLUG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zkoe2_12a_p_r_flug.
DATA: go_flug TYPE REF TO zkoe2_12a_p_cl_flug,
      gt_flug TYPE TABLE OF REF TO zkoe2_12a_p_cl_flug.

zkoe2_12a_p_cl_flug=>display_n_o_airplanes( ).
WRITE: /'Anzahl (über funktionalen Aufruf):', zkoe2_12a_p_cl_flug=>get_n_o_airplanes( ).
SKIP 1.

go_flug = NEW zkoe2_12a_p_cl_flug(
   iv_name      = 'Plane 1'
    iv_planetype = '747-400'
).
APPEND go_flug TO gt_flug.

go_flug = NEW zkoe2_12a_p_cl_flug(
   iv_name      = 'Plane 2'
    iv_planetype = '747-500'
).
APPEND go_flug TO gt_flug.

LOOP AT gt_flug INTO go_flug.
  go_flug->display_atttributes( ).
ENDLOOP.

SKIP 1.
zkoe2_12a_p_cl_flug=>display_n_o_airplanes( ).
WRITE: /'Anzahl (über funktionalen Aufruf):', zkoe2_12a_p_cl_flug=>get_n_o_airplanes( ).