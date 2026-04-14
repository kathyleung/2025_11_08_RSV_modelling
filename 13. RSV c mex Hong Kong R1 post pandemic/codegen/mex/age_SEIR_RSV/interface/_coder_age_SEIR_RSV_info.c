/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_age_SEIR_RSV_info.c
 *
 * Code generation for function 'age_SEIR_RSV'
 *
 */

/* Include files */
#include "_coder_age_SEIR_RSV_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

/* Function Declarations */
static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

/* Function Definitions */
static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[6] = {
      "789ced574f6fd3301477d998380c9890d8858bf90251ab6a62700b6bb786b683b5152051"
      "54dcc46dadda4e48dd9170807e01c467e07371d9853b270e9c489ab8"
      "4d83a25404655ab577c8cbcb2ff6effd719e1d50d09a0500c01d10c8e85ea06f87f65ea8"
      "6f805589e385506fc56c2937c1f6ca38897f0db56e72811d11181c31",
      "bc1869988c70c445c7b530b0f1c4a4e7d898230342718730dc8e1aa7bec58e23d0c2f021"
      "fffe6884f5717bca803d9a2c3da45163918f7709f16ea7e4232ef17c"
      "c4df937cd63ff2c9f97753f8248e86b8d7ae6aad5eabfd32ca3fcbc8ff20855fe20c098a"
      "fa0af1aa6e734415dd34b0ad08d4a741e5a53f1719fdf994e28fc4df",
      "54df9e3ce9365d58b1c939ee36d54e437dda650af4f20399e71ca5840fbbe552f044870c"
      "3bde731b43030904b909b586062ddb745c5833f910d6fd8b654e04b4"
      "103730233af4720e6d6c4c756c74a3f95758fa7abbbb66bc71bd7cffd65cdffffd7d0ee5"
      "c537fbb5bb95279f94cbe27312e65b77bdee27f0edc5f062e3b578d5",
      "391857ddfee3e367c572fb8c1cba474b3f5ea4f0a4f90112ecbce6bf4818bfa9dffd2c63"
      "bcebf6dd053fe14410447bdec66b7877260f76bfacfb9ee4df49f427"
      "400c733a6ff592ef6746be2f897cabf8a5d5fbef7cfbe5cfad4ffdf8966fdf07e2e14eae"
      "7ca16c7adf1feac5f2610d9f71f703d5fa55b7aef71b83da75dfbfaa",
      "7d3feb793ffe3f158f57e23aa2ba3af4426a21e19fb037f5bcff39c51f89e75dff95fc7b"
      "0be0baefff27be5036bdefb3d2f3b1d3faa8f2ca895a27cdc1fb83d3"
      "47a5cad5effb7f0035ed6e1c",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 4736U, &nameCaptureInfo);
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
  xInputs = emlrtCreateLogicalMatrix(1, 56);
  emlrtSetField(xEntryPoints, 0, "QualifiedName",
                emlrtMxCreateString("age_SEIR_RSV"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs",
                emlrtMxCreateDoubleScalar(56.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs",
                emlrtMxCreateDoubleScalar(1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  emlrtSetField(
      xEntryPoints, 0, "ResolvedFilePath",
      emlrtMxCreateString(
          "G:\\My Drive\\MATLAB\\m. RSV modelling\\31. RSV c mex more data no "
          "ILI proxy Hong Kong post pandemic age reduced\\age_SEIR_RSV.m"));
  emlrtSetField(xEntryPoints, 0, "TimeStamp",
                emlrtMxCreateDoubleScalar(739819.66445601848));
  emlrtSetField(xEntryPoints, 0, "Visible", emlrtMxCreateLogicalScalar(true));
  xResult =
      emlrtCreateStructMatrix(1, 1, 7, (const char_T **)&propFieldName[0]);
  emlrtSetField(xResult, 0, "Version",
                emlrtMxCreateString("25.1.0.2973910 (R2025a) Update 1"));
  emlrtSetField(xResult, 0, "ResolvedFunctions",
                (mxArray *)c_emlrtMexFcnResolvedFunctionsI());
  emlrtSetField(xResult, 0, "Checksum",
                emlrtMxCreateString("tcPhmTm7UK707iumAsPoeG"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  emlrtSetField(xResult, 0, "AuxData",
                emlrtMxCreateRowVectorUINT8((const uint8_T *)&v, 216U));
  return xResult;
}

/* End of code generation (_coder_age_SEIR_RSV_info.c) */
