import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kurashi_yohaku_shindan/shared/models/common_params.dart';

part 'mortgage_diagnosis_input.freezed.dart';
part 'mortgage_diagnosis_input.g.dart';

/// 住宅ローン診断の入力パラメータ
@freezed
class MortgageDiagnosisInput with _$MortgageDiagnosisInput {
  const factory MortgageDiagnosisInput({
    required HouseholdInfo householdInfo,
    @Default(0) double downPayment,
    @Default(0.6) double interestRate,
    @Default(35) int loanYears,
    @Default('house') String propertyType, // 'house' or 'apartment'
  }) = _MortgageDiagnosisInput;

  factory MortgageDiagnosisInput.fromJson(Map<String, dynamic> json) =>
      _$MortgageDiagnosisInputFromJson(json);
}
