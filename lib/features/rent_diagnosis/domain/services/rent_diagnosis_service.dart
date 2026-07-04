import 'package:kurashi_yohaku_shindan/features/rent_diagnosis/domain/models/rent_diagnosis_input.dart';
import 'package:kurashi_yohaku_shindan/features/rent_diagnosis/domain/models/rent_diagnosis_result.dart';

/// 家賃診断サービス（シンプルな比率ベース計算）
class RentDiagnosisService {
  /// 家賃診断を実行
  Future<RentDiagnosisResult> diagnose(RentDiagnosisInput input) async {
    final household = input.householdInfo;
    final monthlyIncome = household.monthlyIncome;

    // シンプルな比率ベースの計算
    // 1人暮らし：手取りの25-30%が目安
    // 2人暮らし：合計手取りの23-28%が目安（スケールメリットで少し抑えめ）

    double safeRatio;
    double standardRatio;
    double limitRatio;

    if (household.householdSize == 1) {
      // 1人暮らし
      safeRatio = 0.23;      // 安全寄り：23%
      standardRatio = 0.27;  // 標準：27%
      limitRatio = 0.32;     // 上限寄り：32%
    } else {
      // 2人暮らし
      safeRatio = 0.22;      // 安全寄り：22%
      standardRatio = 0.26;  // 標準：26%
      limitRatio = 0.30;     // 上限寄り：30%
    }

    final safeRent = (monthlyIncome * safeRatio).roundToDouble();
    final standardRent = (monthlyIncome * standardRatio).roundToDouble();
    final limitRent = (monthlyIncome * limitRatio).roundToDouble();

    // 毎月余力（簡易計算：手取り - 標準家賃 - 基準生活費 - 貯蓄目標）
    final estimatedLivingCost = _estimateLivingCost(household.householdSize);
    final savingsTarget = monthlyIncome * 0.10; // 10%を貯蓄目標とする
    final monthlySurplus = monthlyIncome - standardRent - estimatedLivingCost - savingsTarget;

    // コメント生成
    final comment = _generateComment(
      standardRent: standardRent,
      monthlyIncome: monthlyIncome,
      householdSize: household.householdSize,
      monthlySurplus: monthlySurplus,
    );

    return RentDiagnosisResult(
      safeRent: safeRent,
      standardRent: standardRent,
      limitRent: limitRent,
      monthlySurplus: monthlySurplus,
      comment: comment,
      diagnosedAt: DateTime.now(),
    );
  }

  double _estimateLivingCost(int householdSize) {
    // 家賃以外の基準生活費の目安
    if (householdSize == 1) {
      return 110000; // 1人：約11万円
    } else {
      return 175000; // 2人：約17.5万円
    }
  }

  String _generateComment({
    required double standardRent,
    required double monthlyIncome,
    required int householdSize,
    required double monthlySurplus,
  }) {
    final burdenRatio = standardRent / monthlyIncome;

    if (monthlySurplus < 0) {
      return '収入に対して家賃負担がやや大きくなりそうです。生活費や貯蓄とのバランスを考えると、もう少し抑えめの物件も検討してみましょう。';
    }

    if (householdSize == 1) {
      // 1人暮らし
      if (burdenRatio <= 0.25) {
        return 'この家賃帯なら、貯蓄や趣味にも余裕を持てそうです。生活に安心感を持ちたい方におすすめの水準です。';
      } else if (burdenRatio <= 0.30) {
        return 'この家賃帯なら、バランスの取れた暮らしができそうです。一般的に無理なく続けやすい水準です。';
      } else if (burdenRatio <= 0.35) {
        return 'このラインは上限寄りです。住環境を優先する場合の選択肢になりますが、貯蓄や自由に使えるお金は少し抑えめになります。';
      } else {
        return 'この水準を超えると、生活がタイトになる可能性があります。物件選びでは慎重な検討をおすすめします。';
      }
    } else {
      // 2人暮らし
      if (burdenRatio <= 0.24) {
        return 'この家賃帯なら、2人暮らしでもゆとりを持てそうです。貯蓄や将来の計画も立てやすい水準です。';
      } else if (burdenRatio <= 0.28) {
        return 'この家賃帯なら、2人暮らしでバランスの取れた暮らしができそうです。一般的に無理なく続けやすい水準です。';
      } else if (burdenRatio <= 0.32) {
        return 'このラインは上限寄りです。住環境を優先する場合の選択肢になりますが、貯蓄や自由に使えるお金は少し抑えめになります。';
      } else {
        return 'この水準を超えると、2人暮らしでも生活がタイトになる可能性があります。物件選びでは慎重な検討をおすすめします。';
      }
    }
  }
}
