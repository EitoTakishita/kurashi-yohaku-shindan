import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'common_params.freezed.dart';
part 'common_params.g.dart';

/// 共通の世帯情報
@freezed
class HouseholdInfo with _$HouseholdInfo {
  const factory HouseholdInfo({
    @Default(1) int householdSize,
    @Default(0) double monthlyIncome,
    @Default(RegionalCost.medium) RegionalCost regionalCost,
    @Default(false) bool hasCar,
    @Default(false) bool hasChild,
    @Default(0) double existingMonthlyPayment,
    @Default(SavingsPriority.medium) SavingsPriority savingsPriority,
  }) = _HouseholdInfo;

  factory HouseholdInfo.fromJson(Map<String, dynamic> json) =>
      _$HouseholdInfoFromJson(json);
}
