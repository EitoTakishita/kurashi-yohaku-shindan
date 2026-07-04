import 'package:freezed_annotation/freezed_annotation.dart';

part 'rent_diagnosis_result.freezed.dart';
part 'rent_diagnosis_result.g.dart';

/// 家賃診断の結果
@freezed
class RentDiagnosisResult with _$RentDiagnosisResult {
  const factory RentDiagnosisResult({
    required double safeRent,
    required double standardRent,
    required double limitRent,
    required double monthlySurplus,
    required String comment,
    required DateTime diagnosedAt,
  }) = _RentDiagnosisResult;

  factory RentDiagnosisResult.fromJson(Map<String, dynamic> json) =>
      _$RentDiagnosisResultFromJson(json);
}
