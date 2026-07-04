import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kurashi_yohaku_shindan/shared/models/common_params.dart';
import 'package:kurashi_yohaku_shindan/shared/models/enums.dart';

part 'living_cost_diagnosis_input.freezed.dart';
part 'living_cost_diagnosis_input.g.dart';

/// 生活費診断の入力パラメータ
@freezed
class LivingCostDiagnosisInput with _$LivingCostDiagnosisInput {
  const factory LivingCostDiagnosisInput({
    required HouseholdInfo householdInfo,
    @Default(0) double housingCost,
    @Default(DiningOutFrequency.medium) DiningOutFrequency diningOutFrequency,
  }) = _LivingCostDiagnosisInput;

  factory LivingCostDiagnosisInput.fromJson(Map<String, dynamic> json) =>
      _$LivingCostDiagnosisInputFromJson(json);
}
