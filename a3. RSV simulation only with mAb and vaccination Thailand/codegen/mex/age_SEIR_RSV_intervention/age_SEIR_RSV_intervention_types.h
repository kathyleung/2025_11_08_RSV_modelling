/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * age_SEIR_RSV_intervention_types.h
 *
 * Code generation for function 'age_SEIR_RSV_intervention'
 *
 */

#pragma once

/* Include files */
#include "rtwtypes.h"
#include "emlrt.h"

/* Type Definitions */
#ifndef c_enum_c_matlab_internal_coder_
#define c_enum_c_matlab_internal_coder_
enum c_matlab_internal_coder_tabular
{
  unset = 0, /* Default value */
  continuous,
  step,
  event
};
#endif /* c_enum_c_matlab_internal_coder_ */
#ifndef c_typedef_c_matlab_internal_cod
#define c_typedef_c_matlab_internal_cod
typedef enum c_matlab_internal_coder_tabular c_matlab_internal_coder_tabular;
#endif /* c_typedef_c_matlab_internal_cod */

#ifndef typedef_cell_wrap_4
#define typedef_cell_wrap_4
typedef struct {
  real_T f1[15];
} cell_wrap_4;
#endif /* typedef_cell_wrap_4 */

#ifndef typedef_cell_wrap_6
#define typedef_cell_wrap_6
typedef struct {
  real_T f1[25];
} cell_wrap_6;
#endif /* typedef_cell_wrap_6 */

#ifndef c_typedef_d_matlab_internal_cod
#define c_typedef_d_matlab_internal_cod
typedef struct {
  real_T length;
} d_matlab_internal_coder_tabular;
#endif /* c_typedef_d_matlab_internal_cod */

#ifndef struct_emxArray_real_T
#define struct_emxArray_real_T
struct emxArray_real_T {
  real_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};
#endif /* struct_emxArray_real_T */
#ifndef typedef_emxArray_real_T
#define typedef_emxArray_real_T
typedef struct emxArray_real_T emxArray_real_T;
#endif /* typedef_emxArray_real_T */

#ifndef typedef_struct1_T
#define typedef_struct1_T
typedef struct {
  emxArray_real_T *timeVec;
  emxArray_real_T *Rt;
  emxArray_real_T *pMaternalProtection;
  real_T stateM[2007500];
  real_T stateS0[2007500];
  real_T stateS1[2007500];
  real_T stateS2[2007500];
  real_T stateS3[2007500];
  real_T stateE0[2007500];
  real_T stateE1[2007500];
  real_T stateE2[2007500];
  real_T stateE3[2007500];
  real_T stateI0[2007500];
  real_T stateI1[2007500];
  real_T stateI2[2007500];
  real_T stateI3[2007500];
  real_T stateA0[2007500];
  real_T stateA1[2007500];
  real_T stateA2[2007500];
  real_T stateA3[2007500];
  real_T stateR0[2007500];
  real_T stateR1[2007500];
  real_T stateR2[2007500];
  real_T stateR3[2007500];
  real_T stateZ[2007500];
  real_T stateVmab1[2007500];
  real_T stateVmab2[2007500];
  real_T stateVmvax1[2007500];
  real_T stateVmvax2[2007500];
  real_T stateVpvax1[2007500];
  real_T stateVpvax2[2007500];
} struct1_T;
#endif /* typedef_struct1_T */

#ifndef typedef_datetime
#define typedef_datetime
typedef struct {
  creal_T data;
  char_T fmt[10];
} datetime;
#endif /* typedef_datetime */

#ifndef c_typedef_e_matlab_internal_cod
#define c_typedef_e_matlab_internal_cod
typedef struct {
  real_T length;
  c_matlab_internal_coder_tabular continuity[5];
  boolean_T hasDescrs;
  boolean_T hasUnits;
  boolean_T hasContinuity;
  boolean_T hasCustomProps;
} e_matlab_internal_coder_tabular;
#endif /* c_typedef_e_matlab_internal_cod */

#ifndef typedef_table
#define typedef_table
typedef struct {
  d_matlab_internal_coder_tabular metaDim;
  e_matlab_internal_coder_tabular varDim;
  cell_wrap_4 data[5];
} table;
#endif /* typedef_table */

#ifndef c_typedef_f_matlab_internal_cod
#define c_typedef_f_matlab_internal_cod
typedef struct {
  real_T length;
  c_matlab_internal_coder_tabular continuity[3];
  boolean_T hasDescrs;
  boolean_T hasUnits;
  boolean_T hasContinuity;
  boolean_T hasCustomProps;
} f_matlab_internal_coder_tabular;
#endif /* c_typedef_f_matlab_internal_cod */

#ifndef typedef_b_table
#define typedef_b_table
typedef struct {
  d_matlab_internal_coder_tabular metaDim;
  f_matlab_internal_coder_tabular varDim;
  cell_wrap_6 data[3];
} b_table;
#endif /* typedef_b_table */

#ifndef c_typedef_b_age_SEIR_RSV_interv
#define c_typedef_b_age_SEIR_RSV_interv
typedef struct {
  struct1_T out;
} b_age_SEIR_RSV_intervention_api;
#endif /* c_typedef_b_age_SEIR_RSV_interv */

#ifndef c_typedef_c_age_SEIR_RSV_interv
#define c_typedef_c_age_SEIR_RSV_interv
typedef struct {
  b_age_SEIR_RSV_intervention_api f0;
} c_age_SEIR_RSV_interventionStac;
#endif /* c_typedef_c_age_SEIR_RSV_interv */

/* End of code generation (age_SEIR_RSV_intervention_types.h) */
