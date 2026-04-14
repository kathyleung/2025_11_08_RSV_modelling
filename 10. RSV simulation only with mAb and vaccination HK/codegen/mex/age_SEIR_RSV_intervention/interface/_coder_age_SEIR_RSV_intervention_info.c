/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_age_SEIR_RSV_intervention_info.c
 *
 * Code generation for function 'age_SEIR_RSV_intervention'
 *
 */

/* Include files */
#include "_coder_age_SEIR_RSV_intervention_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

/* Function Declarations */
static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

/* Function Definitions */
static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[6] = {
      "789ced57cb6ed340149d40416c808a051262e34d2516c8222a50c4ce4d5ab729ee238e4a"
      "294166624f92a133e3d49eb849574808891dffc0072016fc03db2e91"
      "4062cb67e0d7a4b125cb1506430b77737373ec39e7de991c3ba0b2aa5500005740149bd7"
      "a27c39ae67e37c0e24238d57e27c3e558bb8006612f709fc6d9c4d9b",
      "7134e251c12045933b2d9b6206196f8d070838c8b58987ac10e962825a98227dba580f2a"
      "ba3c054d8a000a3ed7fac8dcd38714387df75821992e26f3789ed1ef"
      "4cce3cd2919e47fa3ac1f7f227f9c4fa3772f8040e7bc8d097569b4653df36b03f7bc743"
      "8c639bfd623d3773f4089c424e60470e95304864d3b6902373d82128",
      "a1e773413d5e8e1e813f5d7aa63e6c6b63a9ee600fb535a5f548596c5359f2e725515f1c"
      "2198f5da77ef47dfb8980e090ce627d98c8ca503ccfb12553a126496"
      "e441d3f48f7088aeacb533472fd3fc7377f5847da6f3f1f597c2fc51fe1a4265f17d78bf"
      "f9ad4c3e117f8a6f94b1de49cfe9f50cbed914de701746bbdaee46a3",
      "3bf014b556df7a5cdd19d6a6fc3c87274f07c8a8cb5aff5ff9bdbf29d8e7ad9c3e053e11"
      "8319e61812c37ff05a3850e326b4157dfe091d1733754588650f438b"
      "177cdf0bf2bdcee44be265ec77ce8883ed2fcd9fe66f97ebf747efe6e6cae41371d6fdfe"
      "80e3c53b269d7fa26f1f769755b8f56067dc50fffbfd69f3fb41c13e",
      "d3ffa3d27d0adc84c4547a7e2b4dc88337e9bff5bdfea8a09e17397a04fe1bf73d31ead0"
      "dc41797e64bcfa52aabf834faa532a5f1c67dddf6975636fd43c5458"
      "5d55d6b0d6ddbfb7be50ad9f7e7fff018e776eb0",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 4712U, &nameCaptureInfo);
  return nameCaptureInfo;
}

mxArray *emlrtMexFcnProperties(void)
{
  mxArray *xEntryPoints;
  mxArray *xInputs;
  mxArray *xResult;
  const char_T *epFieldName[7] = {
      "QualifiedName",    "NumberOfInputs", "NumberOfOutputs", "ConstantInputs",
      "ResolvedFilePath", "TimeStamp",      "Visible"};
  const char_T *propFieldName[7] = {
      "Version",      "ResolvedFunctions", "Checksum", "EntryPoints",
      "CoverageInfo", "IsPolymorphic",     "AuxData"};
  uint8_T v[216] = {
      0U,   1U,   73U,  77U,  0U,   0U,   0U,   0U,   14U,  0U,   0U,   0U,
      200U, 0U,   0U,   0U,   6U,   0U,   0U,   0U,   8U,   0U,   0U,   0U,
      2U,   0U,   0U,   0U,   0U,   0U,   0U,   0U,   5U,   0U,   0U,   0U,
      8U,   0U,   0U,   0U,   1U,   0U,   0U,   0U,   1U,   0U,   0U,   0U,
      1U,   0U,   0U,   0U,   0U,   0U,   0U,   0U,   5U,   0U,   4U,   0U,
      17U,  0U,   0U,   0U,   1U,   0U,   0U,   0U,   17U,  0U,   0U,   0U,
      67U,  108U, 97U,  115U, 115U, 69U,  110U, 116U, 114U, 121U, 80U,  111U,
      105U, 110U, 116U, 115U, 0U,   0U,   0U,   0U,   0U,   0U,   0U,   0U,
      14U,  0U,   0U,   0U,   112U, 0U,   0U,   0U,   6U,   0U,   0U,   0U,
      8U,   0U,   0U,   0U,   2U,   0U,   0U,   0U,   0U,   0U,   0U,   0U,
      5U,   0U,   0U,   0U,   8U,   0U,   0U,   0U,   1U,   0U,   0U,   0U,
      0U,   0U,   0U,   0U,   1U,   0U,   0U,   0U,   0U,   0U,   0U,   0U,
      5U,   0U,   4U,   0U,   14U,  0U,   0U,   0U,   1U,   0U,   0U,   0U,
      56U,  0U,   0U,   0U,   81U,  117U, 97U,  108U, 105U, 102U, 105U, 101U,
      100U, 78U,  97U,  109U, 101U, 0U,   77U,  101U, 116U, 104U, 111U, 100U,
      115U, 0U,   0U,   0U,   0U,   0U,   0U,   0U,   80U,  114U, 111U, 112U,
      101U, 114U, 116U, 105U, 101U, 115U, 0U,   0U,   0U,   0U,   72U,  97U,
      110U, 100U, 108U, 101U, 0U,   0U,   0U,   0U,   0U,   0U,   0U,   0U};
  xEntryPoints =
      emlrtCreateStructMatrix(1, 1, 7, (const char_T **)&epFieldName[0]);
  xInputs = emlrtCreateLogicalMatrix(1, 68);
  emlrtSetField(xEntryPoints, 0, "QualifiedName",
                emlrtMxCreateString("age_SEIR_RSV_intervention"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs",
                emlrtMxCreateDoubleScalar(68.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs",
                emlrtMxCreateDoubleScalar(1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  emlrtSetField(
      xEntryPoints, 0, "ResolvedFilePath",
      emlrtMxCreateString(
          "G:\\My Drive\\MATLAB\\m. RSV modelling\\46. RSV simulation only "
          "with mAb and vaccination HK\\age_SEIR_RSV_intervention.m"));
  emlrtSetField(xEntryPoints, 0, "TimeStamp",
                emlrtMxCreateDoubleScalar(739886.633425926));
  emlrtSetField(xEntryPoints, 0, "Visible", emlrtMxCreateLogicalScalar(true));
  xResult =
      emlrtCreateStructMatrix(1, 1, 7, (const char_T **)&propFieldName[0]);
  emlrtSetField(xResult, 0, "Version",
                emlrtMxCreateString("25.1.0.2973910 (R2025a) Update 1"));
  emlrtSetField(xResult, 0, "ResolvedFunctions",
                (mxArray *)c_emlrtMexFcnResolvedFunctionsI());
  emlrtSetField(xResult, 0, "Checksum",
                emlrtMxCreateString("9wqE1IK0qgy9MjkBTfoIjE"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  emlrtSetField(xResult, 0, "AuxData",
                emlrtMxCreateRowVectorUINT8((const uint8_T *)&v, 216U));
  return xResult;
}

/* End of code generation (_coder_age_SEIR_RSV_intervention_info.c) */
