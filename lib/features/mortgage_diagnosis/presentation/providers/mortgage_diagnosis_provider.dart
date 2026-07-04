import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kurashi_yohaku_shindan/features/mortgage_diagnosis/domain/models/mortgage_diagnosis_input.dart';
import 'package:kurashi_yohaku_shindan/features/mortgage_diagnosis/domain/models/mortgage_diagnosis_result.dart';
import 'package:kurashi_yohaku_shindan/features/mortgage_diagnosis/domain/services/mortgage_diagnosis_service.dart';
import 'package:kurashi_yohaku_shindan/shared/models/common_params.dart';

/// 診断サービスのプロバイダー
final mortgageDiagnosisServiceProvider = Provider((ref) {
  return MortgageDiagnosisService();
});

/// 入力パラメータの状態管理
class MortgageDiagnosisInputNotifier extends StateNotifier<MortgageDiagnosisInput> {
  MortgageDiagnosisInputNotifier()
      : super(MortgageDiagnosisInput(
          householdInfo: const HouseholdInfo(
            householdSize: 2,
            monthlyIncome: 0,
          ),
          downPayment: 0,
          interestRate: 0.6,
          loanYears: 35,
          propertyType: 'house',
        ));

  void updateMonthlyIncome(double income) {
    state = state.copyWith(
      householdInfo: state.householdInfo.copyWith(monthlyIncome: income),
    );
  }

  void updateDownPayment(double downPayment) {
    state = state.copyWith(downPayment: downPayment);
  }

  void updateLoanYears(int years) {
    state = state.copyWith(loanYears: years);
  }

  void updatePropertyType(String propertyType) {
    state = state.copyWith(propertyType: propertyType);
  }

  void updateInterestRate(double rate) {
    state = state.copyWith(interestRate: rate);
  }

  void reset() {
    state = MortgageDiagnosisInput(
      householdInfo: const HouseholdInfo(
        householdSize: 2,
        monthlyIncome: 0,
      ),
      downPayment: 0,
      interestRate: 0.6,
      loanYears: 35,
      propertyType: 'house',
    );
  }
}

final mortgageDiagnosisInputProvider =
    StateNotifierProvider<MortgageDiagnosisInputNotifier, MortgageDiagnosisInput>((ref) {
  return MortgageDiagnosisInputNotifier();
});

/// 診断結果のプロバイダー
final mortgageDiagnosisResultProvider =
    FutureProvider.autoDispose<MortgageDiagnosisResult?>((ref) async {
  final service = ref.watch(mortgageDiagnosisServiceProvider);
  final input = ref.watch(mortgageDiagnosisInputProvider);

  // 収入が入力されていない場合はnullを返す
  if (input.householdInfo.monthlyIncome <= 0) {
    return null;
  }

  return await service.diagnose(input);
});
