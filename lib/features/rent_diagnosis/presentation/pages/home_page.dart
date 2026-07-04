import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kurashi_yohaku_shindan/features/rent_diagnosis/presentation/pages/input_page.dart';
import 'package:kurashi_yohaku_shindan/features/mortgage_diagnosis/presentation/pages/mortgage_input_page.dart';
import 'package:kurashi_yohaku_shindan/shared/widgets/banner_ad_widget.dart';

/// ホーム画面
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                // マスコットキャラクター
                Image.asset(
                  'assets/images/mascot_home.png',
                  height: 180,
                ),
                const SizedBox(height: 8),
                // アプリタイトル
                Text(
                  '住まい診断アプリ',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'くらし余白チェッカー',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor.withValues(alpha: 0.7),
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  '適正家賃・借入可能額を無料診断\n1人暮らし・同棲・結婚に対応',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[700],
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                // 診断カード
                _DiagnosisCard(
                  title: '家賃診断',
                  description: '手取りから適正家賃を診断\n1人暮らし・2人暮らし対応',
                  icon: Icons.house_outlined,
                  color: const Color(0xFF4A90E2),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RentInputPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _DiagnosisCard(
                  title: '住宅ローン診断',
                  description: '借入可能額を計算\n戸建・マンション対応',
                  icon: Icons.account_balance_outlined,
                  color: const Color(0xFF9B59B6),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MortgageInputPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),
                // 免責事項
                Text(
                  '※ この診断は参考目安です。\n実際の家賃判断は、ご自身の状況に応じて慎重にご検討ください。',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                // バナー広告
                const BannerAdWidget(),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 診断カード
class _DiagnosisCard extends StatelessWidget {
  const _DiagnosisCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 32,
                color: color,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: color,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
