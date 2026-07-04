// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mortgage_diagnosis_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MortgageDiagnosisResultImpl _$$MortgageDiagnosisResultImplFromJson(
        Map<String, dynamic> json) =>
    _$MortgageDiagnosisResultImpl(
      recommendedLoanMin: (json['recommendedLoanMin'] as num).toDouble(),
      recommendedLoanMax: (json['recommendedLoanMax'] as num).toDouble(),
      approvalLimitLoanMin: (json['approvalLimitLoanMin'] as num).toDouble(),
      approvalLimitLoanMax: (json['approvalLimitLoanMax'] as num).toDouble(),
      recommendedTotalPrice: (json['recommendedTotalPrice'] as num).toDouble(),
      monthlyPayment: (json['monthlyPayment'] as num).toDouble(),
      totalHousingCost: (json['totalHousingCost'] as num).toDouble(),
      comment: json['comment'] as String,
      diagnosedAt: DateTime.parse(json['diagnosedAt'] as String),
    );

Map<String, dynamic> _$$MortgageDiagnosisResultImplToJson(
        _$MortgageDiagnosisResultImpl instance) =>
    <String, dynamic>{
      'recommendedLoanMin': instance.recommendedLoanMin,
      'recommendedLoanMax': instance.recommendedLoanMax,
      'approvalLimitLoanMin': instance.approvalLimitLoanMin,
      'approvalLimitLoanMax': instance.approvalLimitLoanMax,
      'recommendedTotalPrice': instance.recommendedTotalPrice,
      'monthlyPayment': instance.monthlyPayment,
      'totalHousingCost': instance.totalHousingCost,
      'comment': instance.comment,
      'diagnosedAt': instance.diagnosedAt.toIso8601String(),
    };
