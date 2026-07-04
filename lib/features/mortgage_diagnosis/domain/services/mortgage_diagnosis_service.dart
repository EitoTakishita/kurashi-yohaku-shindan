import 'dart:math';
import 'package:kurashi_yohaku_shindan/features/mortgage_diagnosis/domain/models/mortgage_diagnosis_input.dart';
import 'package:kurashi_yohaku_shindan/features/mortgage_diagnosis/domain/models/mortgage_diagnosis_result.dart';

/// 住宅ローン診断サービス
class MortgageDiagnosisService {
  /// 住宅ローン診断を実行
  Future<MortgageDiagnosisResult> diagnose(MortgageDiagnosisInput input) async {
    final household = input.householdInfo;
    final yearlyIncome = household.monthlyIncome * 12;

    // 1. 返済負担率による上限額を計算
    // 年収400万未満: 30%、400万以上: 35%（フラット35基準）
    // ただし実際は25%程度が生活推奨ライン
    final approvalRatio = yearlyIncome < 4000000 ? 0.30 : 0.35;
    final recommendedRatio = 0.25; // 生活推奨は25%

    // 2. 年間返済額の上限を計算
    final approvalYearlyPayment = yearlyIncome * approvalRatio;
    final recommendedYearlyPayment = yearlyIncome * recommendedRatio;

    // 3. 月々の返済額
    final approvalMonthlyPayment = approvalYearlyPayment / 12;
    final recommendedMonthlyPayment = recommendedYearlyPayment / 12;

    // 4. 借入可能額を逆算（元利均等返済）
    final loanYears = input.loanYears;
    final months = loanYears * 12;
    final monthlyRate = input.interestRate / 100 / 12;

    final approvalLoan = _calculateLoanAmount(
      monthlyPayment: approvalMonthlyPayment,
      monthlyRate: monthlyRate,
      months: months,
    );

    final recommendedLoan = _calculateLoanAmount(
      monthlyPayment: recommendedMonthlyPayment,
      monthlyRate: monthlyRate,
      months: months,
    );

    // 5. 物件総額（頭金込み）
    final recommendedTotalPrice = recommendedLoan + input.downPayment;

    // 6. マンションの場合の維持費
    final isApartment = input.propertyType == 'apartment';
    final maintenanceCost = isApartment ? 25000.0 : 0.0; // マンション: 管理費+修繕積立金 約2.5万円/月

    // 固定資産税の計算（固定資産税評価額 = 物件価格の約70%）
    final propertyTax = (recommendedTotalPrice * 0.7 * 0.014 / 12); // 1.4%/年を月割り
    final totalMonthlyMaintenance = maintenanceCost + propertyTax;

    // 7. 総住居費（返済 + 維持費）
    final totalHousingCost = recommendedMonthlyPayment + totalMonthlyMaintenance;

    // 8. コメント生成
    final comment = _generateComment(
      yearlyIncome: yearlyIncome,
      recommendedLoan: recommendedLoan,
      isApartment: isApartment,
      totalHousingCost: totalHousingCost,
    );

    return MortgageDiagnosisResult(
      recommendedLoanMin: (recommendedLoan * 0.9).roundToDouble(),
      recommendedLoanMax: recommendedLoan.roundToDouble(),
      approvalLimitLoanMin: (approvalLoan * 0.9).roundToDouble(),
      approvalLimitLoanMax: approvalLoan.roundToDouble(),
      recommendedTotalPrice: recommendedTotalPrice.roundToDouble(),
      monthlyPayment: recommendedMonthlyPayment.roundToDouble(),
      totalHousingCost: totalHousingCost.roundToDouble(),
      comment: comment,
      diagnosedAt: DateTime.now(),
    );
  }

  /// 月々の返済額から借入可能額を逆算
  double _calculateLoanAmount({
    required double monthlyPayment,
    required double monthlyRate,
    required int months,
  }) {
    if (monthlyRate == 0) {
      return monthlyPayment * months;
    }

    // 元利均等返済の公式を逆算
    // 月返済額 = 借入額 × (月利 × (1 + 月利)^返済回数) / ((1 + 月利)^返済回数 - 1)
    // → 借入額 = 月返済額 × ((1 + 月利)^返済回数 - 1) / (月利 × (1 + 月利)^返済回数)

    final factor = pow(1 + monthlyRate, months);
    final loanAmount = monthlyPayment * (factor - 1) / (monthlyRate * factor);

    return loanAmount;
  }

  String _generateComment({
    required double yearlyIncome,
    required double recommendedLoan,
    required bool isApartment,
    required double totalHousingCost,
  }) {
    final monthlyIncome = yearlyIncome / 12;
    final housingBurdenRatio = totalHousingCost / monthlyIncome;

    if (isApartment) {
      if (housingBurdenRatio <= 0.28) {
        return 'この借入額なら、管理費・修繕積立金・固定資産税を含めても、生活にゆとりを持ちやすい水準です。マンションならではの維持費も考慮されています。';
      } else if (housingBurdenRatio <= 0.33) {
        return 'この借入額なら、マンションの維持費込みでもバランスの取れた返済計画が立てられそうです。管理費や修繕積立金の値上がりにも備えておきましょう。';
      } else {
        return 'この水準だと、マンションの維持費を含めた総住居費がやや高めになります。管理費や修繕積立金の変動も考慮して、余裕を持った計画をおすすめします。';
      }
    } else {
      if (housingBurdenRatio <= 0.27) {
        return 'この借入額なら、固定資産税などの維持費を含めても、生活にゆとりを持ちやすい水準です。戸建てならではのメンテナンス費用も考慮しておきましょう。';
      } else if (housingBurdenRatio <= 0.32) {
        return 'この借入額なら、バランスの取れた返済計画が立てられそうです。戸建ての場合、外壁や屋根などの大規模修繕に備えた貯蓄も計画しておくと安心です。';
      } else {
        return 'この水準だと、固定資産税や将来のメンテナンス費用を含めると住居費負担がやや高めになります。余裕を持った返済計画をおすすめします。';
      }
    }
  }
}
