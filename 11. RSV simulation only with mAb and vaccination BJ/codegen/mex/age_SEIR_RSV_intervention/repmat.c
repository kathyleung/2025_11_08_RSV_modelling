/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * repmat.c
 *
 * Code generation for function 'repmat'
 *
 */

/* Include files */
#include "repmat.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void repmat(real_T b[675])
{
  static const int8_T b_iv[25] = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                                  1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0};
  int32_T itilerow;
  int32_T jcol;
  for (jcol = 0; jcol < 25; jcol++) {
    int32_T ibmat;
    ibmat = jcol * 27;
    for (itilerow = 0; itilerow < 27; itilerow++) {
      b[ibmat + itilerow] = b_iv[jcol];
    }
  }
}

/* End of code generation (repmat.c) */
