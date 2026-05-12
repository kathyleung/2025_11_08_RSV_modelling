/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_age_SEIR_RSV_intervention_mex.c
 *
 * Code generation for function '_coder_age_SEIR_RSV_intervention_mex'
 *
 */

/* Include files */
#include "_coder_age_SEIR_RSV_intervention_mex.h"
#include "_coder_age_SEIR_RSV_intervention_api.h"
#include "age_SEIR_RSV_intervention_data.h"
#include "age_SEIR_RSV_intervention_initialize.h"
#include "age_SEIR_RSV_intervention_terminate.h"
#include "age_SEIR_RSV_intervention_types.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void age_SEIR_RSV_intervention_mexFunction(c_age_SEIR_RSV_interventionStac *SD,
                                           int32_T nlhs, mxArray *plhs[1],
                                           int32_T nrhs,
                                           const mxArray *prhs[68])
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  const mxArray *outputs;
  st.tls = emlrtRootTLSGlobal;
  /* Check for proper number of arguments. */
  if (nrhs != 68) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 68, 4,
                        25, "age_SEIR_RSV_intervention");
  }
  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 25,
                        "age_SEIR_RSV_intervention");
  }
  /* Call the function. */
  age_SEIR_RSV_intervention_api(SD, prhs, &outputs);
  /* Copy over outputs to the caller. */
  emlrtReturnArrays(1, &plhs[0], &outputs);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs,
                 const mxArray *prhs[])
{
  c_age_SEIR_RSV_interventionStac *d_age_SEIR_RSV_interventionStac = NULL;
  d_age_SEIR_RSV_interventionStac =
      (c_age_SEIR_RSV_interventionStac *)emlrtMxCalloc(
          (size_t)1, (size_t)1U * sizeof(c_age_SEIR_RSV_interventionStac));
  mexAtExit(&age_SEIR_RSV_intervention_atexit);
  age_SEIR_RSV_intervention_initialize();
  age_SEIR_RSV_intervention_mexFunction(d_age_SEIR_RSV_interventionStac, nlhs,
                                        plhs, nrhs, prhs);
  age_SEIR_RSV_intervention_terminate();
  emlrtMxFree(d_age_SEIR_RSV_interventionStac);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLSR2022a(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1,
                           NULL, "windows-1252", true);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_age_SEIR_RSV_intervention_mex.c) */
