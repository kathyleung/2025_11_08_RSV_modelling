/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * age_SEIR_RSV.c
 *
 * Code generation for function 'age_SEIR_RSV'
 *
 */

/* Include files */
#include "age_SEIR_RSV.h"
#include "age_SEIR_RSV_data.h"
#include "age_SEIR_RSV_emxutil.h"
#include "age_SEIR_RSV_types.h"
#include "age_SEIR_initial_conditions.h"
#include "indexShapeCheck.h"
#include "rt_nonfinite.h"
#include "sumMatrixIncludeNaN.h"
#include "mwmathutil.h"
#include <emmintrin.h>
#include <string.h>

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = {
    26,             /* lineNo */
    "age_SEIR_RSV", /* fcnName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m" /* pathName */
};

static emlrtRSInfo b_emlrtRSI = {
    53,             /* lineNo */
    "age_SEIR_RSV", /* fcnName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m" /* pathName */
};

static emlrtRSInfo c_emlrtRSI = {
    54,             /* lineNo */
    "age_SEIR_RSV", /* fcnName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m" /* pathName */
};

static emlrtRSInfo d_emlrtRSI = {
    84,             /* lineNo */
    "age_SEIR_RSV", /* fcnName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m" /* pathName */
};

static emlrtRSInfo e_emlrtRSI = {
    309,            /* lineNo */
    "age_SEIR_RSV", /* fcnName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m" /* pathName */
};

static emlrtRSInfo g_emlrtRSI = {
    44,       /* lineNo */
    "mpower", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2025a\\toolbox\\eml\\lib\\matlab\\matfun\\mpower.m" /* pathName
                                                                          */
};

static emlrtRSInfo h_emlrtRSI =
    {
        71,      /* lineNo */
        "power", /* fcnName */
        "C:\\Program "
        "Files\\MATLAB\\R2025a\\toolbox\\eml\\lib\\matlab\\ops\\power.m" /* pathName
                                                                          */
};

static emlrtRSInfo i_emlrtRSI = {
    8,               /* lineNo */
    "calcAgingRate", /* fcnName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\calcAgingRate."
    "m" /* pathName */
};

static emlrtRSInfo k_emlrtRSI =
    {
        139,     /* lineNo */
        "colon", /* fcnName */
        "C:\\Program "
        "Files\\MATLAB\\R2025a\\toolbox\\eml\\lib\\matlab\\ops\\colon.m" /* pathName
                                                                          */
};

static emlrtRSInfo l_emlrtRSI =
    {
        333,               /* lineNo */
        "eml_float_colon", /* fcnName */
        "C:\\Program "
        "Files\\MATLAB\\R2025a\\toolbox\\eml\\lib\\matlab\\ops\\colon.m" /* pathName
                                                                          */
};

static emlrtRTEInfo emlrtRTEI =
    {
        433,               /* lineNo */
        15,                /* colNo */
        "assert_pmaxsize", /* fName */
        "C:\\Program "
        "Files\\MATLAB\\R2025a\\toolbox\\eml\\lib\\matlab\\ops\\colon.m" /* pName
                                                                          */
};

static emlrtRTEInfo b_emlrtRTEI =
    {
        82,         /* lineNo */
        5,          /* colNo */
        "fltpower", /* fName */
        "C:\\Program "
        "Files\\MATLAB\\R2025a\\toolbox\\eml\\lib\\matlab\\ops\\power.m" /* pName
                                                                          */
};

static emlrtBCInfo emlrtBCI = {
    1,              /* iFirst */
    80300,          /* iLast */
    269,            /* lineNo */
    21,             /* colNo */
    "stateS0",      /* aName */
    "age_SEIR_RSV", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m", /* pName */
    0                                                            /* checkKind */
};

static emlrtBCInfo b_emlrtBCI = {
    1,              /* iFirst */
    80300,          /* iLast */
    127,            /* lineNo */
    16,             /* colNo */
    "stateM",       /* aName */
    "age_SEIR_RSV", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m", /* pName */
    3                                                            /* checkKind */
};

static emlrtBCInfo c_emlrtBCI = {
    1,              /* iFirst */
    80300,          /* iLast */
    91,             /* lineNo */
    49,             /* colNo */
    "stateA0",      /* aName */
    "age_SEIR_RSV", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m", /* pName */
    0                                                            /* checkKind */
};

static emlrtBCInfo d_emlrtBCI = {
    1,                         /* iFirst */
    8030,                      /* iLast */
    88,                        /* lineNo */
    76,                        /* colNo */
    "relTransmissionPHSMList", /* aName */
    "age_SEIR_RSV",            /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m", /* pName */
    0                                                            /* checkKind */
};

static emlrtDCInfo emlrtDCI = {
    88,             /* lineNo */
    76,             /* colNo */
    "age_SEIR_RSV", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m", /* pName */
    1                                                            /* checkKind */
};

static emlrtRTEInfo c_emlrtRTEI = {
    69,             /* lineNo */
    17,             /* colNo */
    "age_SEIR_RSV", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m" /* pName */
};

static emlrtDCInfo b_emlrtDCI = {
    3,               /* lineNo */
    1,               /* colNo */
    "calcAgingRate", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\calcAgingRate."
    "m", /* pName */
    1    /* checkKind */
};

static emlrtDCInfo c_emlrtDCI = {
    3,               /* lineNo */
    1,               /* colNo */
    "calcAgingRate", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\calcAgingRate."
    "m", /* pName */
    4    /* checkKind */
};

static emlrtBCInfo e_emlrtBCI = {
    -1,             /* iFirst */
    -1,             /* iLast */
    54,             /* lineNo */
    38,             /* colNo */
    "agingRate",    /* aName */
    "age_SEIR_RSV", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m", /* pName */
    0                                                            /* checkKind */
};

static emlrtDCInfo d_emlrtDCI = {
    54,             /* lineNo */
    38,             /* colNo */
    "age_SEIR_RSV", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m", /* pName */
    1                                                            /* checkKind */
};

static emlrtDCInfo e_emlrtDCI = {
    65,             /* lineNo */
    5,              /* colNo */
    "age_SEIR_RSV", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m", /* pName */
    1                                                            /* checkKind */
};

static emlrtDCInfo f_emlrtDCI = {
    65,             /* lineNo */
    5,              /* colNo */
    "age_SEIR_RSV", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m", /* pName */
    4                                                            /* checkKind */
};

static emlrtDCInfo g_emlrtDCI = {
    66,             /* lineNo */
    5,              /* colNo */
    "age_SEIR_RSV", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m", /* pName */
    1                                                            /* checkKind */
};

static emlrtBCInfo f_emlrtBCI = {
    -1,              /* iFirst */
    -1,              /* iLast */
    8,               /* lineNo */
    23,              /* colNo */
    "agingRate",     /* aName */
    "calcAgingRate", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\calcAgingRate."
    "m", /* pName */
    0    /* checkKind */
};

static emlrtBCInfo g_emlrtBCI = {
    1,              /* iFirst */
    80300,          /* iLast */
    78,             /* lineNo */
    30,             /* colNo */
    "stateA0",      /* aName */
    "age_SEIR_RSV", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m", /* pName */
    0                                                            /* checkKind */
};

static emlrtBCInfo h_emlrtBCI = {
    -1,             /* iFirst */
    -1,             /* iLast */
    95,             /* lineNo */
    15,             /* colNo */
    "refRt",        /* aName */
    "age_SEIR_RSV", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m", /* pName */
    0                                                            /* checkKind */
};

static emlrtBCInfo i_emlrtBCI = {
    -1,                       /* iFirst */
    -1,                       /* iLast */
    125,                      /* lineNo */
    32,                       /* colNo */
    "pMaternalProtectionRec", /* aName */
    "age_SEIR_RSV",           /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m", /* pName */
    0                                                            /* checkKind */
};

static emlrtBCInfo j_emlrtBCI = {
    -1,             /* iFirst */
    -1,             /* iLast */
    57,             /* lineNo */
    19,             /* colNo */
    "agingRate",    /* aName */
    "age_SEIR_RSV", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m", /* pName */
    0                                                            /* checkKind */
};

static emlrtDCInfo h_emlrtDCI = {
    57,             /* lineNo */
    19,             /* colNo */
    "age_SEIR_RSV", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m", /* pName */
    1                                                            /* checkKind */
};

static emlrtRTEInfo e_emlrtRTEI = {
    3,               /* lineNo */
    1,               /* colNo */
    "calcAgingRate", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\calcAgingRate."
    "m" /* pName */
};

static emlrtRTEInfo f_emlrtRTEI = {
    65,             /* lineNo */
    5,              /* colNo */
    "age_SEIR_RSV", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m" /* pName */
};

static emlrtRTEInfo g_emlrtRTEI = {
    66,             /* lineNo */
    5,              /* colNo */
    "age_SEIR_RSV", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m" /* pName */
};

static emlrtRTEInfo h_emlrtRTEI = {
    309,            /* lineNo */
    5,              /* colNo */
    "age_SEIR_RSV", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no ILI "
    "proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m" /* pName */
};

static emlrtRTEInfo i_emlrtRTEI =
    {
        334,     /* lineNo */
        20,      /* colNo */
        "colon", /* fName */
        "C:\\Program "
        "Files\\MATLAB\\R2025a\\toolbox\\eml\\lib\\matlab\\ops\\colon.m" /* pName
                                                                          */
};

/* Function Definitions */
void age_SEIR_RSV(
    const emlrtStack *sp, real_T stateM[2007500], real_T stateS0[2007500],
    real_T stateS1[2007500], real_T stateS2[2007500], real_T stateS3[2007500],
    real_T stateE0[2007500], real_T stateE1[2007500], real_T stateE2[2007500],
    real_T stateE3[2007500], real_T stateI0[2007500], real_T stateI1[2007500],
    real_T stateI2[2007500], real_T stateI3[2007500], real_T stateA0[2007500],
    real_T stateA1[2007500], real_T stateA2[2007500], real_T stateA3[2007500],
    real_T stateR0[2007500], real_T stateR1[2007500], real_T stateR2[2007500],
    real_T stateR3[2007500], real_T stateZ[2007500], real_T probVmAb,
    const real_T probVvax[2007500], const real_T totalPopulation[25],
    const real_T ageGroupDefRangeAll[26], const real_T muBirthRate[2],
    const table *populationSizeTable, const b_table *populationSizeTableRev,
    const real_T phyContactMatr[625], const real_T conversationContactMatr[625],
    real_T iniInfectiousProp, real_T iniRecoveredProp, const datetime *a__1,
    real_T dateStart, real_T numDays, real_T numTimeSteps, real_T dt,
    real_T xiMaternalImmunity, real_T omegaInfectionImmunity,
    real_T sigmaExposure, real_T gammaZeroPrimaryInfection,
    real_T g1ReductionInfectiousDuration, real_T g2ReductionInfectiousDuration,
    real_T delta1RelSuscep, real_T delta2RelSuscep, real_T delta3RelSuscep,
    const real_T pAsym[4], real_T alphaReductionInfectiousness,
    real_T qTransmissPhysical, real_T qTransmissConversation,
    real_T b1AmpTransmissPeak, real_T phiSeasonalShift,
    real_T psiSeasonalWavelength, real_T probSeropos,
    const real_T relTransmissionPHSMList[200750], struct1_T *out)
{
  static const int8_T b_iv[25] = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                                  1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0};
  __m128d r;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack st;
  real_T checkTotalPopulation[1050];
  real_T tempAging[525];
  real_T b_iniInfectiousProp[25];
  real_T b_iniRecoveredProp[25];
  real_T dailyMortalityByAge[25];
  real_T pAsym_arr[25];
  real_T b_stateM[2];
  real_T a;
  real_T a_tmp;
  real_T b_a;
  real_T b_a_tmp;
  real_T b_muBirthRate;
  real_T c_a;
  real_T c_a_tmp;
  real_T d_a;
  real_T d_a_tmp;
  real_T e_a;
  real_T f_a;
  real_T ndbl;
  real_T pMaternalProtection;
  real_T sumInfections;
  int32_T idx;
  int32_T ii;
  int32_T jjAge;
  int32_T loop_ub;
  int32_T loop_ub_tmp_tmp;
  int32_T tStep;
  int8_T agingIndicator[25];
  int8_T muBirthIndicator[25];
  boolean_T exitg1;
  (void)a__1;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  /*  Initialize parameters */
  for (ii = 0; ii < 25; ii++) {
    b_iniInfectiousProp[ii] = iniInfectiousProp;
    b_iniRecoveredProp[ii] = iniRecoveredProp;
  }
  st.site = &emlrtRSI;
  age_SEIR_initial_conditions(
      &st, stateM, stateS0, stateS1, stateS2, stateS3, stateE0, stateE1,
      stateE2, stateE3, stateI0, stateI1, stateI2, stateI3, stateA0, stateA1,
      stateA2, stateA3, stateR0, stateR1, stateR2, stateR3, totalPopulation,
      ageGroupDefRangeAll, b_iniInfectiousProp, b_iniRecoveredProp,
      xiMaternalImmunity, sigmaExposure, gammaZeroPrimaryInfection,
      g1ReductionInfectiousDuration, g2ReductionInfectiousDuration,
      delta1RelSuscep, delta2RelSuscep, delta3RelSuscep, pAsym, pAsym_arr);
  /*  Indicator function for new births */
  for (ii = 0; ii < 25; ii++) {
    muBirthIndicator[ii] = 0;
  }
  muBirthIndicator[0] = 1;
  /*  Indicator matrix for aging */
  for (ii = 0; ii < 25; ii++) {
    agingIndicator[ii] = 1;
  }
  agingIndicator[0] = 0;
  /*  Aging and mortality */
  st.site = &b_emlrtRSI;
  if (!muDoubleScalarIsNaN(populationSizeTableRev->data[1].f1[0])) {
    idx = 1;
  } else {
    idx = 0;
    loop_ub = 2;
    exitg1 = false;
    while ((!exitg1) && (loop_ub < 26)) {
      if (!muDoubleScalarIsNaN(
              populationSizeTableRev->data[1].f1[loop_ub - 1])) {
        idx = loop_ub;
        exitg1 = true;
      } else {
        loop_ub++;
      }
    }
  }
  if (idx == 0) {
    ndbl = populationSizeTableRev->data[1].f1[0];
  } else {
    ndbl = populationSizeTableRev->data[1].f1[idx - 1];
    idx++;
    for (ii = idx; ii < 26; ii++) {
      sumInfections = populationSizeTableRev->data[1].f1[ii - 1];
      if (ndbl < sumInfections) {
        ndbl = sumInfections;
      }
    }
  }
  ndbl *= 12.0;
  if (!(ndbl >= 0.0)) {
    emlrtNonNegativeCheckR2012b(ndbl, &c_emlrtDCI, &st);
  }
  sumInfections = (int32_T)muDoubleScalarFloor(ndbl);
  if (ndbl != sumInfections) {
    emlrtIntegerCheckR2012b(ndbl, &b_emlrtDCI, &st);
  }
  idx = out->Rt->size[0];
  loop_ub = (int32_T)ndbl;
  out->Rt->size[0] = (int32_T)ndbl;
  emxEnsureCapacity_real_T(&st, out->Rt, idx, &e_emlrtRTEI);
  if (ndbl != sumInfections) {
    emlrtIntegerCheckR2012b(ndbl, &b_emlrtDCI, &st);
  }
  for (ii = 0; ii < loop_ub; ii++) {
    out->Rt->data[ii] = 0.0;
  }
  for (ii = 0; ii < loop_ub; ii++) {
    idx = 0;
    exitg1 = false;
    while ((!exitg1) && (idx < 18)) {
      ndbl = ((real_T)ii + 1.0) / 12.0;
      if ((ndbl >= populationSizeTable->data[0].f1[idx]) &&
          (ndbl < populationSizeTable->data[1].f1[idx] + 1.0)) {
        b_st.site = &i_emlrtRSI;
        ndbl = 1.0 - populationSizeTable->data[4].f1[idx] / 1000.0;
        c_st.site = &g_emlrtRSI;
        d_st.site = &h_emlrtRSI;
        if (ndbl < 0.0) {
          emlrtErrorWithMessageIdR2018a(&d_st, &b_emlrtRTEI,
                                        "Coder:toolbox:power_domainError",
                                        "Coder:toolbox:power_domainError", 0);
        }
        if (((int32_T)((uint32_T)ii + 1U) < 1) ||
            ((int32_T)((uint32_T)ii + 1U) > out->Rt->size[0])) {
          emlrtDynamicBoundsCheckR2012b((int32_T)((uint32_T)ii + 1U), 1,
                                        out->Rt->size[0], &f_emlrtBCI, &st);
        }
        out->Rt->data[ii] =
            1.0 - muDoubleScalarPower(ndbl, 0.083333333333333329);
        exitg1 = true;
      } else {
        idx++;
      }
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(&st);
      }
    }
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(&st);
    }
  }
  for (ii = 0; ii <= 22; ii += 2) {
    _mm_storeu_pd(
        &b_iniInfectiousProp[ii],
        _mm_div_pd(
            _mm_set1_pd(1.0),
            _mm_mul_pd(_mm_set1_pd(365.25),
                       _mm_sub_pd(_mm_loadu_pd(&ageGroupDefRangeAll[ii + 1]),
                                  _mm_loadu_pd(&ageGroupDefRangeAll[ii])))));
  }
  b_iniInfectiousProp[24] =
      1.0 / (365.25 * (ageGroupDefRangeAll[25] - ageGroupDefRangeAll[24]));
  st.site = &c_emlrtRSI;
  indexShapeCheck(&st, out->Rt->size[0]);
  for (ii = 0; ii < 25; ii++) {
    b_iniRecoveredProp[ii] = muDoubleScalarRound(
        (ageGroupDefRangeAll[ii] + ageGroupDefRangeAll[ii + 1]) / 2.0 * 12.0);
  }
  for (ii = 0; ii < 25; ii++) {
    ndbl = b_iniRecoveredProp[ii] + 1.0;
    if (ndbl != (int32_T)ndbl) {
      emlrtIntegerCheckR2012b(ndbl, &d_emlrtDCI, (emlrtConstCTX)sp);
    }
    if (((int32_T)ndbl < 1) || ((int32_T)ndbl > out->Rt->size[0])) {
      emlrtDynamicBoundsCheckR2012b((int32_T)ndbl, 1, out->Rt->size[0],
                                    &e_emlrtBCI, (emlrtConstCTX)sp);
    }
    dailyMortalityByAge[ii] = out->Rt->data[(int32_T)ndbl - 1] / 365.25;
  }
  for (ii = 0; ii <= 22; ii += 2) {
    r = _mm_loadu_pd(&dailyMortalityByAge[ii]);
    _mm_storeu_pd(&dailyMortalityByAge[ii], _mm_mul_pd(r, _mm_set1_pd(12.0)));
  }
  ndbl = populationSizeTable->data[1].f1[15] * 12.0;
  if (ndbl != (int32_T)muDoubleScalarFloor(ndbl)) {
    emlrtIntegerCheckR2012b(ndbl, &h_emlrtDCI, (emlrtConstCTX)sp);
  }
  if (((int32_T)ndbl < 1) || ((int32_T)ndbl > out->Rt->size[0])) {
    emlrtDynamicBoundsCheckR2012b((int32_T)ndbl, 1, out->Rt->size[0],
                                  &j_emlrtBCI, (emlrtConstCTX)sp);
  }
  sumInfections = populationSizeTable->data[1].f1[16] * 12.0;
  if (sumInfections != (int32_T)muDoubleScalarFloor(sumInfections)) {
    emlrtIntegerCheckR2012b(sumInfections, &h_emlrtDCI, (emlrtConstCTX)sp);
  }
  if (((int32_T)sumInfections < 1) ||
      ((int32_T)sumInfections > out->Rt->size[0])) {
    emlrtDynamicBoundsCheckR2012b((int32_T)sumInfections, 1, out->Rt->size[0],
                                  &j_emlrtBCI, (emlrtConstCTX)sp);
  }
  pMaternalProtection = populationSizeTable->data[1].f1[17] * 12.0;
  if (pMaternalProtection !=
      (int32_T)muDoubleScalarFloor(pMaternalProtection)) {
    emlrtIntegerCheckR2012b(pMaternalProtection, &h_emlrtDCI,
                            (emlrtConstCTX)sp);
  }
  if (((int32_T)pMaternalProtection < 1) ||
      ((int32_T)pMaternalProtection > out->Rt->size[0])) {
    emlrtDynamicBoundsCheckR2012b((int32_T)pMaternalProtection, 1,
                                  out->Rt->size[0], &j_emlrtBCI,
                                  (emlrtConstCTX)sp);
  }
  dailyMortalityByAge[24] =
      ((populationSizeTable->data[3].f1[15] * out->Rt->data[(int32_T)ndbl - 1] +
        populationSizeTable->data[3].f1[16] *
            out->Rt->data[(int32_T)sumInfections - 1]) +
       populationSizeTable->data[3].f1[17] *
           out->Rt->data[(int32_T)pMaternalProtection - 1]) /
      b_sumColumnB(&populationSizeTable->data[3].f1[15]) / 365.25 * 12.0;
  /*  Adjust for population reduction */
  memset(&tempAging[0], 0, 525U * sizeof(real_T));
  memset(&checkTotalPopulation[0], 0, 1050U * sizeof(real_T));
  /*  Rt */
  if (!(numTimeSteps >= 0.0)) {
    emlrtNonNegativeCheckR2012b(numTimeSteps, &f_emlrtDCI, (emlrtConstCTX)sp);
  }
  loop_ub = (int32_T)muDoubleScalarFloor(numTimeSteps);
  if (numTimeSteps != loop_ub) {
    emlrtIntegerCheckR2012b(numTimeSteps, &e_emlrtDCI, (emlrtConstCTX)sp);
  }
  idx = out->Rt->size[0];
  out->Rt->size[0] = (int32_T)numTimeSteps;
  emxEnsureCapacity_real_T(sp, out->Rt, idx, &f_emlrtRTEI);
  if (numTimeSteps != loop_ub) {
    emlrtIntegerCheckR2012b(numTimeSteps, &e_emlrtDCI, (emlrtConstCTX)sp);
  }
  loop_ub_tmp_tmp = (int32_T)numTimeSteps;
  for (ii = 0; ii < loop_ub_tmp_tmp; ii++) {
    out->Rt->data[ii] = 0.0;
  }
  if (loop_ub_tmp_tmp != loop_ub) {
    emlrtIntegerCheckR2012b(numTimeSteps, &g_emlrtDCI, (emlrtConstCTX)sp);
  }
  idx = out->pMaternalProtection->size[0];
  out->pMaternalProtection->size[0] = loop_ub_tmp_tmp;
  emxEnsureCapacity_real_T(sp, out->pMaternalProtection, idx, &g_emlrtRTEI);
  if (loop_ub_tmp_tmp != loop_ub) {
    emlrtIntegerCheckR2012b(numTimeSteps, &g_emlrtDCI, (emlrtConstCTX)sp);
  }
  for (ii = 0; ii < loop_ub_tmp_tmp; ii++) {
    out->pMaternalProtection->data[ii] = 0.0;
  }
  /*  Main loop over time steps */
  loop_ub_tmp_tmp = (int32_T)(numTimeSteps - 1.0);
  emlrtForLoopVectorCheckR2021a(1.0, 1.0, numTimeSteps - 1.0, mxDOUBLE_CLASS,
                                loop_ub_tmp_tmp, &c_emlrtRTEI,
                                (emlrtConstCTX)sp);
  if ((numTimeSteps - 1.0) - 1.0 >= 0.0) {
    a = 1.0 / gammaZeroPrimaryInfection;
    a_tmp = gammaZeroPrimaryInfection / g1ReductionInfectiousDuration;
    b_a = 1.0 / a_tmp;
    b_a_tmp = a_tmp / g2ReductionInfectiousDuration;
    c_a = 1.0 / b_a_tmp;
    d_a = (1.0 - delta1RelSuscep) * probSeropos;
    c_a_tmp = delta2RelSuscep * delta1RelSuscep;
    e_a = (1.0 - c_a_tmp) * probSeropos;
    d_a_tmp = delta3RelSuscep * delta2RelSuscep * delta1RelSuscep;
    f_a = 1.0 - d_a_tmp;
    b_muBirthRate = muBirthRate[0];
  }
  for (tStep = 0; tStep < loop_ub_tmp_tmp; tStep++) {
    real_T e_a_tmp[25];
    real_T lambda_no_deltaSusp[25];
    real_T stateA0_tmp[25];
    real_T stateI0_tmp[25];
    /*  Calculate force of infection */
    pMaternalProtection = ((real_T)tStep + 1.0) * dt;
    ndbl = dateStart + pMaternalProtection;
    if (muDoubleScalarIsNaN(ndbl) || muDoubleScalarIsInf(ndbl)) {
      ndbl = rtNaN;
    } else {
      sumInfections = muDoubleScalarAbs(ndbl / 365.25);
      if (muDoubleScalarAbs(sumInfections -
                            muDoubleScalarFloor(sumInfections + 0.5)) >
          2.2204460492503131E-16 * sumInfections) {
        ndbl = muDoubleScalarRem(ndbl, 365.25);
      } else {
        ndbl = 0.0;
      }
      if (ndbl == 0.0) {
        ndbl = 0.0;
      } else if (ndbl < 0.0) {
        ndbl += 365.25;
      }
    }
    ndbl = ndbl / 365.25 - phiSeasonalShift;
    for (ii = 0; ii < 25; ii++) {
      /*  Calculate the force of infection using the contact matrices and
       * current state */
      sumInfections = 0.0;
      for (jjAge = 0; jjAge < 25; jjAge++) {
        if ((uint32_T)tStep + 1U > 80300U) {
          emlrtDynamicBoundsCheckR2012b((int32_T)((uint32_T)tStep + 1U), 1,
                                        80300, &g_emlrtBCI, (emlrtConstCTX)sp);
        }
        idx = ii + 25 * jjAge;
        loop_ub = tStep + 80300 * jjAge;
        sumInfections +=
            (phyContactMatr[idx] +
             qTransmissConversation * conversationContactMatr[idx]) *
            (((((((stateA0[loop_ub] * alphaReductionInfectiousness +
                   stateI0[loop_ub]) +
                  stateA1[loop_ub] * alphaReductionInfectiousness) +
                 stateI1[loop_ub]) +
                stateA2[loop_ub] * alphaReductionInfectiousness) +
               stateI2[loop_ub]) +
              stateA3[loop_ub] * alphaReductionInfectiousness) +
             stateI3[loop_ub]);
        if (*emlrtBreakCheckR2012bFlagVar != 0) {
          emlrtBreakCheckR2012b((emlrtConstCTX)sp);
        }
      }
      st.site = &d_emlrtRSI;
      b_st.site = &g_emlrtRSI;
      c_st.site = &h_emlrtRSI;
      st.site = &d_emlrtRSI;
      b_st.site = &g_emlrtRSI;
      c_st.site = &h_emlrtRSI;
      lambda_no_deltaSusp[ii] =
          qTransmissPhysical *
          (b1AmpTransmissPeak *
               muDoubleScalarExp(
                   ndbl * ndbl /
                   (2.0 * (psiSeasonalWavelength * psiSeasonalWavelength))) +
           1.0) *
          sumInfections;
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b((emlrtConstCTX)sp);
      }
    }
    ndbl = muDoubleScalarCeil(pMaternalProtection);
    if (ndbl != (int32_T)ndbl) {
      emlrtIntegerCheckR2012b(ndbl, &emlrtDCI, (emlrtConstCTX)sp);
    }
    if (((int32_T)ndbl < 1) || ((int32_T)ndbl > 8030)) {
      emlrtDynamicBoundsCheckR2012b((int32_T)ndbl, 1, 8030, &d_emlrtBCI,
                                    (emlrtConstCTX)sp);
    }
    for (ii = 0; ii < 25; ii++) {
      lambda_no_deltaSusp[ii] *=
          relTransmissionPHSMList[((int32_T)ndbl + 8030 * ii) - 1];
    }
    if (tStep + 1 > 80300) {
      emlrtDynamicBoundsCheckR2012b(tStep + 1, 1, 80300, &c_emlrtBCI,
                                    (emlrtConstCTX)sp);
    }
    ndbl = 0.0;
    for (ii = 0; ii < 25; ii++) {
      idx = tStep + 80300 * ii;
      ndbl +=
          lambda_no_deltaSusp[ii] /
          (((((((a * stateA0[idx] + a * stateI0[idx]) + b_a * stateA1[idx]) +
               b_a * stateI1[idx]) +
              c_a * stateA2[idx]) +
             c_a * stateI2[idx]) +
            c_a * stateA3[idx]) +
           c_a * stateI3[idx]) *
          totalPopulation[ii];
    }
    if ((int32_T)((uint32_T)tStep + 1U) > out->Rt->size[0]) {
      emlrtDynamicBoundsCheckR2012b((int32_T)((uint32_T)tStep + 1U), 1,
                                    out->Rt->size[0], &h_emlrtBCI,
                                    (emlrtConstCTX)sp);
    }
    out->Rt->data[tStep] = ndbl;
    /*  Vaccination in reducing susceptibility */
    for (ii = 0; ii < 25; ii++) {
      lambda_no_deltaSusp[ii] *= 1.0 - probVvax[tStep + 80300 * ii];
    }
    /*  Update each state variable using the ODEs */
    /*  Combining mAb and maternal protection, assuming all mothers are 25-44 */
    b_stateM[0] = (((((((((((((((((((stateM[tStep + 1525700] +
                                     0.0 * stateS0[tStep + 1525700]) +
                                    0.0 * stateE0[tStep + 1525700]) +
                                   0.0 * stateI0[tStep + 1525700]) +
                                  0.0 * stateA0[tStep + 1525700]) +
                                 probSeropos * stateR0[tStep + 1525700]) +
                                d_a * stateS1[tStep + 1525700]) +
                               0.0 * stateE1[tStep + 1525700]) +
                              0.0 * stateI1[tStep + 1525700]) +
                             0.0 * stateA1[tStep + 1525700]) +
                            probSeropos * stateR1[tStep + 1525700]) +
                           e_a * stateS2[tStep + 1525700]) +
                          0.0 * stateE2[tStep + 1525700]) +
                         0.0 * stateI2[tStep + 1525700]) +
                        0.0 * stateA2[tStep + 1525700]) +
                       probSeropos * stateR2[tStep + 1525700]) +
                      f_a * stateS3[tStep + 1525700]) +
                     0.0 * stateE3[tStep + 1525700]) +
                    0.0 * stateI3[tStep + 1525700]) +
                   0.0 * stateA3[tStep + 1525700]) +
                  probSeropos * stateR3[tStep + 1525700];
    b_stateM[1] = (((((((((((((((((((stateM[tStep + 1606000] +
                                     0.0 * stateS0[tStep + 1606000]) +
                                    0.0 * stateE0[tStep + 1606000]) +
                                   0.0 * stateI0[tStep + 1606000]) +
                                  0.0 * stateA0[tStep + 1606000]) +
                                 probSeropos * stateR0[tStep + 1606000]) +
                                d_a * stateS1[tStep + 1606000]) +
                               0.0 * stateE1[tStep + 1606000]) +
                              0.0 * stateI1[tStep + 1606000]) +
                             0.0 * stateA1[tStep + 1606000]) +
                            probSeropos * stateR1[tStep + 1606000]) +
                           e_a * stateS2[tStep + 1606000]) +
                          0.0 * stateE2[tStep + 1606000]) +
                         0.0 * stateI2[tStep + 1606000]) +
                        0.0 * stateA2[tStep + 1606000]) +
                       probSeropos * stateR2[tStep + 1606000]) +
                      f_a * stateS3[tStep + 1606000]) +
                     0.0 * stateE3[tStep + 1606000]) +
                    0.0 * stateI3[tStep + 1606000]) +
                   0.0 * stateA3[tStep + 1606000]) +
                  probSeropos * stateR3[tStep + 1606000];
    pMaternalProtection = probVmAb + (1.0 - probVmAb) * c_sumColumnB(b_stateM) /
                                         c_sumColumnB(&totalPopulation[19]);
    /* . */
    if ((int32_T)((uint32_T)tStep + 1U) > out->pMaternalProtection->size[0]) {
      emlrtDynamicBoundsCheckR2012b((int32_T)((uint32_T)tStep + 1U), 1,
                                    out->pMaternalProtection->size[0],
                                    &i_emlrtBCI, (emlrtConstCTX)sp);
    }
    out->pMaternalProtection->data[tStep] = pMaternalProtection;
    for (ii = 0; ii < 25; ii++) {
      b_iniRecoveredProp[ii] = b_muBirthRate * (real_T)muBirthIndicator[ii];
    }
    e_a_tmp[0] = 0.0;
    for (ii = 0; ii < 24; ii++) {
      e_a_tmp[ii + 1] = b_iniInfectiousProp[ii] * stateM[tStep + 80300 * ii] *
                        (real_T)agingIndicator[ii + 1];
    }
    if ((int32_T)((uint32_T)tStep + 2U) > 80300) {
      emlrtDynamicBoundsCheckR2012b((int32_T)((uint32_T)tStep + 2U), 1, 80300,
                                    &b_emlrtBCI, (emlrtConstCTX)sp);
    }
    for (ii = 0; ii < 25; ii++) {
      ndbl = stateM[tStep + 80300 * ii];
      e_a_tmp[ii] = (tempAging[21 * ii] + ndbl) +
                    ((((pMaternalProtection * b_iniRecoveredProp[ii] -
                        xiMaternalImmunity * ndbl) -
                       b_iniInfectiousProp[ii] * ndbl) +
                      e_a_tmp[ii]) -
                     ndbl * dailyMortalityByAge[ii]) *
                        dt;
    }
    for (ii = 0; ii < 25; ii++) {
      stateM[(tStep + 80300 * ii) + 1] = e_a_tmp[ii];
    }
    e_a_tmp[0] = 0.0;
    for (ii = 0; ii < 24; ii++) {
      e_a_tmp[ii + 1] = b_iniInfectiousProp[ii] * stateS0[tStep + 80300 * ii] *
                        (real_T)agingIndicator[ii + 1];
    }
    for (ii = 0; ii < 25; ii++) {
      idx = tStep + 80300 * ii;
      ndbl = stateS0[idx];
      b_iniRecoveredProp[ii] =
          (tempAging[21 * ii + 1] + ndbl) +
          ((((((1.0 - pMaternalProtection) * b_iniRecoveredProp[ii] +
               xiMaternalImmunity * stateM[idx]) -
              lambda_no_deltaSusp[ii] * ndbl) -
             b_iniInfectiousProp[ii] * ndbl) +
            e_a_tmp[ii]) -
           ndbl * dailyMortalityByAge[ii]) *
              dt;
    }
    for (ii = 0; ii < 25; ii++) {
      stateS0[(tStep + 80300 * ii) + 1] = b_iniRecoveredProp[ii];
    }
    e_a_tmp[0] = 0.0;
    for (ii = 0; ii < 24; ii++) {
      e_a_tmp[ii + 1] = b_iniInfectiousProp[ii] * stateE0[tStep + 80300 * ii] *
                        (real_T)agingIndicator[ii + 1];
    }
    for (ii = 0; ii < 25; ii++) {
      idx = tStep + 80300 * ii;
      ndbl = stateE0[idx];
      e_a_tmp[ii] =
          (tempAging[21 * ii + 2] + ndbl) +
          ((((lambda_no_deltaSusp[ii] * stateS0[idx] - sigmaExposure * ndbl) -
             b_iniInfectiousProp[ii] * ndbl) +
            e_a_tmp[ii]) -
           ndbl * dailyMortalityByAge[ii]) *
              dt;
    }
    for (ii = 0; ii < 25; ii++) {
      stateE0[(tStep + 80300 * ii) + 1] = e_a_tmp[ii];
      stateA0_tmp[ii] = sigmaExposure * pAsym_arr[ii];
    }
    e_a_tmp[0] = 0.0;
    for (ii = 0; ii < 24; ii++) {
      e_a_tmp[ii + 1] = b_iniInfectiousProp[ii] * stateA0[tStep + 80300 * ii] *
                        (real_T)agingIndicator[ii + 1];
    }
    for (ii = 0; ii < 25; ii++) {
      idx = tStep + 80300 * ii;
      ndbl = stateA0[idx];
      e_a_tmp[ii] = (tempAging[21 * ii + 3] + ndbl) +
                    ((((stateA0_tmp[ii] * stateE0[idx] -
                        gammaZeroPrimaryInfection * ndbl) -
                       b_iniInfectiousProp[ii] * ndbl) +
                      e_a_tmp[ii]) -
                     ndbl * dailyMortalityByAge[ii]) *
                        dt;
    }
    for (ii = 0; ii < 25; ii++) {
      stateA0[(tStep + 80300 * ii) + 1] = e_a_tmp[ii];
      stateI0_tmp[ii] = sigmaExposure * (1.0 - pAsym_arr[ii]);
    }
    e_a_tmp[0] = 0.0;
    for (ii = 0; ii < 24; ii++) {
      e_a_tmp[ii + 1] = b_iniInfectiousProp[ii] * stateI0[tStep + 80300 * ii] *
                        (real_T)agingIndicator[ii + 1];
    }
    for (ii = 0; ii < 25; ii++) {
      idx = tStep + 80300 * ii;
      ndbl = stateI0[idx];
      e_a_tmp[ii] = (tempAging[21 * ii + 4] + ndbl) +
                    ((((stateI0_tmp[ii] * stateE0[idx] -
                        gammaZeroPrimaryInfection * ndbl) -
                       b_iniInfectiousProp[ii] * ndbl) +
                      e_a_tmp[ii]) -
                     ndbl * dailyMortalityByAge[ii]) *
                        dt;
    }
    for (ii = 0; ii < 25; ii++) {
      stateI0[(tStep + 80300 * ii) + 1] = e_a_tmp[ii];
    }
    e_a_tmp[0] = 0.0;
    for (ii = 0; ii < 24; ii++) {
      e_a_tmp[ii + 1] = b_iniInfectiousProp[ii] * stateR0[tStep + 80300 * ii] *
                        (real_T)agingIndicator[ii + 1];
    }
    for (ii = 0; ii < 25; ii++) {
      idx = tStep + 80300 * ii;
      ndbl = stateR0[idx];
      e_a_tmp[ii] =
          (tempAging[21 * ii + 5] + ndbl) +
          ((((gammaZeroPrimaryInfection * (stateA0[idx] + stateI0[idx]) -
              omegaInfectionImmunity * ndbl) -
             b_iniInfectiousProp[ii] * ndbl) +
            e_a_tmp[ii]) -
           ndbl * dailyMortalityByAge[ii]) *
              dt;
    }
    for (ii = 0; ii < 25; ii++) {
      stateR0[(tStep + 80300 * ii) + 1] = e_a_tmp[ii];
      b_iniRecoveredProp[ii] = delta1RelSuscep * lambda_no_deltaSusp[ii];
    }
    e_a_tmp[0] = 0.0;
    for (ii = 0; ii < 24; ii++) {
      e_a_tmp[ii + 1] = b_iniInfectiousProp[ii] * stateS1[tStep + 80300 * ii] *
                        (real_T)agingIndicator[ii + 1];
    }
    for (ii = 0; ii < 25; ii++) {
      idx = tStep + 80300 * ii;
      ndbl = stateS1[idx];
      e_a_tmp[ii] = (tempAging[21 * ii + 6] + ndbl) +
                    ((((omegaInfectionImmunity * stateR0[idx] -
                        b_iniRecoveredProp[ii] * ndbl) -
                       b_iniInfectiousProp[ii] * ndbl) +
                      e_a_tmp[ii]) -
                     ndbl * dailyMortalityByAge[ii]) *
                        dt;
    }
    for (ii = 0; ii < 25; ii++) {
      stateS1[(tStep + 80300 * ii) + 1] = e_a_tmp[ii];
    }
    e_a_tmp[0] = 0.0;
    for (ii = 0; ii < 24; ii++) {
      e_a_tmp[ii + 1] = b_iniInfectiousProp[ii] * stateE1[tStep + 80300 * ii] *
                        (real_T)agingIndicator[ii + 1];
    }
    for (ii = 0; ii < 25; ii++) {
      idx = tStep + 80300 * ii;
      ndbl = stateE1[idx];
      b_iniRecoveredProp[ii] =
          (tempAging[21 * ii + 7] + ndbl) +
          ((((b_iniRecoveredProp[ii] * stateS1[idx] - sigmaExposure * ndbl) -
             b_iniInfectiousProp[ii] * ndbl) +
            e_a_tmp[ii]) -
           ndbl * dailyMortalityByAge[ii]) *
              dt;
    }
    for (ii = 0; ii < 25; ii++) {
      stateE1[(tStep + 80300 * ii) + 1] = b_iniRecoveredProp[ii];
    }
    e_a_tmp[0] = 0.0;
    for (ii = 0; ii < 24; ii++) {
      e_a_tmp[ii + 1] = b_iniInfectiousProp[ii] * stateA1[tStep + 80300 * ii] *
                        (real_T)agingIndicator[ii + 1];
    }
    for (ii = 0; ii < 25; ii++) {
      idx = tStep + 80300 * ii;
      ndbl = stateA1[idx];
      e_a_tmp[ii] = (tempAging[21 * ii + 8] + ndbl) +
                    ((((stateA0_tmp[ii] * stateE1[idx] - a_tmp * ndbl) -
                       b_iniInfectiousProp[ii] * ndbl) +
                      e_a_tmp[ii]) -
                     ndbl * dailyMortalityByAge[ii]) *
                        dt;
    }
    for (ii = 0; ii < 25; ii++) {
      stateA1[(tStep + 80300 * ii) + 1] = e_a_tmp[ii];
    }
    e_a_tmp[0] = 0.0;
    for (ii = 0; ii < 24; ii++) {
      e_a_tmp[ii + 1] = b_iniInfectiousProp[ii] * stateI1[tStep + 80300 * ii] *
                        (real_T)agingIndicator[ii + 1];
    }
    for (ii = 0; ii < 25; ii++) {
      idx = tStep + 80300 * ii;
      ndbl = stateI1[idx];
      e_a_tmp[ii] = (tempAging[21 * ii + 9] + ndbl) +
                    ((((stateI0_tmp[ii] * stateE1[idx] - a_tmp * ndbl) -
                       b_iniInfectiousProp[ii] * ndbl) +
                      e_a_tmp[ii]) -
                     ndbl * dailyMortalityByAge[ii]) *
                        dt;
    }
    for (ii = 0; ii < 25; ii++) {
      stateI1[(tStep + 80300 * ii) + 1] = e_a_tmp[ii];
    }
    e_a_tmp[0] = 0.0;
    for (ii = 0; ii < 24; ii++) {
      e_a_tmp[ii + 1] = b_iniInfectiousProp[ii] * stateR1[tStep + 80300 * ii] *
                        (real_T)agingIndicator[ii + 1];
    }
    for (ii = 0; ii < 25; ii++) {
      idx = tStep + 80300 * ii;
      ndbl = stateR1[idx];
      e_a_tmp[ii] = (tempAging[21 * ii + 10] + ndbl) +
                    ((((a_tmp * (stateA1[idx] + stateI1[idx]) -
                        omegaInfectionImmunity * ndbl) -
                       b_iniInfectiousProp[ii] * ndbl) +
                      e_a_tmp[ii]) -
                     ndbl * dailyMortalityByAge[ii]) *
                        dt;
    }
    /*  Similar updates for stateS2, stateE2, stateA2, stateI2, stateR2 */
    /*  Similar updates for stateS3, stateE3, stateA3, stateI3, stateR3 */
    /*  Update stateS2, stateE2, stateA2, stateI2, stateR2 */
    for (ii = 0; ii < 25; ii++) {
      stateR1[(tStep + 80300 * ii) + 1] = e_a_tmp[ii];
      b_iniRecoveredProp[ii] = c_a_tmp * lambda_no_deltaSusp[ii];
    }
    e_a_tmp[0] = 0.0;
    for (ii = 0; ii < 24; ii++) {
      e_a_tmp[ii + 1] = b_iniInfectiousProp[ii] * stateS2[tStep + 80300 * ii] *
                        (real_T)agingIndicator[ii + 1];
    }
    for (ii = 0; ii < 25; ii++) {
      idx = tStep + 80300 * ii;
      ndbl = stateS2[idx];
      e_a_tmp[ii] = (tempAging[21 * ii + 11] + ndbl) +
                    ((((omegaInfectionImmunity * stateR1[idx] -
                        b_iniRecoveredProp[ii] * ndbl) -
                       b_iniInfectiousProp[ii] * ndbl) +
                      e_a_tmp[ii]) -
                     ndbl * dailyMortalityByAge[ii]) *
                        dt;
    }
    for (ii = 0; ii < 25; ii++) {
      stateS2[(tStep + 80300 * ii) + 1] = e_a_tmp[ii];
    }
    e_a_tmp[0] = 0.0;
    for (ii = 0; ii < 24; ii++) {
      e_a_tmp[ii + 1] = b_iniInfectiousProp[ii] * stateE2[tStep + 80300 * ii] *
                        (real_T)agingIndicator[ii + 1];
    }
    for (ii = 0; ii < 25; ii++) {
      idx = tStep + 80300 * ii;
      ndbl = stateE2[idx];
      b_iniRecoveredProp[ii] =
          (tempAging[21 * ii + 12] + ndbl) +
          ((((b_iniRecoveredProp[ii] * stateS2[idx] - sigmaExposure * ndbl) -
             b_iniInfectiousProp[ii] * ndbl) +
            e_a_tmp[ii]) -
           ndbl * dailyMortalityByAge[ii]) *
              dt;
    }
    for (ii = 0; ii < 25; ii++) {
      stateE2[(tStep + 80300 * ii) + 1] = b_iniRecoveredProp[ii];
    }
    e_a_tmp[0] = 0.0;
    for (ii = 0; ii < 24; ii++) {
      e_a_tmp[ii + 1] = b_iniInfectiousProp[ii] * stateA2[tStep + 80300 * ii] *
                        (real_T)agingIndicator[ii + 1];
    }
    for (ii = 0; ii < 25; ii++) {
      idx = tStep + 80300 * ii;
      ndbl = stateA2[idx];
      e_a_tmp[ii] = (tempAging[21 * ii + 13] + ndbl) +
                    ((((stateA0_tmp[ii] * stateE2[idx] - b_a_tmp * ndbl) -
                       b_iniInfectiousProp[ii] * ndbl) +
                      e_a_tmp[ii]) -
                     ndbl * dailyMortalityByAge[ii]) *
                        dt;
    }
    for (ii = 0; ii < 25; ii++) {
      stateA2[(tStep + 80300 * ii) + 1] = e_a_tmp[ii];
    }
    e_a_tmp[0] = 0.0;
    for (ii = 0; ii < 24; ii++) {
      e_a_tmp[ii + 1] = b_iniInfectiousProp[ii] * stateI2[tStep + 80300 * ii] *
                        (real_T)agingIndicator[ii + 1];
    }
    for (ii = 0; ii < 25; ii++) {
      idx = tStep + 80300 * ii;
      ndbl = stateI2[idx];
      e_a_tmp[ii] = (tempAging[21 * ii + 14] + ndbl) +
                    ((((stateI0_tmp[ii] * stateE2[idx] - b_a_tmp * ndbl) -
                       b_iniInfectiousProp[ii] * ndbl) +
                      e_a_tmp[ii]) -
                     ndbl * dailyMortalityByAge[ii]) *
                        dt;
    }
    for (ii = 0; ii < 25; ii++) {
      stateI2[(tStep + 80300 * ii) + 1] = e_a_tmp[ii];
    }
    e_a_tmp[0] = 0.0;
    for (ii = 0; ii < 24; ii++) {
      e_a_tmp[ii + 1] = b_iniInfectiousProp[ii] * stateR2[tStep + 80300 * ii] *
                        (real_T)agingIndicator[ii + 1];
    }
    for (ii = 0; ii < 25; ii++) {
      idx = tStep + 80300 * ii;
      ndbl = stateR2[idx];
      e_a_tmp[ii] = (tempAging[21 * ii + 15] + ndbl) +
                    ((((b_a_tmp * (stateA2[idx] + stateI2[idx]) -
                        omegaInfectionImmunity * ndbl) -
                       b_iniInfectiousProp[ii] * ndbl) +
                      e_a_tmp[ii]) -
                     ndbl * dailyMortalityByAge[ii]) *
                        dt;
    }
    /*  Update stateS3, stateE3, stateA3, stateI3, stateR3 */
    for (ii = 0; ii < 25; ii++) {
      idx = tStep + 80300 * ii;
      stateR2[idx + 1] = e_a_tmp[ii];
      lambda_no_deltaSusp[ii] *= d_a_tmp;
      b_iniRecoveredProp[ii] = omegaInfectionImmunity * stateR3[idx];
    }
    e_a_tmp[0] = 0.0;
    for (ii = 0; ii < 24; ii++) {
      e_a_tmp[ii + 1] = b_iniInfectiousProp[ii] * stateS3[tStep + 80300 * ii] *
                        (real_T)agingIndicator[ii + 1];
    }
    for (ii = 0; ii < 25; ii++) {
      idx = tStep + 80300 * ii;
      ndbl = stateS3[idx];
      e_a_tmp[ii] =
          (tempAging[21 * ii + 16] + ndbl) +
          (((((omegaInfectionImmunity * stateR2[idx] + b_iniRecoveredProp[ii]) -
              lambda_no_deltaSusp[ii] * ndbl) -
             b_iniInfectiousProp[ii] * ndbl) +
            e_a_tmp[ii]) -
           ndbl * dailyMortalityByAge[ii]) *
              dt;
    }
    for (ii = 0; ii < 25; ii++) {
      stateS3[(tStep + 80300 * ii) + 1] = e_a_tmp[ii];
    }
    e_a_tmp[0] = 0.0;
    for (ii = 0; ii < 24; ii++) {
      e_a_tmp[ii + 1] = b_iniInfectiousProp[ii] * stateE3[tStep + 80300 * ii] *
                        (real_T)agingIndicator[ii + 1];
    }
    for (ii = 0; ii < 25; ii++) {
      idx = tStep + 80300 * ii;
      ndbl = stateE3[idx];
      lambda_no_deltaSusp[ii] =
          (tempAging[21 * ii + 17] + ndbl) +
          ((((lambda_no_deltaSusp[ii] * stateS3[idx] - sigmaExposure * ndbl) -
             b_iniInfectiousProp[ii] * ndbl) +
            e_a_tmp[ii]) -
           ndbl * dailyMortalityByAge[ii]) *
              dt;
    }
    for (ii = 0; ii < 25; ii++) {
      stateE3[(tStep + 80300 * ii) + 1] = lambda_no_deltaSusp[ii];
    }
    e_a_tmp[0] = 0.0;
    for (ii = 0; ii < 24; ii++) {
      e_a_tmp[ii + 1] = b_iniInfectiousProp[ii] * stateA3[tStep + 80300 * ii] *
                        (real_T)agingIndicator[ii + 1];
    }
    for (ii = 0; ii < 25; ii++) {
      idx = tStep + 80300 * ii;
      ndbl = stateA3[idx];
      stateA0_tmp[ii] = (tempAging[21 * ii + 18] + ndbl) +
                        ((((stateA0_tmp[ii] * stateE3[idx] - b_a_tmp * ndbl) -
                           b_iniInfectiousProp[ii] * ndbl) +
                          e_a_tmp[ii]) -
                         ndbl * dailyMortalityByAge[ii]) *
                            dt;
    }
    for (ii = 0; ii < 25; ii++) {
      stateA3[(tStep + 80300 * ii) + 1] = stateA0_tmp[ii];
    }
    e_a_tmp[0] = 0.0;
    for (ii = 0; ii < 24; ii++) {
      e_a_tmp[ii + 1] = b_iniInfectiousProp[ii] * stateI3[tStep + 80300 * ii] *
                        (real_T)agingIndicator[ii + 1];
    }
    for (ii = 0; ii < 25; ii++) {
      idx = tStep + 80300 * ii;
      ndbl = stateI3[idx];
      stateI0_tmp[ii] = (tempAging[21 * ii + 19] + ndbl) +
                        ((((stateI0_tmp[ii] * stateE3[idx] - b_a_tmp * ndbl) -
                           b_iniInfectiousProp[ii] * ndbl) +
                          e_a_tmp[ii]) -
                         ndbl * dailyMortalityByAge[ii]) *
                            dt;
    }
    for (ii = 0; ii < 25; ii++) {
      stateI3[(tStep + 80300 * ii) + 1] = stateI0_tmp[ii];
    }
    e_a_tmp[0] = 0.0;
    for (ii = 0; ii < 24; ii++) {
      e_a_tmp[ii + 1] = b_iniInfectiousProp[ii] * stateR3[tStep + 80300 * ii] *
                        (real_T)agingIndicator[ii + 1];
    }
    for (ii = 0; ii < 25; ii++) {
      idx = tStep + 80300 * ii;
      ndbl = stateR3[idx];
      b_iniRecoveredProp[ii] = (tempAging[21 * ii + 20] + ndbl) +
                               ((((b_a_tmp * (stateA3[idx] + stateI3[idx]) -
                                   b_iniRecoveredProp[ii]) -
                                  b_iniInfectiousProp[ii] * ndbl) +
                                 e_a_tmp[ii]) -
                                ndbl * dailyMortalityByAge[ii]) *
                                   dt;
    }
    for (ii = 0; ii < 25; ii++) {
      stateR3[(tStep + 80300 * ii) + 1] = b_iniRecoveredProp[ii];
    }
    /*  Calculate cumulative infections */
    /*  Update interventions (stateVmAb and stateVvax) */
    /*  These would require additional logic based on your specific intervention
     * strategies */
    for (ii = 0; ii < 25; ii++) {
      real_T d;
      idx = tStep + 80300 * ii;
      ndbl = stateE0[idx];
      sumInfections = stateE1[idx];
      pMaternalProtection = stateE2[idx];
      d = stateE3[idx];
      stateZ[idx + 1] = sigmaExposure *
                        (((ndbl + sumInfections) + pMaternalProtection) + d) *
                        dt;
      checkTotalPopulation[21 * ii] = stateM[idx];
      checkTotalPopulation[21 * ii + 1] = stateS0[idx];
      checkTotalPopulation[21 * ii + 2] = ndbl;
      checkTotalPopulation[21 * ii + 3] = stateA0[idx];
      checkTotalPopulation[21 * ii + 4] = stateI0[idx];
      checkTotalPopulation[21 * ii + 5] = stateR0[idx];
      checkTotalPopulation[21 * ii + 6] = stateS1[idx];
      checkTotalPopulation[21 * ii + 7] = sumInfections;
      checkTotalPopulation[21 * ii + 8] = stateA1[idx];
      checkTotalPopulation[21 * ii + 9] = stateI1[idx];
      checkTotalPopulation[21 * ii + 10] = stateR1[idx];
      checkTotalPopulation[21 * ii + 11] = stateS2[idx];
      checkTotalPopulation[21 * ii + 12] = pMaternalProtection;
      checkTotalPopulation[21 * ii + 13] = stateA2[idx];
      checkTotalPopulation[21 * ii + 14] = stateI2[idx];
      checkTotalPopulation[21 * ii + 15] = stateR2[idx];
      checkTotalPopulation[21 * ii + 16] = stateS3[idx];
      checkTotalPopulation[21 * ii + 17] = d;
      checkTotalPopulation[21 * ii + 18] = stateA3[idx];
      checkTotalPopulation[21 * ii + 19] = stateI3[idx];
      checkTotalPopulation[21 * ii + 20] = stateR3[idx];
    }
    if ((int32_T)((uint32_T)tStep + 2U) > 80300) {
      emlrtDynamicBoundsCheckR2012b((int32_T)((uint32_T)tStep + 2U), 1, 80300,
                                    &emlrtBCI, (emlrtConstCTX)sp);
    }
    for (ii = 0; ii < 25; ii++) {
      idx = (tStep + 80300 * ii) + 1;
      checkTotalPopulation[21 * ii + 525] = stateM[idx];
      checkTotalPopulation[21 * ii + 526] = stateS0[idx];
      checkTotalPopulation[21 * ii + 527] = stateE0[idx];
      checkTotalPopulation[21 * ii + 528] = stateA0[idx];
      checkTotalPopulation[21 * ii + 529] = stateI0[idx];
      checkTotalPopulation[21 * ii + 530] = stateR0[idx];
      checkTotalPopulation[21 * ii + 531] = stateS1[idx];
      checkTotalPopulation[21 * ii + 532] = stateE1[idx];
      checkTotalPopulation[21 * ii + 533] = stateA1[idx];
      checkTotalPopulation[21 * ii + 534] = stateI1[idx];
      checkTotalPopulation[21 * ii + 535] = stateR1[idx];
      checkTotalPopulation[21 * ii + 536] = stateS2[idx];
      checkTotalPopulation[21 * ii + 537] = stateE2[idx];
      checkTotalPopulation[21 * ii + 538] = stateA2[idx];
      checkTotalPopulation[21 * ii + 539] = stateI2[idx];
      checkTotalPopulation[21 * ii + 540] = stateR2[idx];
      checkTotalPopulation[21 * ii + 541] = stateS3[idx];
      checkTotalPopulation[21 * ii + 542] = stateE3[idx];
      checkTotalPopulation[21 * ii + 543] = stateA3[idx];
      checkTotalPopulation[21 * ii + 544] = stateI3[idx];
      checkTotalPopulation[21 * ii + 545] = stateR3[idx];
    }
    /*  disp(sum(sum(checkTotalPopulation(:,:,2)))-sum(sum(checkTotalPopulation(:,:,1))))
     */
    /*  disp(muBirthRate(1)) */
    /*  disp(checkTotalPopulation(1,end)*etaMortalityRate(end)) */
    /*  disp(checkTotalPopulation(1,:)*dailyMortalityByAge') */
    /*  disp(sum(sum(checkTotalPopulation(:,:,2)))-sum(sum(checkTotalPopulation(:,:,1)))-...
     */
    /*      dt*(muBirthRate(1)- ... */
    /*      sum(checkTotalPopulation(:,end,1),1)*etaMortalityRate(end)- ... */
    /*      sum(checkTotalPopulation(:,:,1),1)*dailyMortalityByAge')) */
    for (ii = 0; ii < 25; ii++) {
      stateA0_tmp[ii] = sumColumnB(&checkTotalPopulation[0], ii + 1);
      idx = ii * 21;
      for (jjAge = 0; jjAge < 21; jjAge++) {
        tempAging[idx + jjAge] = b_iv[ii];
      }
    }
    for (jjAge = 0; jjAge < 25; jjAge++) {
      for (ii = 0; ii <= 18; ii += 2) {
        __m128d r1;
        idx = ii + 21 * jjAge;
        r = _mm_loadu_pd(&checkTotalPopulation[idx]);
        r1 = _mm_loadu_pd(&tempAging[idx]);
        _mm_storeu_pd(&tempAging[idx], _mm_mul_pd(r, r1));
      }
      idx = 21 * jjAge + 20;
      tempAging[idx] *= checkTotalPopulation[idx];
    }
    ndbl = 0.0;
    for (ii = 0; ii < 25; ii++) {
      b_iniRecoveredProp[ii] = sumColumnB(tempAging, ii + 1);
      ndbl += stateA0_tmp[ii] * dailyMortalityByAge[ii];
    }
    ndbl = -(dt * ((muBirthRate[0] - d_sumColumnB(&checkTotalPopulation[504]) *
                                         b_iniInfectiousProp[24]) -
                   ndbl)) /
           e_sumColumnB(b_iniRecoveredProp);
    for (ii = 0; ii <= 522; ii += 2) {
      r = _mm_loadu_pd(&tempAging[ii]);
      _mm_storeu_pd(&tempAging[ii], _mm_mul_pd(_mm_set1_pd(ndbl), r));
    }
    tempAging[524] *= ndbl;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b((emlrtConstCTX)sp);
    }
  }
  st.site = &e_emlrtRSI;
  if (muDoubleScalarIsNaN(dt) || muDoubleScalarIsNaN(numDays)) {
    idx = out->timeVec->size[0] * out->timeVec->size[1];
    out->timeVec->size[0] = 1;
    out->timeVec->size[1] = 1;
    emxEnsureCapacity_real_T(&st, out->timeVec, idx, &h_emlrtRTEI);
    out->timeVec->data[0] = rtNaN;
  } else if ((dt == 0.0) || ((numDays > 0.0) && (dt < 0.0)) ||
             ((numDays < 0.0) && (dt > 0.0))) {
    out->timeVec->size[0] = 1;
    out->timeVec->size[1] = 0;
  } else if (muDoubleScalarIsInf(numDays) && muDoubleScalarIsInf(dt)) {
    idx = out->timeVec->size[0] * out->timeVec->size[1];
    out->timeVec->size[0] = 1;
    out->timeVec->size[1] = 1;
    emxEnsureCapacity_real_T(&st, out->timeVec, idx, &h_emlrtRTEI);
    out->timeVec->data[0] = rtNaN;
  } else if (muDoubleScalarIsInf(dt)) {
    idx = out->timeVec->size[0] * out->timeVec->size[1];
    out->timeVec->size[0] = 1;
    out->timeVec->size[1] = 1;
    emxEnsureCapacity_real_T(&st, out->timeVec, idx, &h_emlrtRTEI);
    out->timeVec->data[0] = 0.0;
  } else if (muDoubleScalarFloor(dt) == dt) {
    idx = out->timeVec->size[0] * out->timeVec->size[1];
    out->timeVec->size[0] = 1;
    loop_ub_tmp_tmp = (int32_T)(numDays / dt);
    out->timeVec->size[1] = loop_ub_tmp_tmp + 1;
    emxEnsureCapacity_real_T(&st, out->timeVec, idx, &h_emlrtRTEI);
    idx = ((loop_ub_tmp_tmp + 1) / 2) << 1;
    loop_ub = idx - 2;
    for (ii = 0; ii <= loop_ub; ii += 2) {
      b_stateM[0] = ii;
      b_stateM[1] = ii + 1;
      r = _mm_loadu_pd(&b_stateM[0]);
      _mm_storeu_pd(&out->timeVec->data[ii], _mm_mul_pd(_mm_set1_pd(dt), r));
    }
    for (ii = idx; ii <= loop_ub_tmp_tmp; ii++) {
      out->timeVec->data[ii] = dt * (real_T)ii;
    }
  } else {
    b_st.site = &k_emlrtRSI;
    ndbl = muDoubleScalarFloor(numDays / dt + 0.5);
    pMaternalProtection = ndbl * dt;
    if (dt > 0.0) {
      sumInfections = pMaternalProtection - numDays;
    } else {
      sumInfections = numDays - pMaternalProtection;
    }
    if (muDoubleScalarAbs(sumInfections) <
        4.4408920985006262E-16 * muDoubleScalarAbs(numDays)) {
      ndbl++;
      pMaternalProtection = numDays;
    } else if (sumInfections > 0.0) {
      pMaternalProtection = (ndbl - 1.0) * dt;
    } else {
      ndbl++;
    }
    if (ndbl >= 0.0) {
      loop_ub = (int32_T)ndbl;
    } else {
      loop_ub = 0;
    }
    c_st.site = &l_emlrtRSI;
    if (ndbl > 2.147483647E+9) {
      emlrtErrorWithMessageIdR2018a(&c_st, &emlrtRTEI, "Coder:MATLAB:pmaxsize",
                                    "Coder:MATLAB:pmaxsize", 0);
    }
    idx = out->timeVec->size[0] * out->timeVec->size[1];
    out->timeVec->size[0] = 1;
    out->timeVec->size[1] = loop_ub;
    emxEnsureCapacity_real_T(&b_st, out->timeVec, idx, &i_emlrtRTEI);
    if (loop_ub > 0) {
      out->timeVec->data[0] = 0.0;
      if (loop_ub > 1) {
        out->timeVec->data[loop_ub - 1] = pMaternalProtection;
        idx = (int32_T)((uint32_T)(loop_ub - 1) >> 1);
        for (ii = 0; ii <= idx - 2; ii++) {
          ndbl = ((real_T)ii + 1.0) * dt;
          out->timeVec->data[ii + 1] = ndbl;
          out->timeVec->data[(loop_ub - ii) - 2] = pMaternalProtection - ndbl;
        }
        if (idx << 1 == loop_ub - 1) {
          out->timeVec->data[idx] = pMaternalProtection / 2.0;
        } else {
          ndbl = (real_T)idx * dt;
          out->timeVec->data[idx] = ndbl;
          out->timeVec->data[idx + 1] = pMaternalProtection - ndbl;
        }
      }
    }
  }
  out->stateVmAb = probVmAb;
  memcpy(&out->stateM[0], &stateM[0], 2007500U * sizeof(real_T));
  memcpy(&out->stateS0[0], &stateS0[0], 2007500U * sizeof(real_T));
  memcpy(&out->stateS1[0], &stateS1[0], 2007500U * sizeof(real_T));
  memcpy(&out->stateS2[0], &stateS2[0], 2007500U * sizeof(real_T));
  memcpy(&out->stateS3[0], &stateS3[0], 2007500U * sizeof(real_T));
  memcpy(&out->stateE0[0], &stateE0[0], 2007500U * sizeof(real_T));
  memcpy(&out->stateE1[0], &stateE1[0], 2007500U * sizeof(real_T));
  memcpy(&out->stateE2[0], &stateE2[0], 2007500U * sizeof(real_T));
  memcpy(&out->stateE3[0], &stateE3[0], 2007500U * sizeof(real_T));
  memcpy(&out->stateI0[0], &stateI0[0], 2007500U * sizeof(real_T));
  memcpy(&out->stateI1[0], &stateI1[0], 2007500U * sizeof(real_T));
  memcpy(&out->stateI2[0], &stateI2[0], 2007500U * sizeof(real_T));
  memcpy(&out->stateI3[0], &stateI3[0], 2007500U * sizeof(real_T));
  memcpy(&out->stateA0[0], &stateA0[0], 2007500U * sizeof(real_T));
  memcpy(&out->stateA1[0], &stateA1[0], 2007500U * sizeof(real_T));
  memcpy(&out->stateA2[0], &stateA2[0], 2007500U * sizeof(real_T));
  memcpy(&out->stateA3[0], &stateA3[0], 2007500U * sizeof(real_T));
  memcpy(&out->stateR0[0], &stateR0[0], 2007500U * sizeof(real_T));
  memcpy(&out->stateR1[0], &stateR1[0], 2007500U * sizeof(real_T));
  memcpy(&out->stateR2[0], &stateR2[0], 2007500U * sizeof(real_T));
  memcpy(&out->stateR3[0], &stateR3[0], 2007500U * sizeof(real_T));
  memcpy(&out->stateZ[0], &stateZ[0], 2007500U * sizeof(real_T));
  memcpy(&out->stateVvax[0], &probVvax[0], 2007500U * sizeof(real_T));
}

/* End of code generation (age_SEIR_RSV.c) */
