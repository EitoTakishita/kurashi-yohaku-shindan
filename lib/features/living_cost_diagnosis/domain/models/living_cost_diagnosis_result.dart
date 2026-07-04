import 'package:freezed_annotation/freezed_annotation.dart';

part 'living_cost_diagnosis_result.freezed.dart';
part 'living_cost_diagnosis_result.g.dart';

/// 生活費診断の結果
@freezed
class LivingCostDiagnosisResult with _$LivingCostDiagnosisResult {
  const factory LivingCostDiagnosisResult({
    required double food,
    required double dailyGoods,
    required double utilities,
    required double communication,
    required double transportation,
    required double entertainment,
    required double savingsCapacity,
    required String housingBurdenAssessment,
    required String comment,
    required DateTime diagnosedAt,
  }) = _LivingCostDiagnosisResult;

  factory LivingCostDiagnosisResult.fromJson(Map<String, dynamic> json) =>
      _$LivingCostDiagnosisResultFromJson(json);
}
