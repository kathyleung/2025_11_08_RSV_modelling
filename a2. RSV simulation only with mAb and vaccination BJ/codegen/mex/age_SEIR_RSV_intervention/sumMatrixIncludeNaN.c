/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sumMatrixIncludeNaN.c
 *
 * Code generation for function 'sumMatrixIncludeNaN'
 *
 */

/* Include files */
#include "sumMatrixIncludeNaN.h"
#include "rt_nonfinite.h"

/* Function Definitions */
real_T b_sumColumnB(const real_T x[3])
{
  return (x[0] + x[1]) + x[2];
}

real_T c_sumColumnB(const real_T x[27])
{
  real_T y;
  int32_T k;
  y = x[0];
  for (k = 0; k < 26; k++) {
    y += x[k + 1];
  }
  return y;
}

real_T d_sumColumnB(const real_T x[25])
{
  real_T y;
  int32_T k;
  y = x[0];
  for (k = 0; k < 24; k++) {
    y += x[k + 1];
  }
  return y;
}

real_T e_sumColumnB(const real_T x[2])
{
  return x[0] + x[1];
}

real_T sumColumnB(const real_T x[675], int32_T col)
{
  real_T y;
  int32_T i0;
  int32_T k;
  i0 = (col - 1) * 27;
  y = x[i0];
  for (k = 0; k < 26; k++) {
    y += x[(i0 + k) + 1];
  }
  return y;
}

/* End of code generation (sumMatrixIncludeNaN.c) */
