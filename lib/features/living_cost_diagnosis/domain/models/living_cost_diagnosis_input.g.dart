// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'living_cost_diagnosis_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LivingCostDiagnosisInputImpl _$$LivingCostDiagnosisInputImplFromJson(
        Map<String, dynamic> json) =>
    _$LivingCostDiagnosisInputImpl(
      householdInfo:
          HouseholdInfo.fromJson(json['householdInfo'] as Map<String, dynamic>),
      housingCost: (json['housingCost'] as num?)?.toDouble() ?? 0,
      diningOutFrequency: $enumDecodeNullable(
              _$DiningOutFrequencyEnumMap, json['diningOutFrequency']) ??
          DiningOutFrequency.medium,
    );

Map<String, dynamic> _$$LivingCostDiagnosisInputImplToJson(
        _$LivingCostDiagnosisInputImpl instance) =>
    <String, dynamic>{
      'householdInfo': instance.householdInfo,
      'housingCost': instance.housingCost,
      'diningOutFrequency':
          _$DiningOutFrequencyEnumMap[instance.diningOutFrequency]!,
    };

const _$DiningOutFrequencyEnumMap = {
  DiningOutFrequency.low: 'low',
  DiningOutFrequency.medium: 'medium',
  DiningOutFrequency.high: 'high',
};
