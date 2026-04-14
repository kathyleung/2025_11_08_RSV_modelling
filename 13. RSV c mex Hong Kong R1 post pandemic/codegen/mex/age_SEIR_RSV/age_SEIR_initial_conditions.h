/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * age_SEIR_initial_conditions.h
 *
 * Code generation for function 'age_SEIR_initial_conditions'
 *
 */

#pragma once

/* Include files */
#include "rtwtypes.h"
#include "emlrt.h"
#include "mex.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Declarations */
void age_SEIR_initial_conditions(
    const emlrtStack *sp, real_T stateM[2007500], real_T stateS0[2007500],
    real_T stateS1[2007500], real_T stateS2[2007500], real_T stateS3[2007500],
    real_T stateE0[2007500], real_T stateE1[2007500], real_T stateE2[2007500],
    real_T stateE3[2007500], real_T stateI0[2007500], real_T stateI1[2007500],
    real_T stateI2[2007500], real_T stateI3[2007500], real_T stateA0[2007500],
    real_T stateA1[2007500], real_T stateA2[2007500], real_T stateA3[2007500],
    real_T stateR0[2007500], real_T stateR1[2007500], real_T stateR2[2007500],
    real_T stateR3[2007500], const real_T totalPopulation[25],
    const real_T ageGroupDefRangeAll[26], const real_T iniInfectiousL1[25],
    const real_T iniRecoveredL2[25], real_T xiMaternalImmunity,
    real_T sigmaExposure, real_T gammaZeroPrimaryInfection,
    real_T g1ReductionInfectiousDuration, real_T g2ReductionInfectiousDuration,
    real_T delta1RelSuscep, real_T delta2RelSuscep, real_T delta3RelSuscep,
    const real_T pAsym[4], real_T pAsym_arr[25]);

/* End of code generation (age_SEIR_initial_conditions.h) */
