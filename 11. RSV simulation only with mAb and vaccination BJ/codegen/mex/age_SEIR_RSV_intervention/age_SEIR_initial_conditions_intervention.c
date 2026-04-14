/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * age_SEIR_initial_conditions_intervention.c
 *
 * Code generation for function 'age_SEIR_initial_conditions_intervention'
 *
 */

/* Include files */
#include "age_SEIR_initial_conditions_intervention.h"
#include "age_SEIR_RSV_intervention_data.h"
#include "rt_nonfinite.h"
#include "mwmathutil.h"

/* Variable Definitions */
static emlrtECInfo emlrtECI = {
    -1,                                         /* nDims */
    152,                                        /* lineNo */
    25,                                         /* colNo */
    "age_SEIR_initial_conditions_intervention", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\47. RSV simulation only with mAb "
    "and vaccination BJ\\age_SEIR_initial_conditions_interve"
    "ntion.m" /* pName */
};

static emlrtECInfo b_emlrtECI = {
    -1,                                         /* nDims */
    145,                                        /* lineNo */
    21,                                         /* colNo */
    "age_SEIR_initial_conditions_intervention", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\47. RSV simulation only with mAb "
    "and vaccination BJ\\age_SEIR_initial_conditions_interve"
    "ntion.m" /* pName */
};

static emlrtECInfo c_emlrtECI = {
    -1,                                         /* nDims */
    138,                                        /* lineNo */
    17,                                         /* colNo */
    "age_SEIR_initial_conditions_intervention", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\47. RSV simulation only with mAb "
    "and vaccination BJ\\age_SEIR_initial_conditions_interve"
    "ntion.m" /* pName */
};

static emlrtECInfo d_emlrtECI = {
    -1,                                         /* nDims */
    131,                                        /* lineNo */
    13,                                         /* colNo */
    "age_SEIR_initial_conditions_intervention", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\47. RSV simulation only with mAb "
    "and vaccination BJ\\age_SEIR_initial_conditions_interve"
    "ntion.m" /* pName */
};

static emlrtECInfo e_emlrtECI = {
    -1,                                         /* nDims */
    150,                                        /* lineNo */
    25,                                         /* colNo */
    "age_SEIR_initial_conditions_intervention", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\47. RSV simulation only with mAb "
    "and vaccination BJ\\age_SEIR_initial_conditions_interve"
    "ntion.m" /* pName */
};

static emlrtECInfo f_emlrtECI = {
    -1,                                         /* nDims */
    143,                                        /* lineNo */
    21,                                         /* colNo */
    "age_SEIR_initial_conditions_intervention", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\47. RSV simulation only with mAb "
    "and vaccination BJ\\age_SEIR_initial_conditions_interve"
    "ntion.m" /* pName */
};

static emlrtECInfo g_emlrtECI = {
    -1,                                         /* nDims */
    136,                                        /* lineNo */
    17,                                         /* colNo */
    "age_SEIR_initial_conditions_intervention", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\47. RSV simulation only with mAb "
    "and vaccination BJ\\age_SEIR_initial_conditions_interve"
    "ntion.m" /* pName */
};

static emlrtECInfo h_emlrtECI = {
    -1,                                         /* nDims */
    129,                                        /* lineNo */
    13,                                         /* colNo */
    "age_SEIR_initial_conditions_intervention", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\47. RSV simulation only with mAb "
    "and vaccination BJ\\age_SEIR_initial_conditions_interve"
    "ntion.m" /* pName */
};

static emlrtECInfo i_emlrtECI = {
    -1,                                         /* nDims */
    151,                                        /* lineNo */
    25,                                         /* colNo */
    "age_SEIR_initial_conditions_intervention", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\47. RSV simulation only with mAb "
    "and vaccination BJ\\age_SEIR_initial_conditions_interve"
    "ntion.m" /* pName */
};

static emlrtECInfo j_emlrtECI = {
    -1,                                         /* nDims */
    144,                                        /* lineNo */
    21,                                         /* colNo */
    "age_SEIR_initial_conditions_intervention", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\47. RSV simulation only with mAb "
    "and vaccination BJ\\age_SEIR_initial_conditions_interve"
    "ntion.m" /* pName */
};

static emlrtECInfo k_emlrtECI = {
    -1,                                         /* nDims */
    137,                                        /* lineNo */
    17,                                         /* colNo */
    "age_SEIR_initial_conditions_intervention", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\47. RSV simulation only with mAb "
    "and vaccination BJ\\age_SEIR_initial_conditions_interve"
    "ntion.m" /* pName */
};

static emlrtECInfo l_emlrtECI = {
    -1,                                         /* nDims */
    130,                                        /* lineNo */
    13,                                         /* colNo */
    "age_SEIR_initial_conditions_intervention", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\47. RSV simulation only with mAb "
    "and vaccination BJ\\age_SEIR_initial_conditions_interve"
    "ntion.m" /* pName */
};

static emlrtECInfo m_emlrtECI = {
    -1,                                         /* nDims */
    149,                                        /* lineNo */
    25,                                         /* colNo */
    "age_SEIR_initial_conditions_intervention", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\47. RSV simulation only with mAb "
    "and vaccination BJ\\age_SEIR_initial_conditions_interve"
    "ntion.m" /* pName */
};

static emlrtECInfo n_emlrtECI = {
    -1,                                         /* nDims */
    142,                                        /* lineNo */
    21,                                         /* colNo */
    "age_SEIR_initial_conditions_intervention", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\47. RSV simulation only with mAb "
    "and vaccination BJ\\age_SEIR_initial_conditions_interve"
    "ntion.m" /* pName */
};

static emlrtECInfo o_emlrtECI = {
    -1,                                         /* nDims */
    135,                                        /* lineNo */
    17,                                         /* colNo */
    "age_SEIR_initial_conditions_intervention", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\47. RSV simulation only with mAb "
    "and vaccination BJ\\age_SEIR_initial_conditions_interve"
    "ntion.m" /* pName */
};

static emlrtECInfo p_emlrtECI = {
    -1,                                         /* nDims */
    128,                                        /* lineNo */
    13,                                         /* colNo */
    "age_SEIR_initial_conditions_intervention", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\47. RSV simulation only with mAb "
    "and vaccination BJ\\age_SEIR_initial_conditions_interve"
    "ntion.m" /* pName */
};

static emlrtECInfo q_emlrtECI = {
    -1,                                         /* nDims */
    148,                                        /* lineNo */
    25,                                         /* colNo */
    "age_SEIR_initial_conditions_intervention", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\47. RSV simulation only with mAb "
    "and vaccination BJ\\age_SEIR_initial_conditions_interve"
    "ntion.m" /* pName */
};

static emlrtECInfo r_emlrtECI = {
    -1,                                         /* nDims */
    141,                                        /* lineNo */
    21,                                         /* colNo */
    "age_SEIR_initial_conditions_intervention", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\47. RSV simulation only with mAb "
    "and vaccination BJ\\age_SEIR_initial_conditions_interve"
    "ntion.m" /* pName */
};

static emlrtECInfo s_emlrtECI = {
    -1,                                         /* nDims */
    134,                                        /* lineNo */
    17,                                         /* colNo */
    "age_SEIR_initial_conditions_intervention", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\47. RSV simulation only with mAb "
    "and vaccination BJ\\age_SEIR_initial_conditions_interve"
    "ntion.m" /* pName */
};

static emlrtECInfo t_emlrtECI = {
    -1,                                         /* nDims */
    127,                                        /* lineNo */
    13,                                         /* colNo */
    "age_SEIR_initial_conditions_intervention", /* fName */
    "G:\\My Drive\\MATLAB\\m. RSV modelling\\47. RSV simulation only with mAb "
    "and vaccination BJ\\age_SEIR_initial_conditions_interve"
    "ntion.m" /* pName */
};

/* Function Definitions */
void c_age_SEIR_initial_conditions_i(
    const emlrtStack *sp, real_T stateM[2007500], real_T stateS0[2007500],
    real_T stateS1[2007500], real_T stateS2[2007500], real_T stateS3[2007500],
    real_T stateE0[2007500], real_T stateE1[2007500], real_T stateE2[2007500],
    real_T stateE3[2007500], real_T stateI0[2007500], real_T stateI1[2007500],
    real_T stateI2[2007500], real_T stateI3[2007500], real_T stateA0[2007500],
    real_T stateA1[2007500], real_T stateA2[2007500], real_T stateA3[2007500],
    real_T stateR0[2007500], real_T stateR1[2007500], real_T stateR2[2007500],
    real_T stateR3[2007500], real_T stateVmab1[2007500],
    real_T stateVmab2[2007500], real_T stateVmvax1[2007500],
    real_T stateVmvax2[2007500], real_T stateVpvax1[2007500],
    real_T stateVpvax2[2007500], const real_T totalPopulation[25],
    const real_T ageGroupDefRangeAll[26], const real_T iniInfectiousL1[25],
    const real_T iniRecoveredL2[25], real_T xiMaternalImmunity,
    real_T sigmaExposure, real_T gammaZeroPrimaryInfection,
    real_T g1ReductionInfectiousDuration, real_T g2ReductionInfectiousDuration,
    real_T delta1RelSuscep, real_T delta2RelSuscep, real_T delta3RelSuscep,
    const real_T pAsym[4], const real_T mAbCoverage[25],
    const real_T mVaxCoverage[25], const real_T oVaxCoverage[25],
    real_T pAsym_arr[25])
{
  real_T pa0[25];
  real_T pa1[25];
  real_T pa2[25];
  real_T pa3[25];
  real_T pa_xi_a[25];
  real_T A_val_data_idx_0;
  real_T E_val_data_idx_0;
  real_T I_val_data_idx_0;
  real_T d;
  real_T d1;
  real_T exp_lower;
  real_T exp_upper;
  real_T length_a;
  int32_T A_val_size[2];
  int32_T E_val_size[2];
  int32_T I_val_size[2];
  int32_T S_val_size[2];
  int32_T b_iv[2];
  int32_T current_pa_size[2];
  int32_T iiAge;
  int32_T iiExposure;
  /*  Precompute pa_xi, pa0, pa1, pa2, pa3 for each age group */
  E_val_data_idx_0 = -365.0 * xiMaternalImmunity;
  for (iiAge = 0; iiAge < 25; iiAge++) {
    I_val_data_idx_0 = ageGroupDefRangeAll[iiAge + 1];
    A_val_data_idx_0 = ageGroupDefRangeAll[iiAge];
    length_a = I_val_data_idx_0 - A_val_data_idx_0;
    /*  Compute pa_xi (proportion with maternal protection) */
    pa_xi_a[iiAge] = (muDoubleScalarExp(E_val_data_idx_0 * A_val_data_idx_0) -
                      muDoubleScalarExp(E_val_data_idx_0 * I_val_data_idx_0)) /
                     (365.0 * xiMaternalImmunity * length_a);
    /*  Compute pa0, pa1, pa2, pa3 (proportions with previous infections) */
    exp_lower = muDoubleScalarExp(-A_val_data_idx_0);
    exp_upper = muDoubleScalarExp(-I_val_data_idx_0);
    /*  Poisson integration by parts, summarized */
    d = (exp_lower - exp_upper) / length_a;
    pa0[iiAge] = d;
    d1 = (exp_lower * (A_val_data_idx_0 + 1.0) -
          exp_upper * (I_val_data_idx_0 + 1.0)) /
         length_a;
    pa1[iiAge] = d1;
    I_val_data_idx_0 =
        (exp_lower *
             ((A_val_data_idx_0 * A_val_data_idx_0 + 2.0 * A_val_data_idx_0) +
              2.0) -
         exp_upper *
             ((I_val_data_idx_0 * I_val_data_idx_0 + 2.0 * I_val_data_idx_0) +
              2.0)) /
        (2.0 * length_a);
    pa2[iiAge] = I_val_data_idx_0;
    pa3[iiAge] = ((1.0 - d) - d1) - I_val_data_idx_0;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b((emlrtConstCTX)sp);
    }
  }
  /*  Assign initial conditions to state variables */
  S_val_size[0] = 1;
  S_val_size[1] = 1;
  E_val_size[0] = 1;
  E_val_size[1] = 1;
  I_val_size[1] = 1;
  A_val_size[0] = 1;
  A_val_size[1] = 1;
  I_val_size[0] = 1;
  current_pa_size[0] = 1;
  for (iiAge = 0; iiAge < 25; iiAge++) {
    real_T a;
    real_T b_iniRecoveredL2;
    real_T b_pAsym;
    real_T d2;
    int32_T pa_idx;
    /*  Determine pAsym index based on age group */
    I_val_data_idx_0 = ageGroupDefRangeAll[iiAge];
    if (I_val_data_idx_0 < 1.0) {
      pa_idx = 0;
    } else if ((I_val_data_idx_0 >= 1.0) && (I_val_data_idx_0 < 5.0)) {
      pa_idx = 1;
    } else if ((I_val_data_idx_0 >= 5.0) && (I_val_data_idx_0 < 15.0)) {
      pa_idx = 2;
    } else {
      pa_idx = 3;
    }
    /*  Get current parameters for age group a */
    /*  Initial conditions for each exposure level (i=0 to 3) */
    /*  Switch loop */
    d = totalPopulation[iiAge];
    d1 = pa_xi_a[iiAge];
    a = d * (1.0 - d1);
    b_pAsym = pAsym[pa_idx];
    d2 = 1.0 - pAsym[pa_idx];
    b_iniRecoveredL2 = iniRecoveredL2[iiAge];
    for (iiExposure = 0; iiExposure < 4; iiExposure++) {
      real_T current_pa_data_idx_0;
      real_T infected;
      real_T non_infected;
      switch (iiExposure) {
      case 0:
        current_pa_size[1] = 1;
        current_pa_data_idx_0 = pa0[iiAge];
        infected = iniInfectiousL1[iiAge];
        non_infected = 1.0 - infected;
        length_a = (1.0 - iniRecoveredL2[iiAge]) * (1.0 - infected);
        break;
      case 1:
        current_pa_size[1] = 1;
        current_pa_data_idx_0 = pa1[iiAge];
        infected = iniInfectiousL1[iiAge];
        non_infected = 1.0 - delta1RelSuscep * infected;
        length_a = (1.0 - iniRecoveredL2[iiAge]) * non_infected;
        infected *= delta1RelSuscep;
        break;
      case 2:
        current_pa_size[1] = 1;
        current_pa_data_idx_0 = pa2[iiAge];
        I_val_data_idx_0 = delta2RelSuscep * delta1RelSuscep;
        infected = iniInfectiousL1[iiAge];
        non_infected = 1.0 - I_val_data_idx_0 * infected;
        length_a = (1.0 - iniRecoveredL2[iiAge]) * non_infected;
        infected *= I_val_data_idx_0;
        break;
      default:
        current_pa_size[1] = 1;
        current_pa_data_idx_0 = pa3[iiAge];
        I_val_data_idx_0 = delta3RelSuscep * delta2RelSuscep * delta1RelSuscep;
        infected = iniInfectiousL1[iiAge];
        non_infected = 1.0 - I_val_data_idx_0 * infected;
        length_a = (1.0 - iniRecoveredL2[iiAge]) * non_infected;
        infected *= I_val_data_idx_0;
        break;
      }
      /*  Calculate gamma for current exposure level */
      if (iiExposure == 0) {
        exp_lower = gammaZeroPrimaryInfection;
      } else if (iiExposure == 1) {
        exp_lower = gammaZeroPrimaryInfection / g1ReductionInfectiousDuration;
      } else {
        exp_lower = gammaZeroPrimaryInfection / g1ReductionInfectiousDuration /
                    g2ReductionInfectiousDuration;
      }
      /*  Compute values */
      exp_upper = sigmaExposure + exp_lower;
      current_pa_data_idx_0 *= a;
      length_a *= current_pa_data_idx_0;
      E_val_data_idx_0 =
          current_pa_data_idx_0 * (sigmaExposure / exp_upper) * infected;
      I_val_data_idx_0 = current_pa_data_idx_0 * (exp_lower / exp_upper);
      A_val_data_idx_0 = I_val_data_idx_0 * b_pAsym * infected;
      I_val_data_idx_0 = I_val_data_idx_0 * d2 * infected;
      current_pa_data_idx_0 =
          current_pa_data_idx_0 * b_iniRecoveredL2 * non_infected;
      /*  Assign to state variables */
      if (iiExposure == 0) {
        b_iv[0] = 1;
        b_iv[1] = 1;
        emlrtSubAssignSizeCheckR2012b(&b_iv[0], 2, &S_val_size[0], 2,
                                      &t_emlrtECI, (emlrtCTX)sp);
        stateS0[80300 * iiAge] = length_a;
        b_iv[0] = 1;
        b_iv[1] = 1;
        emlrtSubAssignSizeCheckR2012b(&b_iv[0], 2, &E_val_size[0], 2,
                                      &p_emlrtECI, (emlrtCTX)sp);
        stateE0[80300 * iiAge] = E_val_data_idx_0;
        b_iv[0] = 1;
        b_iv[1] = 1;
        emlrtSubAssignSizeCheckR2012b(&b_iv[0], 2, &A_val_size[0], 2,
                                      &h_emlrtECI, (emlrtCTX)sp);
        stateA0[80300 * iiAge] = A_val_data_idx_0;
        b_iv[0] = 1;
        b_iv[1] = 1;
        emlrtSubAssignSizeCheckR2012b(&b_iv[0], 2, &I_val_size[0], 2,
                                      &l_emlrtECI, (emlrtCTX)sp);
        stateI0[80300 * iiAge] = I_val_data_idx_0;
        b_iv[0] = 1;
        b_iv[1] = 1;
        emlrtSubAssignSizeCheckR2012b(&b_iv[0], 2, &current_pa_size[0], 2,
                                      &d_emlrtECI, (emlrtCTX)sp);
        stateR0[80300 * iiAge] = current_pa_data_idx_0;
      } else if (iiExposure == 1) {
        b_iv[0] = 1;
        b_iv[1] = 1;
        emlrtSubAssignSizeCheckR2012b(&b_iv[0], 2, &S_val_size[0], 2,
                                      &s_emlrtECI, (emlrtCTX)sp);
        stateS1[80300 * iiAge] = length_a;
        b_iv[0] = 1;
        b_iv[1] = 1;
        emlrtSubAssignSizeCheckR2012b(&b_iv[0], 2, &E_val_size[0], 2,
                                      &o_emlrtECI, (emlrtCTX)sp);
        stateE1[80300 * iiAge] = E_val_data_idx_0;
        b_iv[0] = 1;
        b_iv[1] = 1;
        emlrtSubAssignSizeCheckR2012b(&b_iv[0], 2, &A_val_size[0], 2,
                                      &g_emlrtECI, (emlrtCTX)sp);
        stateA1[80300 * iiAge] = A_val_data_idx_0;
        b_iv[0] = 1;
        b_iv[1] = 1;
        emlrtSubAssignSizeCheckR2012b(&b_iv[0], 2, &I_val_size[0], 2,
                                      &k_emlrtECI, (emlrtCTX)sp);
        stateI1[80300 * iiAge] = I_val_data_idx_0;
        b_iv[0] = 1;
        b_iv[1] = 1;
        emlrtSubAssignSizeCheckR2012b(&b_iv[0], 2, &current_pa_size[0], 2,
                                      &c_emlrtECI, (emlrtCTX)sp);
        stateR1[80300 * iiAge] = current_pa_data_idx_0;
      } else if (iiExposure == 2) {
        b_iv[0] = 1;
        b_iv[1] = 1;
        emlrtSubAssignSizeCheckR2012b(&b_iv[0], 2, &S_val_size[0], 2,
                                      &r_emlrtECI, (emlrtCTX)sp);
        stateS2[80300 * iiAge] = length_a;
        b_iv[0] = 1;
        b_iv[1] = 1;
        emlrtSubAssignSizeCheckR2012b(&b_iv[0], 2, &E_val_size[0], 2,
                                      &n_emlrtECI, (emlrtCTX)sp);
        stateE2[80300 * iiAge] = E_val_data_idx_0;
        b_iv[0] = 1;
        b_iv[1] = 1;
        emlrtSubAssignSizeCheckR2012b(&b_iv[0], 2, &A_val_size[0], 2,
                                      &f_emlrtECI, (emlrtCTX)sp);
        stateA2[80300 * iiAge] = A_val_data_idx_0;
        b_iv[0] = 1;
        b_iv[1] = 1;
        emlrtSubAssignSizeCheckR2012b(&b_iv[0], 2, &I_val_size[0], 2,
                                      &j_emlrtECI, (emlrtCTX)sp);
        stateI2[80300 * iiAge] = I_val_data_idx_0;
        b_iv[0] = 1;
        b_iv[1] = 1;
        emlrtSubAssignSizeCheckR2012b(&b_iv[0], 2, &current_pa_size[0], 2,
                                      &b_emlrtECI, (emlrtCTX)sp);
        stateR2[80300 * iiAge] = current_pa_data_idx_0;
      } else {
        b_iv[0] = 1;
        b_iv[1] = 1;
        emlrtSubAssignSizeCheckR2012b(&b_iv[0], 2, &S_val_size[0], 2,
                                      &q_emlrtECI, (emlrtCTX)sp);
        stateS3[80300 * iiAge] = length_a;
        b_iv[0] = 1;
        b_iv[1] = 1;
        emlrtSubAssignSizeCheckR2012b(&b_iv[0], 2, &E_val_size[0], 2,
                                      &m_emlrtECI, (emlrtCTX)sp);
        stateE3[80300 * iiAge] = E_val_data_idx_0;
        b_iv[0] = 1;
        b_iv[1] = 1;
        emlrtSubAssignSizeCheckR2012b(&b_iv[0], 2, &A_val_size[0], 2,
                                      &e_emlrtECI, (emlrtCTX)sp);
        stateA3[80300 * iiAge] = A_val_data_idx_0;
        b_iv[0] = 1;
        b_iv[1] = 1;
        emlrtSubAssignSizeCheckR2012b(&b_iv[0], 2, &I_val_size[0], 2,
                                      &i_emlrtECI, (emlrtCTX)sp);
        stateI3[80300 * iiAge] = I_val_data_idx_0;
        b_iv[0] = 1;
        b_iv[1] = 1;
        emlrtSubAssignSizeCheckR2012b(&b_iv[0], 2, &current_pa_size[0], 2,
                                      &emlrtECI, (emlrtCTX)sp);
        stateR3[80300 * iiAge] = current_pa_data_idx_0;
      }
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b((emlrtConstCTX)sp);
      }
    }
    /*  Additional initial conditions */
    length_a = d * d1;
    I_val_data_idx_0 = mAbCoverage[iiAge];
    A_val_data_idx_0 = mVaxCoverage[iiAge];
    stateM[80300 * iiAge] =
        length_a * ((1.0 - I_val_data_idx_0) - A_val_data_idx_0);
    I_val_data_idx_0 = length_a * I_val_data_idx_0 / 2.0;
    stateVmab1[80300 * iiAge] = I_val_data_idx_0;
    stateVmab2[80300 * iiAge] = I_val_data_idx_0;
    I_val_data_idx_0 = length_a * A_val_data_idx_0 / 2.0;
    stateVmvax1[80300 * iiAge] = I_val_data_idx_0;
    stateVmvax2[80300 * iiAge] = I_val_data_idx_0;
    I_val_data_idx_0 = length_a * oVaxCoverage[iiAge] / 2.0;
    stateVpvax1[80300 * iiAge] = I_val_data_idx_0;
    stateVpvax2[80300 * iiAge] = I_val_data_idx_0;
    pAsym_arr[iiAge] = pAsym[pa_idx];
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b((emlrtConstCTX)sp);
    }
  }
}

/* End of code generation (age_SEIR_initial_conditions_intervention.c) */
