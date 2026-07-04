// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HouseholdInfoImpl _$$HouseholdInfoImplFromJson(Map<String, dynamic> json) =>
    _$HouseholdInfoImpl(
      householdSize: (json['householdSize'] as num?)?.toInt() ?? 1,
      monthlyIncome: (json['monthlyIncome'] as num?)?.toDouble() ?? 0,
      regionalCost:
          $enumDecodeNullable(_$RegionalCostEnumMap, json['regionalCost']) ??
              RegionalCost.medium,
      hasCar: json['hasCar'] as bool? ?? false,
      hasChild: json['hasChild'] as bool? ?? false,
      existingMonthlyPayment:
          (json['existingMonthlyPayment'] as num?)?.toDouble() ?? 0,
      savingsPriority: $enumDecodeNullable(
              _$SavingsPriorityEnumMap, json['savingsPriority']) ??
          SavingsPriority.medium,
    );

Map<String, dynamic> _$$HouseholdInfoImplToJson(_$HouseholdInfoImpl instance) =>
    <String, dynamic>{
      'householdSize': instance.householdSize,
      'monthlyIncome': instance.monthlyIncome,
      'regionalCost': _$RegionalCostEnumMap[instance.regionalCost]!,
      'hasCar': instance.hasCar,
      'hasChild': instance.hasChild,
      'existingMonthlyPayment': instance.existingMonthlyPayment,
      'savingsPriority': _$SavingsPriorityEnumMap[instance.savingsPriority]!,
    };

const _$RegionalCostEnumMap = {
  RegionalCost.low: 'low',
  RegionalCost.medium: 'medium',
  RegionalCost.high: 'high',
};

const _$SavingsPriorityEnumMap = {
  SavingsPriority.low: 'low',
  SavingsPriority.medium: 'medium',
  SavingsPriority.high: 'high',
};
