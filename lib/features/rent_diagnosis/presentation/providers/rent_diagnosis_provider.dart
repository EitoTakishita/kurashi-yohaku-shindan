import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kurashi_yohaku_shindan/features/rent_diagnosis/domain/models/rent_diagnosis_input.dart';
import 'package:kurashi_yohaku_shindan/features/rent_diagnosis/domain/models/rent_diagnosis_result.dart';
import 'package:kurashi_yohaku_shindan/features/rent_diagnosis/domain/services/rent_diagnosis_service.dart';
import 'package:kurashi_yohaku_shindan/shared/models/common_params.dart';

/// 診断サービスのプロバイダー
final rentDiagnosisServiceProvider = Provider((ref) {
  return RentDiagnosisService();
});

/// 入力パラメータの状態管理
class RentDiagnosisInputNotifier extends StateNotifier<HouseholdInfo> {
  RentDiagnosisInputNotifier()
      : super(const HouseholdInfo(
          householdSize: 1,
          monthlyIncome: 0,
        ));

  void updateMonthlyIncome(double income) {
    state = state.copyWith(monthlyIncome: income);
  }

  void updateHouseholdSize(int size) {
    state = state.copyWith(householdSize: size);
  }

  void reset() {
    state = const HouseholdInfo(
      householdSize: 1,
      monthlyIncome: 0,
    );
  }
}

final rentDiagnosisInputProvider =
    StateNotifierProvider<RentDiagnosisInputNotifier, HouseholdInfo>((ref) {
  return RentDiagnosisInputNotifier();
});

/// 診断結果のプロバイダー
final rentDiagnosisResultProvider =
    FutureProvider.autoDispose<RentDiagnosisResult?>((ref) async {
  final service = ref.watch(rentDiagnosisServiceProvider);
  final householdInfo = ref.watch(rentDiagnosisInputProvider);

  // 収入が入力されていない場合はnullを返す
  if (householdInfo.monthlyIncome <= 0) {
    return null;
  }

  final input = RentDiagnosisInput(householdInfo: householdInfo);
  return await service.diagnose(input);
});
