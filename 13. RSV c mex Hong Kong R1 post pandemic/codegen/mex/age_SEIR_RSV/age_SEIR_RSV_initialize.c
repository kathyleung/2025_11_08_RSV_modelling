/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * age_SEIR_RSV_initialize.c
 *
 * Code generation for function 'age_SEIR_RSV_initialize'
 *
 */

/* Include files */
#include "age_SEIR_RSV_initialize.h"
#include "_coder_age_SEIR_RSV_mex.h"
#include "age_SEIR_RSV_data.h"
#include "rt_nonfinite.h"

/* Function Declarations */
static void age_SEIR_RSV_once(void);

/* Function Definitions */
static void age_SEIR_RSV_once(void)
{
  mex_InitInfAndNan();
}

void age_SEIR_RSV_initialize(void)
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2022b(&st);
  emlrtClearAllocCountR2012b(&st, false, 0U, NULL);
  emlrtEnterRtStackR2012b(&st);
  if (emlrtFirstTimeR2012b(emlrtRootTLSGlobal)) {
    age_SEIR_RSV_once();
  }
}

/* End of code generation (age_SEIR_RSV_initialize.c) */
