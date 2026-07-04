import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kurashi_yohaku_shindan/features/rent_diagnosis/presentation/providers/rent_diagnosis_provider.dart';
import 'package:kurashi_yohaku_shindan/shared/widgets/banner_ad_widget.dart';

/// 結果画面
class RentResultPage extends ConsumerWidget {
  const RentResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultAsync = ref.watch(rentDiagnosisResultProvider);

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
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.blue[200]!,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.lightbulb_outline,
                          color: Colors.blue,
                          size: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          result.comment,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                                height: 1.6,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 家賃レンジ
                  Text(
                    '適正家賃の目安',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),

                  // 安全寄り
                  _RentRangeCard(
                    title: '安全寄り',
                    amount: result.safeRent,
                    color: Colors.green,
                    description: '貯蓄や余裕を重視する場合',
                    formatter: formatter,
                  ),
                  const SizedBox(height: 12),

                  // 標準
                  _RentRangeCard(
                    title: '標準',
                    amount: result.standardRent,
                    color: Colors.blue,
                    description: 'バランスの取れた水準',
                    formatter: formatter,
                    isRecommended: true,
                  ),
                  const SizedBox(height: 12),

                  // 上限寄り
                  _RentRangeCard(
                    title: '上限寄り',
                    amount: result.limitRent,
                    color: Colors.orange,
                    description: '住環境を優先する場合',
                    formatter: formatter,
                  ),
                  const SizedBox(height: 32),

                  // 補足情報
                  Container(
                    width: double.infinity,
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
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'この診断は、一般的な家計バランスをもとに、無理なく支払える家賃を算出しています。\n\n'
                          '1人暮らしは手取りの23-32%、2人暮らしは合計手取りの22-30%を目安にしています。世帯人数が増えると生活費の効率が良くなるため、2人暮らしの方が少し抑えめの比率になっています。',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[700],
                                height: 1.6,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 免責事項
                  Text(
                    '※ この診断結果は一般的な傾向に基づく参考目安です。実際の家賃判断は、ご自身のライフスタイルや将来の計画も含めて慎重にご検討ください。',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // バナー広告
                  const BannerAdWidget(),
                  const SizedBox(height: 24),

                  // もう一度診断ボタン
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColor,
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'もう一度診断する',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
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

/// 家賃レンジカード
class _RentRangeCard extends StatelessWidget {
  const _RentRangeCard({
    required this.title,
    required this.amount,
    required this.color,
    required this.description,
    required this.formatter,
    this.isRecommended = false,
  });

  final String title;
  final double amount;
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              if (isRecommended) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'おすすめ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatter.format(amount),
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '円',
                  style: TextStyle(
                    fontSize: 18,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
        ],
      ),
    );
  }
}
