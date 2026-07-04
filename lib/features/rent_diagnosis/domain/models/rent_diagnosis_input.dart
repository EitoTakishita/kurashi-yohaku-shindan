import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kurashi_yohaku_shindan/shared/models/common_params.dart';

part 'rent_diagnosis_input.freezed.dart';
part 'rent_diagnosis_input.g.dart';

/// 家賃診断の入力パラメータ
@freezed
class RentDiagnosisInput with _$RentDiagnosisInput {
  const factory RentDiagnosisInput({
    required HouseholdInfo householdInfo,
  }) = _RentDiagnosisInput;

  factory RentDiagnosisInput.fromJson(Map<String, dynamic> json) =>
      _$RentDiagnosisInputFromJson(json);
}
