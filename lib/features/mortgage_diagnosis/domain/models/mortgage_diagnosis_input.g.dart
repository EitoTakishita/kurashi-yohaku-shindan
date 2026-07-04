// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mortgage_diagnosis_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MortgageDiagnosisInputImpl _$$MortgageDiagnosisInputImplFromJson(
        Map<String, dynamic> json) =>
    _$MortgageDiagnosisInputImpl(
      householdInfo:
          HouseholdInfo.fromJson(json['householdInfo'] as Map<String, dynamic>),
      downPayment: (json['downPayment'] as num?)?.toDouble() ?? 0,
      interestRate: (json['interestRate'] as num?)?.toDouble() ?? 0.6,
      loanYears: (json['loanYears'] as num?)?.toInt() ?? 35,
      propertyType: json['propertyType'] as String? ?? 'house',
    );

Map<String, dynamic> _$$MortgageDiagnosisInputImplToJson(
        _$MortgageDiagnosisInputImpl instance) =>
    <String, dynamic>{
      'householdInfo': instance.householdInfo,
      'downPayment': instance.downPayment,
      'interestRate': instance.interestRate,
      'loanYears': instance.loanYears,
      'propertyType': instance.propertyType,
    };
