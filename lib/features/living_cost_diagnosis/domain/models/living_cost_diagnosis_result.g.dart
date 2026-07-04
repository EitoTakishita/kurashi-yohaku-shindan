// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'living_cost_diagnosis_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LivingCostDiagnosisResultImpl _$$LivingCostDiagnosisResultImplFromJson(
        Map<String, dynamic> json) =>
    _$LivingCostDiagnosisResultImpl(
      food: (json['food'] as num).toDouble(),
      dailyGoods: (json['dailyGoods'] as num).toDouble(),
      utilities: (json['utilities'] as num).toDouble(),
      communication: (json['communication'] as num).toDouble(),
      transportation: (json['transportation'] as num).toDouble(),
      entertainment: (json['entertainment'] as num).toDouble(),
      savingsCapacity: (json['savingsCapacity'] as num).toDouble(),
      housingBurdenAssessment: json['housingBurdenAssessment'] as String,
      comment: json['comment'] as String,
      diagnosedAt: DateTime.parse(json['diagnosedAt'] as String),
    );

Map<String, dynamic> _$$LivingCostDiagnosisResultImplToJson(
        _$LivingCostDiagnosisResultImpl instance) =>
    <String, dynamic>{
      'food': instance.food,
      'dailyGoods': instance.dailyGoods,
      'utilities': instance.utilities,
      'communication': instance.communication,
      'transportation': instance.transportation,
      'entertainment': instance.entertainment,
      'savingsCapacity': instance.savingsCapacity,
      'housingBurdenAssessment': instance.housingBurdenAssessment,
      'comment': instance.comment,
      'diagnosedAt': instance.diagnosedAt.toIso8601String(),
    };
