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
      "789ced57cf8bd340149eea2a5ed4a22088975c040f12d45d581504936e376c77bb6b9bb2"
      "d61aa9d364da8ece4c4a92665b4f7b11bc7911fc43c4ffc3e382fe01"
      "debd8bf9d1e93681308bd1e8aebecbebeb97ccf7bd37d32f29286dd44b00800b208e4797"
      "e27c7e569767f91448461a2fcdf2e954cde30c584adcc7f1b7b36cda",
      "cc43132f2e18a4687ea76553cc20f35ad311020e726de2232b42fa98a016a6485f2cb6c3"
      "8aae2f40f32284c2cf9521325fea630a9ca17ba8902c16f3793ccfe8"
      "7749308f74a4e791be8ef3edff241f5fffaa808fe37080ba7a75a3d96deabb5d1cccdef1"
      "11f3b0cd7eb19e6b023d1ca7d023b027474a1824b2695bc8913dd823",
      "28a1e720a71e5fa087e34fabcfb4fb467d2aad39d847465d696d29aa4165299897440371"
      "846036305656e36f5c4cc70486f3936c46a6d21ef68612557a126496"
      "e443d30c8e7084aa352373f432159fbb8b47ec339d0faf3f17e58ff297082a8aaf7cf9fd"
      "41917c3cfe14df2463bda39ed32b197ce5145e7357279d7a67a7d61f",
      "f98a56596b3cbedd1e5716fc5cc023d20132eaa2d6ff577eef6f72f67943d027c7e76230"
      "c31e86a41b3c782d1caa7113daf23effb88eb399ba62c4b2c791c573"
      "beaf39f95e67f225f122f65b30e270fb0bf3a7e59bc5fafdfe4370bd483e1e27ddeff73c"
      "acde32e9f2137df7557f5d838dbbed694dfbeff7c7cdef4739fb4cff",
      "8f4af7c9711312531904ad34a117be49ffadeff59f72ea7921d0c3f1dfb8ef895147e60e"
      "8af3a3ef1f3e17eaefe0ddb70785f2cde2a4fb7b7b47452b77940edb"
      "da6e54e8a6d6baa79a9bd5e3efef3f006dba6d62",
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
          "G:\\My Drive\\MATLAB\\m. RSV modelling\\47. RSV simulation only "
          "with mAb and vaccination BJ\\age_SEIR_RSV_intervention.m"));
  emlrtSetField(xEntryPoints, 0, "TimeStamp",
                emlrtMxCreateDoubleScalar(739886.638275463));
  emlrtSetField(xEntryPoints, 0, "Visible", emlrtMxCreateLogicalScalar(true));
  xResult =
      emlrtCreateStructMatrix(1, 1, 7, (const char_T **)&propFieldName[0]);
  emlrtSetField(xResult, 0, "Version",
                emlrtMxCreateString("25.1.0.2973910 (R2025a) Update 1"));
  emlrtSetField(xResult, 0, "ResolvedFunctions",
                (mxArray *)c_emlrtMexFcnResolvedFunctionsI());
  emlrtSetField(xResult, 0, "Checksum",
                emlrtMxCreateString("ay4y1y6TJZeveUVKPKPmW"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  emlrtSetField(xResult, 0, "AuxData",
                emlrtMxCreateRowVectorUINT8((const uint8_T *)&v, 216U));
  return xResult;
}

/* End of code generation (_coder_age_SEIR_RSV_intervention_info.c) */
