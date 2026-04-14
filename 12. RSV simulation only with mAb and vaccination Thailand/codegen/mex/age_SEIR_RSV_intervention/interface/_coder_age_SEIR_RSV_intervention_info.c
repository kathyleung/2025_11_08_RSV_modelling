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
      "789ced57416ed340149d40416c808a051262e30d120b641115d48a156ed25a0da4a57154"
      "4a317227f6241975666cec499a542c2ab14162c1153805576085c482"
      "1d2c7a044e8070ec4c128f64b9c26068c4dffc7c3fcfbcf7ff38cf09286dd44b00802b20"
      "0eef5a9c2f8febc5713e079221e3a5713e2fd5222e8085c43a81bf1b",
      "67db651c0d785c3048d164a5e352cc20e3cda187808f0297f49113216d4c50135364cc16"
      "9ba38aaecf409362048d3e57bac83e307a14f8dd60aa90cc169379ec"
      "a7f4bb90310f39e479c8f709bee35fe413fbdfc8e01338ec20cb58db68580d63c7c2e1ec"
      "fd3e621cbbec37ebb999a147e01472025b6aa48441a2daae837c95c3",
      "1641093d2739f5bccad023f0e76b2ff407667da8547ddc47665d6b3ed6564daa2ae1bc14"
      "1a8a2304b38e796f25be1260da2370343fc56564a81c62de55a8d652"
      "2073943eb4edf0118ed0661762125e34530f40a5b3fdeea7f473f594fdca797affa5287f"
      "50bf958ae47bffe5d38f22f944fc2dbe41ca7ea77d5eafa7f02d4a78",
      "2d581eecd5f7b66a6dafafe995eaf6d3f26eaf32d5f12483274b0748a98bdaff2465fdbc"
      "7eefdfe4ecf77646bf029fc8c10c730c8915be881d3cd21324d4e57d"
      "1f0a1d175375c588e3f622cb177cdf73f2bd4de54be2c59d7bc6a0e3c7a030bf5aba53ac"
      "ff1f3f04b78ae41331effe7fc8f1ea5d9b2e3d33768edaeb3adc5ed9",
      "1dd6f4fffe7f56fddfcbd9affc3f4bee57e03624b6d6095b6a408ec0bffbbbff734e3d9e"
      "54cb7a04fec7cf3f31709516e54bd6ebaf85fa3cf8a8fb85f28d63de"
      "7d9e96b70e068d238d5575ed11aeb75fdedf5c2e57cfbecfff046dca7bed",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 4744U, &nameCaptureInfo);
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
          "G:\\My Drive\\MATLAB\\m. RSV modelling\\48. RSV simulation only "
          "with mAb and vaccination Thailand\\age_SEIR_RSV_intervention.m"));
  emlrtSetField(xEntryPoints, 0, "TimeStamp",
                emlrtMxCreateDoubleScalar(739886.64398148144));
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
