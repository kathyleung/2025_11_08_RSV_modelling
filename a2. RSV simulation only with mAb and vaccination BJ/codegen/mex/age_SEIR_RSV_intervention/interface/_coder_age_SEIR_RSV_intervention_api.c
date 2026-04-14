/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_age_SEIR_RSV_intervention_api.c
 *
 * Code generation for function '_coder_age_SEIR_RSV_intervention_api'
 *
 */

/* Include files */
#include "_coder_age_SEIR_RSV_intervention_api.h"
#include "age_SEIR_RSV_intervention.h"
#include "age_SEIR_RSV_intervention_data.h"
#include "age_SEIR_RSV_intervention_emxutil.h"
#include "age_SEIR_RSV_intervention_types.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRTEInfo j_emlrtRTEI = {
    1,                                      /* lineNo */
    1,                                      /* colNo */
    "_coder_age_SEIR_RSV_intervention_api", /* fName */
    ""                                      /* pName */
};

static const char_T *sv[4] = {"unset", "continuous", "step", "event"};

static const int32_T iv[4] = {0, 1, 2, 3};

/* Function Declarations */
static void ab_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                                const char_T *identifier, b_table *y);

static real_T (*ac_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                    const emlrtMsgIdentifier *msgId))[625];

static real_T (
    *b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                        const emlrtMsgIdentifier *parentId))[2007500];

static const mxArray *b_emlrt_marshallOut(const emxArray_real_T *u);

static void bb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId, b_table *y);

static creal_T bc_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                   const emlrtMsgIdentifier *msgId);

static real_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                                   const char_T *identifier))[25];

static const mxArray *c_emlrt_marshallOut(const real_T u[2007500]);

static f_matlab_internal_coder_tabular
cb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                    const emlrtMsgIdentifier *parentId);

static void cc_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                char_T ret[10]);

static real_T (*d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[25];

static void db_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId);

static real_T (*dc_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                    const emlrtMsgIdentifier *msgId))[4];

static real_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                                 const char_T *identifier);

static void eb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId,
                                c_matlab_internal_coder_tabular y[3]);

static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                                 const char_T *identifier))[2007500];

static const mxArray *emlrt_marshallOut(const struct1_T *u);

static real_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                 const emlrtMsgIdentifier *parentId);

static void fb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId,
                                cell_wrap_6 y[3]);

static real_T (*g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                                   const char_T *identifier))[26];

static void gb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId,
                                real_T y[25]);

static real_T (*h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[26];

static real_T (*hb_emlrt_marshallIn(const emlrtStack *sp,
                                    const mxArray *nullptr,
                                    const char_T *identifier))[625];

static real_T (*i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                                   const char_T *identifier))[2];

static real_T (*ib_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId))[625];

static real_T (*j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[2];

static datetime jb_emlrt_marshallIn(const emlrtStack *sp,
                                    const mxArray *nullptr,
                                    const char_T *identifier);

static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, table *y);

static datetime kb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId);

static void l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, table *y);

static creal_T lb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId);

static d_matlab_internal_coder_tabular
m_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                   const emlrtMsgIdentifier *parentId);

static void mb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId,
                                char_T y[10]);

static void n_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId);

static real_T (*nb_emlrt_marshallIn(const emlrtStack *sp,
                                    const mxArray *nullptr,
                                    const char_T *identifier))[4];

static void o_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId);

static real_T (*ob_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId))[4];

static e_matlab_internal_coder_tabular
p_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                   const emlrtMsgIdentifier *parentId);

static real_T (*pb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                    const emlrtMsgIdentifier *msgId))[2007500];

static void q_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId);

static real_T (*qb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                    const emlrtMsgIdentifier *msgId))[25];

static void r_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId);

static real_T rb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                  const emlrtMsgIdentifier *msgId);

static void s_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               c_matlab_internal_coder_tabular y[5]);

static real_T (*sb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                    const emlrtMsgIdentifier *msgId))[26];

static void t_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId);

static real_T (*tb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                    const emlrtMsgIdentifier *msgId))[2];

static boolean_T u_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId);

static void ub_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId);

static void v_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               cell_wrap_4 y[5]);

static boolean_T vb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                     const emlrtMsgIdentifier *msgId);

static void w_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[18]);

static void wb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret[18]);

static void x_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId);

static void xb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId);

static void y_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId);

static void yb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret[25]);

/* Function Definitions */
static void ab_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                                const char_T *identifier, b_table *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  bb_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId, y);
  emlrtDestroyArray(&nullptr);
}

static real_T (*ac_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                    const emlrtMsgIdentifier *msgId))[625]
{
  static const int32_T dims[2] = {25, 25};
  real_T(*ret)[625];
  int32_T b_iv[2];
  boolean_T bv[2] = {false, false};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                            (const void *)&dims[0], &bv[0], &b_iv[0]);
  ret = (real_T(*)[625])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[2007500]
{
  real_T(*y)[2007500];
  y = pb_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static const mxArray *b_emlrt_marshallOut(const emxArray_real_T *u)
{
  const mxArray *m;
  const mxArray *y;
  const real_T *u_data;
  real_T *pData;
  int32_T b_i;
  int32_T i;
  u_data = u->data;
  y = NULL;
  m = emlrtCreateNumericArray(1, &u->size[0], mxDOUBLE_CLASS, mxREAL);
  pData = emlrtMxGetPr(m);
  i = 0;
  for (b_i = 0; b_i < u->size[0]; b_i++) {
    pData[i] = u_data[b_i];
    i++;
  }
  emlrtAssign(&y, m);
  return y;
}

static void bb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId, b_table *y)
{
  emlrtMsgIdentifier thisId;
  const mxArray *propValues[5];
  int32_T i;
  const char_T *propClasses[5] = {
      "matlab.internal.coder.table", "matlab.internal.coder.table",
      "matlab.internal.coder.table", "matlab.internal.coder.table",
      "matlab.internal.coder.table"};
  const char_T *propNames[5] = {"metaDim", "rowDim", "varDim", "data",
                                "arrayProps"};
  for (i = 0; i < 5; i++) {
    propValues[i] = NULL;
  }
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckMcosClass2017a((emlrtCTX)sp, parentId, u, "table");
  emlrtAssign(&u, emlrtConvertInstanceToRedirectTarget(
                      (emlrtCTX)sp, u, 0, "matlab.internal.coder.table"));
  emlrtCheckMcosClass2017a((emlrtCTX)sp, parentId, u,
                           "matlab.internal.coder.table");
  emlrtGetAllProperties((emlrtCTX)sp, u, 0, 5, (const char_T **)&propNames[0],
                        (const char_T **)&propClasses[0], &propValues[0]);
  thisId.fIdentifier = "metaDim";
  y->metaDim = m_emlrt_marshallIn(sp, emlrtAlias(propValues[0]), &thisId);
  thisId.fIdentifier = "rowDim";
  n_emlrt_marshallIn(sp, emlrtAlias(propValues[1]), &thisId);
  thisId.fIdentifier = "varDim";
  y->varDim = cb_emlrt_marshallIn(sp, emlrtAlias(propValues[2]), &thisId);
  thisId.fIdentifier = "data";
  fb_emlrt_marshallIn(sp, emlrtAlias(propValues[3]), &thisId, y->data);
  thisId.fIdentifier = "arrayProps";
  x_emlrt_marshallIn(sp, emlrtAlias(propValues[4]), &thisId);
  emlrtDestroyArrays(5, &propValues[0]);
  emlrtDestroyArray(&u);
}

static creal_T bc_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                   const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims = 0;
  creal_T ret;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", true, 0U,
                          (const void *)&dims);
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret, 8, true);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                                   const char_T *identifier))[25]
{
  emlrtMsgIdentifier thisId;
  real_T(*y)[25];
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = d_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId);
  emlrtDestroyArray(&nullptr);
  return y;
}

static const mxArray *c_emlrt_marshallOut(const real_T u[2007500])
{
  static const int32_T b_iv[2] = {80300, 25};
  const mxArray *m;
  const mxArray *y;
  real_T *pData;
  int32_T b_i;
  int32_T c_i;
  int32_T i;
  y = NULL;
  m = emlrtCreateNumericArray(2, (const void *)&b_iv[0], mxDOUBLE_CLASS,
                              mxREAL);
  pData = emlrtMxGetPr(m);
  i = 0;
  for (b_i = 0; b_i < 25; b_i++) {
    for (c_i = 0; c_i < 80300; c_i++) {
      pData[i + c_i] = u[c_i + 80300 * b_i];
    }
    i += 80300;
  }
  emlrtAssign(&y, m);
  return y;
}

static f_matlab_internal_coder_tabular
cb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                    const emlrtMsgIdentifier *parentId)
{
  emlrtMsgIdentifier thisId;
  f_matlab_internal_coder_tabular y;
  const mxArray *propValues[9];
  int32_T i;
  const char_T *propClasses[9] = {
      "matlab.internal.coder.tabular.private.varNamesDim",
      "matlab.internal.coder.tabular.private.varNamesDim",
      "matlab.internal.coder.tabular.private.varNamesDim",
      "matlab.internal.coder.tabular.private.varNamesDim",
      "matlab.internal.coder.tabular.private.varNamesDim",
      "matlab.internal.coder.tabular.private.varNamesDim",
      "matlab.internal.coder.tabular.private.varNamesDim",
      "matlab.internal.coder.tabular.private.varNamesDim",
      "matlab.internal.coder.tabular.private.varNamesDim"};
  const char_T *propNames[9] = {
      "length",    "descrs",   "units",         "continuity",    "customProps",
      "hasDescrs", "hasUnits", "hasContinuity", "hasCustomProps"};
  for (i = 0; i < 9; i++) {
    propValues[i] = NULL;
  }
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckMcosClass2017a((emlrtCTX)sp, parentId, u,
                           "matlab.internal.coder.tabular.private.varNamesDim");
  emlrtGetAllProperties((emlrtCTX)sp, u, 0, 9, (const char_T **)&propNames[0],
                        (const char_T **)&propClasses[0], &propValues[0]);
  thisId.fIdentifier = "length";
  y.length = f_emlrt_marshallIn(sp, emlrtAlias(propValues[0]), &thisId);
  thisId.fIdentifier = "descrs";
  db_emlrt_marshallIn(sp, emlrtAlias(propValues[1]), &thisId);
  thisId.fIdentifier = "units";
  db_emlrt_marshallIn(sp, emlrtAlias(propValues[2]), &thisId);
  thisId.fIdentifier = "continuity";
  eb_emlrt_marshallIn(sp, emlrtAlias(propValues[3]), &thisId, y.continuity);
  thisId.fIdentifier = "customProps";
  t_emlrt_marshallIn(sp, emlrtAlias(propValues[4]), &thisId);
  thisId.fIdentifier = "hasDescrs";
  y.hasDescrs = u_emlrt_marshallIn(sp, emlrtAlias(propValues[5]), &thisId);
  thisId.fIdentifier = "hasUnits";
  y.hasUnits = u_emlrt_marshallIn(sp, emlrtAlias(propValues[6]), &thisId);
  thisId.fIdentifier = "hasContinuity";
  y.hasContinuity = u_emlrt_marshallIn(sp, emlrtAlias(propValues[7]), &thisId);
  thisId.fIdentifier = "hasCustomProps";
  y.hasCustomProps = u_emlrt_marshallIn(sp, emlrtAlias(propValues[8]), &thisId);
  emlrtDestroyArrays(9, &propValues[0]);
  emlrtDestroyArray(&u);
  return y;
}

static void cc_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId, char_T ret[10])
{
  static const int32_T dims[2] = {1, 10};
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "char", false, 2U,
                          (const void *)&dims[0]);
  emlrtImportCharArrayR2015b((emlrtConstCTX)sp, src, &ret[0], 10);
  emlrtDestroyArray(&src);
}

static real_T (*d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[25]
{
  real_T(*y)[25];
  y = qb_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static void db_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId)
{
  emlrtMsgIdentifier thisId;
  int32_T b_iv[2];
  char_T str[11];
  boolean_T bv[2];
  thisId.fParent = parentId;
  thisId.bParentIsCell = true;
  bv[0] = false;
  b_iv[0] = 1;
  bv[1] = false;
  b_iv[1] = 3;
  emlrtCheckCell((emlrtCTX)sp, parentId, u, 2U, &b_iv[0], &bv[0]);
  emlrtMexSnprintf(&str[0], (size_t)11U, "%d", 1);
  thisId.fIdentifier = &str[0];
  r_emlrt_marshallIn(sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 0)),
                     &thisId);
  emlrtMexSnprintf(&str[0], (size_t)11U, "%d", 2);
  thisId.fIdentifier = &str[0];
  r_emlrt_marshallIn(sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 1)),
                     &thisId);
  emlrtMexSnprintf(&str[0], (size_t)11U, "%d", 3);
  thisId.fIdentifier = &str[0];
  r_emlrt_marshallIn(sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 2)),
                     &thisId);
  emlrtDestroyArray(&u);
}

static real_T (*dc_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                    const emlrtMsgIdentifier *msgId))[4]
{
  static const int32_T dims[2] = {1, 4};
  real_T(*ret)[4];
  int32_T b_iv[2];
  boolean_T bv[2] = {false, false};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                            (const void *)&dims[0], &bv[0], &b_iv[0]);
  ret = (real_T(*)[4])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                                 const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  real_T y;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = f_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId);
  emlrtDestroyArray(&nullptr);
  return y;
}

static void eb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId,
                                c_matlab_internal_coder_tabular y[3])
{
  static const int32_T dims[2] = {1, 3};
  emlrtCheckEnumR2012b((emlrtConstCTX)sp,
                       "matlab.internal.coder.tabular.Continuity", 4,
                       (const char_T **)&sv[0], &iv[0]);
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, parentId, u,
                          "matlab.internal.coder.tabular.Continuity", false, 2U,
                          (const void *)&dims[0]);
  y[0] = (c_matlab_internal_coder_tabular)emlrtGetEnumElementR2009a(u, 0);
  y[1] = (c_matlab_internal_coder_tabular)emlrtGetEnumElementR2009a(u, 1);
  y[2] = (c_matlab_internal_coder_tabular)emlrtGetEnumElementR2009a(u, 2);
  emlrtDestroyArray(&u);
}

static real_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                                 const char_T *identifier))[2007500]
{
  emlrtMsgIdentifier thisId;
  real_T(*y)[2007500];
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId);
  emlrtDestroyArray(&nullptr);
  return y;
}

static const mxArray *emlrt_marshallOut(const struct1_T *u)
{
  static const char_T *b_sv[31] = {
      "timeVec",     "Rt",          "pMaternalProtection",
      "stateM",      "stateS0",     "stateS1",
      "stateS2",     "stateS3",     "stateE0",
      "stateE1",     "stateE2",     "stateE3",
      "stateI0",     "stateI1",     "stateI2",
      "stateI3",     "stateA0",     "stateA1",
      "stateA2",     "stateA3",     "stateR0",
      "stateR1",     "stateR2",     "stateR3",
      "stateZ",      "stateVmab1",  "stateVmab2",
      "stateVmvax1", "stateVmvax2", "stateVpvax1",
      "stateVpvax2"};
  const mxArray *b_y;
  const mxArray *m;
  const mxArray *y;
  real_T *pData;
  int32_T b_iv[2];
  int32_T b_i;
  int32_T i;
  y = NULL;
  emlrtAssign(&y, emlrtCreateStructMatrix(1, 1, 31, (const char_T **)&b_sv[0]));
  b_y = NULL;
  b_iv[0] = 1;
  b_iv[1] = u->timeVec->size[1];
  m = emlrtCreateNumericArray(2, &b_iv[0], mxDOUBLE_CLASS, mxREAL);
  pData = emlrtMxGetPr(m);
  i = 0;
  for (b_i = 0; b_i < u->timeVec->size[1]; b_i++) {
    pData[i] = u->timeVec->data[b_i];
    i++;
  }
  emlrtAssign(&b_y, m);
  emlrtSetFieldR2017b(y, 0, "timeVec", b_y, 0);
  emlrtSetFieldR2017b(y, 0, "Rt", b_emlrt_marshallOut(u->Rt), 1);
  emlrtSetFieldR2017b(y, 0, "pMaternalProtection",
                      b_emlrt_marshallOut(u->pMaternalProtection), 2);
  emlrtSetFieldR2017b(y, 0, "stateM", c_emlrt_marshallOut(u->stateM), 3);
  emlrtSetFieldR2017b(y, 0, "stateS0", c_emlrt_marshallOut(u->stateS0), 4);
  emlrtSetFieldR2017b(y, 0, "stateS1", c_emlrt_marshallOut(u->stateS1), 5);
  emlrtSetFieldR2017b(y, 0, "stateS2", c_emlrt_marshallOut(u->stateS2), 6);
  emlrtSetFieldR2017b(y, 0, "stateS3", c_emlrt_marshallOut(u->stateS3), 7);
  emlrtSetFieldR2017b(y, 0, "stateE0", c_emlrt_marshallOut(u->stateE0), 8);
  emlrtSetFieldR2017b(y, 0, "stateE1", c_emlrt_marshallOut(u->stateE1), 9);
  emlrtSetFieldR2017b(y, 0, "stateE2", c_emlrt_marshallOut(u->stateE2), 10);
  emlrtSetFieldR2017b(y, 0, "stateE3", c_emlrt_marshallOut(u->stateE3), 11);
  emlrtSetFieldR2017b(y, 0, "stateI0", c_emlrt_marshallOut(u->stateI0), 12);
  emlrtSetFieldR2017b(y, 0, "stateI1", c_emlrt_marshallOut(u->stateI1), 13);
  emlrtSetFieldR2017b(y, 0, "stateI2", c_emlrt_marshallOut(u->stateI2), 14);
  emlrtSetFieldR2017b(y, 0, "stateI3", c_emlrt_marshallOut(u->stateI3), 15);
  emlrtSetFieldR2017b(y, 0, "stateA0", c_emlrt_marshallOut(u->stateA0), 16);
  emlrtSetFieldR2017b(y, 0, "stateA1", c_emlrt_marshallOut(u->stateA1), 17);
  emlrtSetFieldR2017b(y, 0, "stateA2", c_emlrt_marshallOut(u->stateA2), 18);
  emlrtSetFieldR2017b(y, 0, "stateA3", c_emlrt_marshallOut(u->stateA3), 19);
  emlrtSetFieldR2017b(y, 0, "stateR0", c_emlrt_marshallOut(u->stateR0), 20);
  emlrtSetFieldR2017b(y, 0, "stateR1", c_emlrt_marshallOut(u->stateR1), 21);
  emlrtSetFieldR2017b(y, 0, "stateR2", c_emlrt_marshallOut(u->stateR2), 22);
  emlrtSetFieldR2017b(y, 0, "stateR3", c_emlrt_marshallOut(u->stateR3), 23);
  emlrtSetFieldR2017b(y, 0, "stateZ", c_emlrt_marshallOut(u->stateZ), 24);
  emlrtSetFieldR2017b(y, 0, "stateVmab1", c_emlrt_marshallOut(u->stateVmab1),
                      25);
  emlrtSetFieldR2017b(y, 0, "stateVmab2", c_emlrt_marshallOut(u->stateVmab2),
                      26);
  emlrtSetFieldR2017b(y, 0, "stateVmvax1", c_emlrt_marshallOut(u->stateVmvax1),
                      27);
  emlrtSetFieldR2017b(y, 0, "stateVmvax2", c_emlrt_marshallOut(u->stateVmvax2),
                      28);
  emlrtSetFieldR2017b(y, 0, "stateVpvax1", c_emlrt_marshallOut(u->stateVpvax1),
                      29);
  emlrtSetFieldR2017b(y, 0, "stateVpvax2", c_emlrt_marshallOut(u->stateVpvax2),
                      30);
  return y;
}

static real_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                 const emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = rb_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static void fb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId,
                                cell_wrap_6 y[3])
{
  emlrtMsgIdentifier thisId;
  int32_T b_iv[2];
  char_T str[11];
  boolean_T bv[2];
  thisId.fParent = parentId;
  thisId.bParentIsCell = true;
  bv[0] = false;
  b_iv[0] = 1;
  bv[1] = false;
  b_iv[1] = 3;
  emlrtCheckCell((emlrtCTX)sp, parentId, u, 2U, &b_iv[0], &bv[0]);
  emlrtMexSnprintf(&str[0], (size_t)11U, "%d", 1);
  thisId.fIdentifier = &str[0];
  gb_emlrt_marshallIn(sp,
                      emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 0)),
                      &thisId, y[0].f1);
  emlrtMexSnprintf(&str[0], (size_t)11U, "%d", 2);
  thisId.fIdentifier = &str[0];
  gb_emlrt_marshallIn(sp,
                      emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 1)),
                      &thisId, y[1].f1);
  emlrtMexSnprintf(&str[0], (size_t)11U, "%d", 3);
  thisId.fIdentifier = &str[0];
  gb_emlrt_marshallIn(sp,
                      emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 2)),
                      &thisId, y[2].f1);
  emlrtDestroyArray(&u);
}

static real_T (*g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                                   const char_T *identifier))[26]
{
  emlrtMsgIdentifier thisId;
  real_T(*y)[26];
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = h_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId);
  emlrtDestroyArray(&nullptr);
  return y;
}

static void gb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId,
                                real_T y[25])
{
  yb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real_T (*h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[26]
{
  real_T(*y)[26];
  y = sb_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T (*hb_emlrt_marshallIn(const emlrtStack *sp,
                                    const mxArray *nullptr,
                                    const char_T *identifier))[625]
{
  emlrtMsgIdentifier thisId;
  real_T(*y)[625];
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = ib_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId);
  emlrtDestroyArray(&nullptr);
  return y;
}

static real_T (*i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                                   const char_T *identifier))[2]
{
  emlrtMsgIdentifier thisId;
  real_T(*y)[2];
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = j_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId);
  emlrtDestroyArray(&nullptr);
  return y;
}

static real_T (*ib_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId))[625]
{
  real_T(*y)[625];
  y = ac_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T (*j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[2]
{
  real_T(*y)[2];
  y = tb_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static datetime jb_emlrt_marshallIn(const emlrtStack *sp,
                                    const mxArray *nullptr,
                                    const char_T *identifier)
{
  datetime y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = kb_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId);
  emlrtDestroyArray(&nullptr);
  return y;
}

static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, table *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  l_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId, y);
  emlrtDestroyArray(&nullptr);
}

static datetime kb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId)
{
  datetime y;
  emlrtMsgIdentifier thisId;
  const mxArray *propValues[3];
  const char_T *propClasses[3] = {"matlab.internal.coder.datetime",
                                  "matlab.internal.coder.datetime",
                                  "matlab.internal.coder.datetime"};
  const char_T *propNames[3] = {"data", "fmt", "tz"};
  propValues[0] = NULL;
  propValues[1] = NULL;
  propValues[2] = NULL;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckMcosClass2017a((emlrtCTX)sp, parentId, u, "datetime");
  emlrtAssign(&u, emlrtConvertInstanceToRedirectTarget(
                      (emlrtCTX)sp, u, 0, "matlab.internal.coder.datetime"));
  emlrtCheckMcosClass2017a((emlrtCTX)sp, parentId, u,
                           "matlab.internal.coder.datetime");
  emlrtGetAllProperties((emlrtCTX)sp, u, 0, 3, (const char_T **)&propNames[0],
                        (const char_T **)&propClasses[0], &propValues[0]);
  thisId.fIdentifier = "data";
  y.data = lb_emlrt_marshallIn(sp, emlrtAlias(propValues[0]), &thisId);
  thisId.fIdentifier = "fmt";
  mb_emlrt_marshallIn(sp, emlrtAlias(propValues[1]), &thisId, y.fmt);
  thisId.fIdentifier = "tz";
  r_emlrt_marshallIn(sp, emlrtAlias(propValues[2]), &thisId);
  emlrtDestroyArrays(3, &propValues[0]);
  emlrtDestroyArray(&u);
  return y;
}

static void l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, table *y)
{
  emlrtMsgIdentifier thisId;
  const mxArray *propValues[5];
  int32_T i;
  const char_T *propClasses[5] = {
      "matlab.internal.coder.table", "matlab.internal.coder.table",
      "matlab.internal.coder.table", "matlab.internal.coder.table",
      "matlab.internal.coder.table"};
  const char_T *propNames[5] = {"metaDim", "rowDim", "varDim", "data",
                                "arrayProps"};
  for (i = 0; i < 5; i++) {
    propValues[i] = NULL;
  }
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckMcosClass2017a((emlrtCTX)sp, parentId, u, "table");
  emlrtAssign(&u, emlrtConvertInstanceToRedirectTarget(
                      (emlrtCTX)sp, u, 0, "matlab.internal.coder.table"));
  emlrtCheckMcosClass2017a((emlrtCTX)sp, parentId, u,
                           "matlab.internal.coder.table");
  emlrtGetAllProperties((emlrtCTX)sp, u, 0, 5, (const char_T **)&propNames[0],
                        (const char_T **)&propClasses[0], &propValues[0]);
  thisId.fIdentifier = "metaDim";
  y->metaDim = m_emlrt_marshallIn(sp, emlrtAlias(propValues[0]), &thisId);
  thisId.fIdentifier = "rowDim";
  n_emlrt_marshallIn(sp, emlrtAlias(propValues[1]), &thisId);
  thisId.fIdentifier = "varDim";
  y->varDim = p_emlrt_marshallIn(sp, emlrtAlias(propValues[2]), &thisId);
  thisId.fIdentifier = "data";
  v_emlrt_marshallIn(sp, emlrtAlias(propValues[3]), &thisId, y->data);
  thisId.fIdentifier = "arrayProps";
  x_emlrt_marshallIn(sp, emlrtAlias(propValues[4]), &thisId);
  emlrtDestroyArrays(5, &propValues[0]);
  emlrtDestroyArray(&u);
}

static creal_T lb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId)
{
  creal_T y;
  y = bc_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static d_matlab_internal_coder_tabular
m_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                   const emlrtMsgIdentifier *parentId)
{
  d_matlab_internal_coder_tabular y;
  emlrtMsgIdentifier thisId;
  const mxArray *propValues;
  const char_T *propClasses = "matlab.internal.coder.tabular.private.metaDim";
  const char_T *propNames = "length";
  propValues = NULL;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckMcosClass2017a((emlrtCTX)sp, parentId, u,
                           "matlab.internal.coder.tabular.private.metaDim");
  emlrtGetAllProperties((emlrtCTX)sp, u, 0, 1, (const char_T **)&propNames,
                        (const char_T **)&propClasses, &propValues);
  thisId.fIdentifier = "length";
  y.length = f_emlrt_marshallIn(sp, emlrtAlias(propValues), &thisId);
  emlrtDestroyArrays(1, &propValues);
  emlrtDestroyArray(&u);
  return y;
}

static void mb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId,
                                char_T y[10])
{
  cc_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void n_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId)
{
  emlrtMsgIdentifier thisId;
  const mxArray *propValues;
  const char_T *propClasses =
      "matlab.internal.coder.tabular.private.rowNamesDim";
  const char_T *propNames = "labels";
  propValues = NULL;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckMcosClass2017a((emlrtCTX)sp, parentId, u,
                           "matlab.internal.coder.tabular.private.rowNamesDim");
  emlrtGetAllProperties((emlrtCTX)sp, u, 0, 1, (const char_T **)&propNames,
                        (const char_T **)&propClasses, &propValues);
  thisId.fIdentifier = "labels";
  o_emlrt_marshallIn(sp, emlrtAlias(propValues), &thisId);
  emlrtDestroyArrays(1, &propValues);
  emlrtDestroyArray(&u);
}

static real_T (*nb_emlrt_marshallIn(const emlrtStack *sp,
                                    const mxArray *nullptr,
                                    const char_T *identifier))[4]
{
  emlrtMsgIdentifier thisId;
  real_T(*y)[4];
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = ob_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId);
  emlrtDestroyArray(&nullptr);
  return y;
}

static void o_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId)
{
  int32_T b_iv[2];
  boolean_T bv[2];
  bv[0] = false;
  b_iv[0] = 0;
  bv[1] = false;
  b_iv[1] = 0;
  emlrtCheckCell((emlrtCTX)sp, parentId, u, 2U, &b_iv[0], &bv[0]);
  emlrtDestroyArray(&u);
}

static real_T (*ob_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId))[4]
{
  real_T(*y)[4];
  y = dc_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static e_matlab_internal_coder_tabular
p_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                   const emlrtMsgIdentifier *parentId)
{
  e_matlab_internal_coder_tabular y;
  emlrtMsgIdentifier thisId;
  const mxArray *propValues[9];
  int32_T i;
  const char_T *propClasses[9] = {
      "matlab.internal.coder.tabular.private.varNamesDim",
      "matlab.internal.coder.tabular.private.varNamesDim",
      "matlab.internal.coder.tabular.private.varNamesDim",
      "matlab.internal.coder.tabular.private.varNamesDim",
      "matlab.internal.coder.tabular.private.varNamesDim",
      "matlab.internal.coder.tabular.private.varNamesDim",
      "matlab.internal.coder.tabular.private.varNamesDim",
      "matlab.internal.coder.tabular.private.varNamesDim",
      "matlab.internal.coder.tabular.private.varNamesDim"};
  const char_T *propNames[9] = {
      "length",    "descrs",   "units",         "continuity",    "customProps",
      "hasDescrs", "hasUnits", "hasContinuity", "hasCustomProps"};
  for (i = 0; i < 9; i++) {
    propValues[i] = NULL;
  }
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckMcosClass2017a((emlrtCTX)sp, parentId, u,
                           "matlab.internal.coder.tabular.private.varNamesDim");
  emlrtGetAllProperties((emlrtCTX)sp, u, 0, 9, (const char_T **)&propNames[0],
                        (const char_T **)&propClasses[0], &propValues[0]);
  thisId.fIdentifier = "length";
  y.length = f_emlrt_marshallIn(sp, emlrtAlias(propValues[0]), &thisId);
  thisId.fIdentifier = "descrs";
  q_emlrt_marshallIn(sp, emlrtAlias(propValues[1]), &thisId);
  thisId.fIdentifier = "units";
  q_emlrt_marshallIn(sp, emlrtAlias(propValues[2]), &thisId);
  thisId.fIdentifier = "continuity";
  s_emlrt_marshallIn(sp, emlrtAlias(propValues[3]), &thisId, y.continuity);
  thisId.fIdentifier = "customProps";
  t_emlrt_marshallIn(sp, emlrtAlias(propValues[4]), &thisId);
  thisId.fIdentifier = "hasDescrs";
  y.hasDescrs = u_emlrt_marshallIn(sp, emlrtAlias(propValues[5]), &thisId);
  thisId.fIdentifier = "hasUnits";
  y.hasUnits = u_emlrt_marshallIn(sp, emlrtAlias(propValues[6]), &thisId);
  thisId.fIdentifier = "hasContinuity";
  y.hasContinuity = u_emlrt_marshallIn(sp, emlrtAlias(propValues[7]), &thisId);
  thisId.fIdentifier = "hasCustomProps";
  y.hasCustomProps = u_emlrt_marshallIn(sp, emlrtAlias(propValues[8]), &thisId);
  emlrtDestroyArrays(9, &propValues[0]);
  emlrtDestroyArray(&u);
  return y;
}

static real_T (*pb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                    const emlrtMsgIdentifier *msgId))[2007500]
{
  static const int32_T dims[2] = {80300, 25};
  real_T(*ret)[2007500];
  int32_T b_iv[2];
  boolean_T bv[2] = {false, false};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                            (const void *)&dims[0], &bv[0], &b_iv[0]);
  ret = (real_T(*)[2007500])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void q_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId)
{
  emlrtMsgIdentifier thisId;
  int32_T b_iv[2];
  int32_T i;
  char_T str[11];
  boolean_T bv[2];
  thisId.fParent = parentId;
  thisId.bParentIsCell = true;
  bv[0] = false;
  b_iv[0] = 1;
  bv[1] = false;
  b_iv[1] = 5;
  emlrtCheckCell((emlrtCTX)sp, parentId, u, 2U, &b_iv[0], &bv[0]);
  for (i = 0; i < 5; i++) {
    emlrtMexSnprintf(&str[0], (size_t)11U, "%d", i + 1);
    thisId.fIdentifier = &str[0];
    r_emlrt_marshallIn(
        sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, i)), &thisId);
  }
  emlrtDestroyArray(&u);
}

static real_T (*qb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                    const emlrtMsgIdentifier *msgId))[25]
{
  static const int32_T dims[2] = {1, 25};
  real_T(*ret)[25];
  int32_T b_iv[2];
  boolean_T bv[2] = {false, false};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                            (const void *)&dims[0], &bv[0], &b_iv[0]);
  ret = (real_T(*)[25])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void r_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId)
{
  ub_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
}

static real_T rb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                  const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims = 0;
  real_T ret;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 0U,
                          (const void *)&dims);
  ret = *(real_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void s_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               c_matlab_internal_coder_tabular y[5])
{
  static const int32_T dims[2] = {1, 5};
  int32_T i;
  emlrtCheckEnumR2012b((emlrtConstCTX)sp,
                       "matlab.internal.coder.tabular.Continuity", 4,
                       (const char_T **)&sv[0], &iv[0]);
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, parentId, u,
                          "matlab.internal.coder.tabular.Continuity", false, 2U,
                          (const void *)&dims[0]);
  for (i = 0; i < 5; i++) {
    y[i] = (c_matlab_internal_coder_tabular)emlrtGetEnumElementR2009a(u, i);
  }
  emlrtDestroyArray(&u);
}

static real_T (*sb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                    const emlrtMsgIdentifier *msgId))[26]
{
  static const int32_T dims[2] = {1, 26};
  real_T(*ret)[26];
  int32_T b_iv[2];
  boolean_T bv[2] = {false, false};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                            (const void *)&dims[0], &bv[0], &b_iv[0]);
  ret = (real_T(*)[26])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void t_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId)
{
  static const int32_T dims = 0;
  emlrtCheckStructR2012b((emlrtConstCTX)sp, parentId, u, 0, NULL, 0U,
                         (const void *)&dims);
  emlrtDestroyArray(&u);
}

static real_T (*tb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                    const emlrtMsgIdentifier *msgId))[2]
{
  static const int32_T dims[2] = {1, 2};
  real_T(*ret)[2];
  int32_T b_iv[2];
  boolean_T bv[2] = {false, false};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                            (const void *)&dims[0], &bv[0], &b_iv[0]);
  ret = (real_T(*)[2])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static boolean_T u_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId)
{
  boolean_T y;
  y = vb_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static void ub_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims[2] = {1, 0};
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "char", false, 2U,
                          (const void *)&dims[0]);
  emlrtDestroyArray(&src);
}

static void v_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               cell_wrap_4 y[5])
{
  emlrtMsgIdentifier thisId;
  int32_T b_iv[2];
  int32_T i;
  char_T str[11];
  boolean_T bv[2];
  thisId.fParent = parentId;
  thisId.bParentIsCell = true;
  bv[0] = false;
  b_iv[0] = 1;
  bv[1] = false;
  b_iv[1] = 5;
  emlrtCheckCell((emlrtCTX)sp, parentId, u, 2U, &b_iv[0], &bv[0]);
  for (i = 0; i < 5; i++) {
    emlrtMexSnprintf(&str[0], (size_t)11U, "%d", i + 1);
    thisId.fIdentifier = &str[0];
    w_emlrt_marshallIn(sp,
                       emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, i)),
                       &thisId, y[i].f1);
  }
  emlrtDestroyArray(&u);
}

static boolean_T vb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                     const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims = 0;
  boolean_T ret;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "logical", false, 0U,
                          (const void *)&dims);
  ret = *emlrtMxGetLogicals(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void w_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, real_T y[18])
{
  wb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void wb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId, real_T ret[18])
{
  static const int32_T dims = 18;
  real_T(*r)[18];
  int32_T i;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 1U,
                          (const void *)&dims);
  r = (real_T(*)[18])emlrtMxGetData(src);
  for (i = 0; i < 18; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

static void x_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId)
{
  static const int32_T dims = 0;
  static const char_T *fieldNames[2] = {"Description", "UserData"};
  emlrtMsgIdentifier thisId;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b((emlrtConstCTX)sp, parentId, u, 2,
                         (const char_T **)&fieldNames[0], 0U,
                         (const void *)&dims);
  thisId.fIdentifier = "Description";
  r_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 0,
                                                    "Description")),
                     &thisId);
  thisId.fIdentifier = "UserData";
  y_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, 0, 1, "UserData")),
      &thisId);
  emlrtDestroyArray(&u);
}

static void xb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims[2] = {0, 0};
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                          (const void *)&dims[0]);
  emlrtMxGetData(src);
  emlrtDestroyArray(&src);
}

static void y_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId)
{
  xb_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
}

static void yb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId, real_T ret[25])
{
  static const int32_T dims = 25;
  real_T(*r)[25];
  int32_T i;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 1U,
                          (const void *)&dims);
  r = (real_T(*)[25])emlrtMxGetData(src);
  for (i = 0; i < 25; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

void age_SEIR_RSV_intervention_api(c_age_SEIR_RSV_interventionStac *SD,
                                   const mxArray *const prhs[68],
                                   const mxArray **plhs)
{
  static const int32_T b_iv[13] = {3, 3, 4, 5, 3, 3, 4, 5, 3, 3, 4, 5, 5};
  static const uint32_T uv[12] = {913576686U,  128563055U,  542890784U,
                                  2652148966U, 1488364428U, 750616685U,
                                  3461043304U, 2874626807U, 1904777941U,
                                  2387697450U, 1823820701U, 2679439217U};
  static const uint32_T uv1[12] = {913576686U,  128563055U,  542890784U,
                                   2652148966U, 2847399386U, 2981411205U,
                                   2569919129U, 1337475054U, 2477281755U,
                                   3552297213U, 1177821400U, 3644942642U};
  static const char_T *b_sv[21] = {
      "matlab.internal.coder.table",
      "metaDim",
      "populationSizeTable.metaDim",
      "matlab.internal.coder.tabular.private.metaDim",
      "labels",
      "populationSizeTable.metaDim.labels",
      "populationSizeTable.metaDim.labels",
      "matlab.internal.coder.table",
      "rowDim",
      "populationSizeTable.rowDim",
      "matlab.internal.coder.tabular.private.rowNamesDim",
      "length",
      "populationSizeTable.rowDim.length",
      "populationSizeTable.rowDim.length",
      "matlab.internal.coder.table",
      "varDim",
      "populationSizeTable.varDim",
      "matlab.internal.coder.tabular.private.varNamesDim",
      "labels",
      "populationSizeTable.varDim.labels",
      "populationSizeTable.varDim.labels"};
  static const char_T *sv1[21] = {
      "matlab.internal.coder.table",
      "metaDim",
      "populationSizeTableRev.metaDim",
      "matlab.internal.coder.tabular.private.metaDim",
      "labels",
      "populationSizeTableRev.metaDim.labels",
      "populationSizeTableRev.metaDim.labels",
      "matlab.internal.coder.table",
      "rowDim",
      "populationSizeTableRev.rowDim",
      "matlab.internal.coder.tabular.private.rowNamesDim",
      "length",
      "populationSizeTableRev.rowDim.length",
      "populationSizeTableRev.rowDim.length",
      "matlab.internal.coder.table",
      "varDim",
      "populationSizeTableRev.varDim",
      "matlab.internal.coder.tabular.private.varNamesDim",
      "labels",
      "populationSizeTableRev.varDim.labels",
      "populationSizeTableRev.varDim.labels"};
  b_table populationSizeTableRev;
  datetime a__4;
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  const mxArray *prhs_copy_idx_0;
  const mxArray *prhs_copy_idx_1;
  const mxArray *prhs_copy_idx_10;
  const mxArray *prhs_copy_idx_11;
  const mxArray *prhs_copy_idx_12;
  const mxArray *prhs_copy_idx_13;
  const mxArray *prhs_copy_idx_14;
  const mxArray *prhs_copy_idx_15;
  const mxArray *prhs_copy_idx_16;
  const mxArray *prhs_copy_idx_17;
  const mxArray *prhs_copy_idx_18;
  const mxArray *prhs_copy_idx_19;
  const mxArray *prhs_copy_idx_2;
  const mxArray *prhs_copy_idx_20;
  const mxArray *prhs_copy_idx_21;
  const mxArray *prhs_copy_idx_22;
  const mxArray *prhs_copy_idx_23;
  const mxArray *prhs_copy_idx_24;
  const mxArray *prhs_copy_idx_25;
  const mxArray *prhs_copy_idx_26;
  const mxArray *prhs_copy_idx_27;
  const mxArray *prhs_copy_idx_3;
  const mxArray *prhs_copy_idx_4;
  const mxArray *prhs_copy_idx_5;
  const mxArray *prhs_copy_idx_6;
  const mxArray *prhs_copy_idx_7;
  const mxArray *prhs_copy_idx_8;
  const mxArray *prhs_copy_idx_9;
  table populationSizeTable;
  real_T(*stateA0)[2007500];
  real_T(*stateA1)[2007500];
  real_T(*stateA2)[2007500];
  real_T(*stateA3)[2007500];
  real_T(*stateE0)[2007500];
  real_T(*stateE1)[2007500];
  real_T(*stateE2)[2007500];
  real_T(*stateE3)[2007500];
  real_T(*stateI0)[2007500];
  real_T(*stateI1)[2007500];
  real_T(*stateI2)[2007500];
  real_T(*stateI3)[2007500];
  real_T(*stateM)[2007500];
  real_T(*stateR0)[2007500];
  real_T(*stateR1)[2007500];
  real_T(*stateR2)[2007500];
  real_T(*stateR3)[2007500];
  real_T(*stateS0)[2007500];
  real_T(*stateS1)[2007500];
  real_T(*stateS2)[2007500];
  real_T(*stateS3)[2007500];
  real_T(*stateVmab1)[2007500];
  real_T(*stateVmab2)[2007500];
  real_T(*stateVmvax1)[2007500];
  real_T(*stateVmvax2)[2007500];
  real_T(*stateVpvax1)[2007500];
  real_T(*stateVpvax2)[2007500];
  real_T(*stateZ)[2007500];
  real_T(*conversationContactMatr)[625];
  real_T(*phyContactMatr)[625];
  real_T(*ageGroupDefRangeAll)[26];
  real_T(*a__1)[25];
  real_T(*a__2)[25];
  real_T(*a__3)[25];
  real_T(*mAbCoverage)[25];
  real_T(*mVaxCoverage)[25];
  real_T(*oVaxCoverage)[25];
  real_T(*totalPopulation)[25];
  real_T(*pAsym)[4];
  real_T(*muBirthRate)[2];
  real_T alphaReductionInfectiousness;
  real_T b1AmpTransmissPeak;
  real_T dateStart;
  real_T delta1RelSuscep;
  real_T delta2RelSuscep;
  real_T delta3RelSuscep;
  real_T dt;
  real_T g1ReductionInfectiousDuration;
  real_T g2ReductionInfectiousDuration;
  real_T gammaZeroPrimaryInfection;
  real_T iniInfectiousProp;
  real_T iniRecoveredProp;
  real_T mAbDuration;
  real_T mVaxDuration;
  real_T numDays;
  real_T numTimeSteps;
  real_T oVaxDuration;
  real_T omegaInfectionImmunity;
  real_T phiSeasonalShift;
  real_T probSeropos;
  real_T psiSeasonalWavelength;
  real_T qTransmissConversation;
  real_T qTransmissPhysical;
  real_T sigmaExposure;
  real_T xiMaternalImmunity;
  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  prhs_copy_idx_0 = emlrtProtectR2012b(prhs[0], 0, false, -1);
  prhs_copy_idx_1 = emlrtProtectR2012b(prhs[1], 1, false, -1);
  prhs_copy_idx_2 = emlrtProtectR2012b(prhs[2], 2, false, -1);
  prhs_copy_idx_3 = emlrtProtectR2012b(prhs[3], 3, false, -1);
  prhs_copy_idx_4 = emlrtProtectR2012b(prhs[4], 4, false, -1);
  prhs_copy_idx_5 = emlrtProtectR2012b(prhs[5], 5, false, -1);
  prhs_copy_idx_6 = emlrtProtectR2012b(prhs[6], 6, false, -1);
  prhs_copy_idx_7 = emlrtProtectR2012b(prhs[7], 7, false, -1);
  prhs_copy_idx_8 = emlrtProtectR2012b(prhs[8], 8, false, -1);
  prhs_copy_idx_9 = emlrtProtectR2012b(prhs[9], 9, false, -1);
  prhs_copy_idx_10 = emlrtProtectR2012b(prhs[10], 10, false, -1);
  prhs_copy_idx_11 = emlrtProtectR2012b(prhs[11], 11, false, -1);
  prhs_copy_idx_12 = emlrtProtectR2012b(prhs[12], 12, false, -1);
  prhs_copy_idx_13 = emlrtProtectR2012b(prhs[13], 13, false, -1);
  prhs_copy_idx_14 = emlrtProtectR2012b(prhs[14], 14, false, -1);
  prhs_copy_idx_15 = emlrtProtectR2012b(prhs[15], 15, false, -1);
  prhs_copy_idx_16 = emlrtProtectR2012b(prhs[16], 16, false, -1);
  prhs_copy_idx_17 = emlrtProtectR2012b(prhs[17], 17, false, -1);
  prhs_copy_idx_18 = emlrtProtectR2012b(prhs[18], 18, false, -1);
  prhs_copy_idx_19 = emlrtProtectR2012b(prhs[19], 19, false, -1);
  prhs_copy_idx_20 = emlrtProtectR2012b(prhs[20], 20, false, -1);
  prhs_copy_idx_21 = emlrtProtectR2012b(prhs[21], 21, false, -1);
  prhs_copy_idx_22 = emlrtProtectR2012b(prhs[22], 22, false, -1);
  prhs_copy_idx_23 = emlrtProtectR2012b(prhs[23], 23, false, -1);
  prhs_copy_idx_24 = emlrtProtectR2012b(prhs[24], 24, false, -1);
  prhs_copy_idx_25 = emlrtProtectR2012b(prhs[25], 25, false, -1);
  prhs_copy_idx_26 = emlrtProtectR2012b(prhs[26], 26, false, -1);
  prhs_copy_idx_27 = emlrtProtectR2012b(prhs[27], 27, false, -1);
  /* Check constant function inputs */
  emlrtCheckArrayChecksumR2018b(&st, prhs[40], false, &b_iv[0],
                                (const char_T **)&b_sv[0], &uv[0]);
  emlrtCheckArrayChecksumR2018b(&st, prhs[41], false, &b_iv[0],
                                (const char_T **)&sv1[0], &uv1[0]);
  /* Marshall function inputs */
  stateM = emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_0), "stateM");
  stateS0 = emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_1), "stateS0");
  stateS1 = emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_2), "stateS1");
  stateS2 = emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_3), "stateS2");
  stateS3 = emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_4), "stateS3");
  stateE0 = emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_5), "stateE0");
  stateE1 = emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_6), "stateE1");
  stateE2 = emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_7), "stateE2");
  stateE3 = emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_8), "stateE3");
  stateI0 = emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_9), "stateI0");
  stateI1 = emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_10), "stateI1");
  stateI2 = emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_11), "stateI2");
  stateI3 = emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_12), "stateI3");
  stateA0 = emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_13), "stateA0");
  stateA1 = emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_14), "stateA1");
  stateA2 = emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_15), "stateA2");
  stateA3 = emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_16), "stateA3");
  stateR0 = emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_17), "stateR0");
  stateR1 = emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_18), "stateR1");
  stateR2 = emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_19), "stateR2");
  stateR3 = emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_20), "stateR3");
  stateZ = emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_21), "stateZ");
  stateVmab1 =
      emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_22), "stateVmab1");
  stateVmab2 =
      emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_23), "stateVmab2");
  stateVmvax1 =
      emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_24), "stateVmvax1");
  stateVmvax2 =
      emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_25), "stateVmvax2");
  stateVpvax1 =
      emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_26), "stateVpvax1");
  stateVpvax2 =
      emlrt_marshallIn(&st, emlrtAlias(prhs_copy_idx_27), "stateVpvax2");
  mAbCoverage = c_emlrt_marshallIn(&st, emlrtAlias(prhs[28]), "mAbCoverage");
  a__1 = c_emlrt_marshallIn(&st, emlrtAlias(prhs[29]), "~1");
  mAbDuration = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[30]), "mAbDuration");
  mVaxCoverage = c_emlrt_marshallIn(&st, emlrtAlias(prhs[31]), "mVaxCoverage");
  a__2 = c_emlrt_marshallIn(&st, emlrtAlias(prhs[32]), "~2");
  mVaxDuration = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[33]), "mVaxDuration");
  oVaxCoverage = c_emlrt_marshallIn(&st, emlrtAlias(prhs[34]), "oVaxCoverage");
  a__3 = c_emlrt_marshallIn(&st, emlrtAlias(prhs[35]), "~3");
  oVaxDuration = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[36]), "oVaxDuration");
  totalPopulation =
      c_emlrt_marshallIn(&st, emlrtAlias(prhs[37]), "totalPopulation");
  ageGroupDefRangeAll =
      g_emlrt_marshallIn(&st, emlrtAlias(prhs[38]), "ageGroupDefRangeAll");
  muBirthRate = i_emlrt_marshallIn(&st, emlrtAlias(prhs[39]), "muBirthRate");
  k_emlrt_marshallIn(&st, emlrtAliasP(prhs[40]), "populationSizeTable",
                     &populationSizeTable);
  ab_emlrt_marshallIn(&st, emlrtAliasP(prhs[41]), "populationSizeTableRev",
                      &populationSizeTableRev);
  phyContactMatr =
      hb_emlrt_marshallIn(&st, emlrtAlias(prhs[42]), "phyContactMatr");
  conversationContactMatr =
      hb_emlrt_marshallIn(&st, emlrtAlias(prhs[43]), "conversationContactMatr");
  iniInfectiousProp =
      e_emlrt_marshallIn(&st, emlrtAliasP(prhs[44]), "iniInfectiousProp");
  iniRecoveredProp =
      e_emlrt_marshallIn(&st, emlrtAliasP(prhs[45]), "iniRecoveredProp");
  a__4 = jb_emlrt_marshallIn(&st, emlrtAliasP(prhs[46]), "~4");
  dateStart = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[47]), "dateStart");
  numDays = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[48]), "numDays");
  numTimeSteps = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[49]), "numTimeSteps");
  dt = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[50]), "dt");
  xiMaternalImmunity =
      e_emlrt_marshallIn(&st, emlrtAliasP(prhs[51]), "xiMaternalImmunity");
  omegaInfectionImmunity =
      e_emlrt_marshallIn(&st, emlrtAliasP(prhs[52]), "omegaInfectionImmunity");
  sigmaExposure =
      e_emlrt_marshallIn(&st, emlrtAliasP(prhs[53]), "sigmaExposure");
  gammaZeroPrimaryInfection = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[54]),
                                                 "gammaZeroPrimaryInfection");
  g1ReductionInfectiousDuration = e_emlrt_marshallIn(
      &st, emlrtAliasP(prhs[55]), "g1ReductionInfectiousDuration");
  g2ReductionInfectiousDuration = e_emlrt_marshallIn(
      &st, emlrtAliasP(prhs[56]), "g2ReductionInfectiousDuration");
  delta1RelSuscep =
      e_emlrt_marshallIn(&st, emlrtAliasP(prhs[57]), "delta1RelSuscep");
  delta2RelSuscep =
      e_emlrt_marshallIn(&st, emlrtAliasP(prhs[58]), "delta2RelSuscep");
  delta3RelSuscep =
      e_emlrt_marshallIn(&st, emlrtAliasP(prhs[59]), "delta3RelSuscep");
  pAsym = nb_emlrt_marshallIn(&st, emlrtAlias(prhs[60]), "pAsym");
  alphaReductionInfectiousness = e_emlrt_marshallIn(
      &st, emlrtAliasP(prhs[61]), "alphaReductionInfectiousness");
  qTransmissPhysical =
      e_emlrt_marshallIn(&st, emlrtAliasP(prhs[62]), "qTransmissPhysical");
  qTransmissConversation =
      e_emlrt_marshallIn(&st, emlrtAliasP(prhs[63]), "qTransmissConversation");
  b1AmpTransmissPeak =
      e_emlrt_marshallIn(&st, emlrtAliasP(prhs[64]), "b1AmpTransmissPeak");
  phiSeasonalShift =
      e_emlrt_marshallIn(&st, emlrtAliasP(prhs[65]), "phiSeasonalShift");
  psiSeasonalWavelength =
      e_emlrt_marshallIn(&st, emlrtAliasP(prhs[66]), "psiSeasonalWavelength");
  probSeropos = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[67]), "probSeropos");
  /* Invoke the target function */
  emxInitStruct_struct1_T(&st, &SD->f0.out, &j_emlrtRTEI);
  age_SEIR_RSV_intervention(
      &st, *stateM, *stateS0, *stateS1, *stateS2, *stateS3, *stateE0, *stateE1,
      *stateE2, *stateE3, *stateI0, *stateI1, *stateI2, *stateI3, *stateA0,
      *stateA1, *stateA2, *stateA3, *stateR0, *stateR1, *stateR2, *stateR3,
      *stateZ, *stateVmab1, *stateVmab2, *stateVmvax1, *stateVmvax2,
      *stateVpvax1, *stateVpvax2, *mAbCoverage, *a__1, mAbDuration,
      *mVaxCoverage, *a__2, mVaxDuration, *oVaxCoverage, *a__3, oVaxDuration,
      *totalPopulation, *ageGroupDefRangeAll, *muBirthRate,
      &populationSizeTable, &populationSizeTableRev, *phyContactMatr,
      *conversationContactMatr, iniInfectiousProp, iniRecoveredProp, &a__4,
      dateStart, numDays, numTimeSteps, dt, xiMaternalImmunity,
      omegaInfectionImmunity, sigmaExposure, gammaZeroPrimaryInfection,
      g1ReductionInfectiousDuration, g2ReductionInfectiousDuration,
      delta1RelSuscep, delta2RelSuscep, delta3RelSuscep, *pAsym,
      alphaReductionInfectiousness, qTransmissPhysical, qTransmissConversation,
      b1AmpTransmissPeak, phiSeasonalShift, psiSeasonalWavelength, probSeropos,
      &SD->f0.out);
  /* Marshall function outputs */
  *plhs = emlrt_marshallOut(&SD->f0.out);
  emxFreeStruct_struct1_T(&st, &SD->f0.out);
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

/* End of code generation (_coder_age_SEIR_RSV_intervention_api.c) */
