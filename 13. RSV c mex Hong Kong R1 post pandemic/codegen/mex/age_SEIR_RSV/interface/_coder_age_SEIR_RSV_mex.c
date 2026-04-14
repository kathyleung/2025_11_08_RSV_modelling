/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_age_SEIR_RSV_mex.c
 *
 * Code generation for function '_coder_age_SEIR_RSV_mex'
 *
 */

/* Include files */
#include "_coder_age_SEIR_RSV_mex.h"
#include "_coder_age_SEIR_RSV_api.h"
#include "age_SEIR_RSV_data.h"
#include "age_SEIR_RSV_initialize.h"
#include "age_SEIR_RSV_terminate.h"
#include "age_SEIR_RSV_types.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void age_SEIR_RSV_mexFunction(age_SEIR_RSVStackData *SD, int32_T nlhs,
                              mxArray *plhs[1], int32_T nrhs,
                              const mxArray *prhs[56])
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  const mxArray *outputs;
  st.tls = emlrtRootTLSGlobal;
  /* Check for proper number of arguments. */
  if (nrhs != 56) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 56, 4,
                        12, "age_SEIR_RSV");
  }
  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 12,
                        "age_SEIR_RSV");
  }
  /* Call the function. */
  age_SEIR_RSV_api(SD, prhs, &outputs);
  /* Copy over outputs to the caller. */
  emlrtReturnArrays(1, &plhs[0], &outputs);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs,
                 const mxArray *prhs[])
{
  age_SEIR_RSVStackData *age_SEIR_RSVStackDataGlobal = NULL;
  age_SEIR_RSVStackDataGlobal = (age_SEIR_RSVStackData *)emlrtMxCalloc(
      (size_t)1, (size_t)1U * sizeof(age_SEIR_RSVStackData));
  mexAtExit(&age_SEIR_RSV_atexit);
  age_SEIR_RSV_initialize();
  age_SEIR_RSV_mexFunction(age_SEIR_RSVStackDataGlobal, nlhs, plhs, nrhs, prhs);
  age_SEIR_RSV_terminate();
  emlrtMxFree(age_SEIR_RSVStackDataGlobal);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLSR2022a(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1,
                           NULL, "windows-1252", true);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_age_SEIR_RSV_mex.c) */
