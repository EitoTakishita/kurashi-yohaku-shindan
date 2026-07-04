import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kurashi_yohaku_shindan/features/mortgage_diagnosis/presentation/providers/mortgage_diagnosis_provider.dart';
import 'package:kurashi_yohaku_shindan/shared/widgets/banner_ad_widget.dart';

/// 住宅ローン診断結果画面
class MortgageResultPage extends ConsumerWidget {
  const MortgageResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(mortgageDiagnosisResultProvider);
    final input = ref.watch(mortgageDiagnosisInputProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('診断結果'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: resultAsync.when(
          data: (result) {
            if (result == null) {
              return const Center(
                child: Text('診断結果が取得できませんでした'),
              );
            }

            final formatter = NumberFormat('#,###');
            final isApartment = input.propertyType == 'apartment';

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // マスコットキャラクター
                  Center(
                    child: Image.asset(
                      'assets/images/mascot_result.png',
                      height: 140,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 結論コメント
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.purple[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.purple[200]!, width: 2),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.lightbulb_outline,
                            color: Color(0xFF9B59B6), size: 32),
                        const SizedBox(height: 8),
                        Text(
                          result.comment,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    height: 1.6,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 物件総額
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.amber[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.amber[200]!, width: 2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '物件総額の目安',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '借入額 + 頭金',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        Text(
                          '約${formatter.format((result.recommendedTotalPrice / 10000).round())}万円',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.amber[900],
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 借入可能額
                  Text(
                    '借入可能額の目安',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),

                  // 生活推奨額
                  _LoanAmountCard(
                    title: '生活推奨額',
                    minAmount: result.recommendedLoanMin / 10000,
                    maxAmount: result.recommendedLoanMax / 10000,
                    color: const Color(0xFF9B59B6),
                    description: '生活費とのバランスを重視',
                    formatter: formatter,
                    isRecommended: true,
                  ),
                  const SizedBox(height: 12),

                  // 審査上限額
                  _LoanAmountCard(
                    title: '審査上限額',
                    minAmount: result.approvalLimitLoanMin / 10000,
                    maxAmount: result.approvalLimitLoanMax / 10000,
                    color: Colors.orange,
                    description: '金融機関の審査基準',
                    formatter: formatter,
                  ),
                  const SizedBox(height: 32),

                  // 月々の支払い
                  Text(
                    '月々の支払い目安',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!, width: 2),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('ローン返済額',
                                style: Theme.of(context).textTheme.bodyLarge),
                            Text(
                              '${formatter.format(result.monthlyPayment)}円/月',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF9B59B6),
                                  ),
                            ),
                          ],
                        ),
                        if (isApartment) ...[
                          const SizedBox(height: 12),
                          const Divider(),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('管理費・修繕積立金',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              Text('約25,000円/月',
                                  style:
                                      Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('固定資産税（月割）',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              Text(
                                  '約${formatter.format(result.totalHousingCost - result.monthlyPayment - 25000)}円/月',
                                  style:
                                      Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Divider(),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('総住居費',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold)),
                              Text(
                                '${formatter.format(result.totalHousingCost)}円/月',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 補足情報
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.info_outline, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              '診断の考え方',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '金利は${input.interestRate.toStringAsFixed(2)}%（${input.interestRate == 0.6 ? '2025年の平均的な変動金利' : 'カスタム設定'}）で計算しています。\n\n'
                          '「生活推奨額」は年収の25%、「審査上限額」は年収の30-35%を返済負担率として計算しています。\n\n'
                          '固定資産税は物件価格の約0.98%/年（評価額70% × 税率1.4%）で試算しています。'
                          '${isApartment ? '\n\nマンションの管理費・修繕積立金は物件により異なり、将来値上がりする可能性があります。' : ''}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[700],
                                    height: 1.6,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  Text(
                    '※ この診断結果は参考目安です。実際の借入判断は、金融機関の審査や将来の金利変動リスクも含めて慎重にご検討ください。',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // バナー広告
                  const BannerAdWidget(),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF9B59B6),
                        side: const BorderSide(
                            color: Color(0xFF9B59B6), width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('もう一度診断する',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text('エラーが発生しました: $error'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoanAmountCard extends StatelessWidget {
  const _LoanAmountCard({
    required this.title,
    required this.minAmount,
    required this.maxAmount,
    required this.color,
    required this.description,
    required this.formatter,
    this.isRecommended = false,
  });

  final String title;
  final double minAmount;
  final double maxAmount;
  final Color color;
  final String description;
  final NumberFormat formatter;
  final bool isRecommended;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isRecommended ? color : Colors.grey[300]!,
          width: isRecommended ? 3 : 2,
        ),
        boxShadow: isRecommended
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(title,
                    style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
              ),
              if (isRecommended) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('おすすめ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '${formatter.format(minAmount)} 〜 ${formatter.format(maxAmount)}万円',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 8),
          Text(description,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey[600])),
        ],
      ),
    );
  }
}
