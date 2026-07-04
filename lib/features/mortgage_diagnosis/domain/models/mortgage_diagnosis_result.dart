import 'package:freezed_annotation/freezed_annotation.dart';

part 'mortgage_diagnosis_result.freezed.dart';
part 'mortgage_diagnosis_result.g.dart';

/// 住宅ローン診断の結果
@freezed
class MortgageDiagnosisResult with _$MortgageDiagnosisResult {
  const factory MortgageDiagnosisResult({
    required double recommendedLoanMin,
    required double recommendedLoanMax,
    required double approvalLimitLoanMin,
    required double approvalLimitLoanMax,
    required double recommendedTotalPrice,
    required double monthlyPayment,
    required double totalHousingCost,
    required String comment,
    required DateTime diagnosedAt,
  }) = _MortgageDiagnosisResult;

  factory MortgageDiagnosisResult.fromJson(Map<String, dynamic> json) =>
      _$MortgageDiagnosisResultFromJson(json);
}
