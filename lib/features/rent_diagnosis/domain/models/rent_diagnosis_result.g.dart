// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rent_diagnosis_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RentDiagnosisResultImpl _$$RentDiagnosisResultImplFromJson(
        Map<String, dynamic> json) =>
    _$RentDiagnosisResultImpl(
      safeRent: (json['safeRent'] as num).toDouble(),
      standardRent: (json['standardRent'] as num).toDouble(),
      limitRent: (json['limitRent'] as num).toDouble(),
      monthlySurplus: (json['monthlySurplus'] as num).toDouble(),
      comment: json['comment'] as String,
      diagnosedAt: DateTime.parse(json['diagnosedAt'] as String),
    );

Map<String, dynamic> _$$RentDiagnosisResultImplToJson(
        _$RentDiagnosisResultImpl instance) =>
    <String, dynamic>{
      'safeRent': instance.safeRent,
      'standardRent': instance.standardRent,
      'limitRent': instance.limitRent,
      'monthlySurplus': instance.monthlySurplus,
      'comment': instance.comment,
      'diagnosedAt': instance.diagnosedAt.toIso8601String(),
    };
