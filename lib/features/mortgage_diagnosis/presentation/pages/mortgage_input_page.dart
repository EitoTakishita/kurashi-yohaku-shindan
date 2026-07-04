import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kurashi_yohaku_shindan/features/mortgage_diagnosis/presentation/pages/mortgage_result_page.dart';
import 'package:kurashi_yohaku_shindan/features/mortgage_diagnosis/presentation/providers/mortgage_diagnosis_provider.dart';
import 'package:intl/intl.dart';

/// 住宅ローン診断入力画面
class MortgageInputPage extends ConsumerStatefulWidget {
  const MortgageInputPage({super.key});

  @override
  ConsumerState<MortgageInputPage> createState() => _MortgageInputPageState();
}

class _MortgageInputPageState extends ConsumerState<MortgageInputPage> {
  final _formKey = GlobalKey<FormState>();
  final _incomeController = TextEditingController();
  final _downPaymentController = TextEditingController();
  final _interestRateController = TextEditingController();
  int _selectedLoanYears = 35;
  String _selectedPropertyType = 'house';

  @override
  void dispose() {
    _incomeController.dispose();
    _downPaymentController.dispose();
    _interestRateController.dispose();
    super.dispose();
  }

  void _onDiagnose() {
    if (_formKey.currentState!.validate()) {
      final yearlyIncomeInManYen = double.parse(_incomeController.text.replaceAll(',', ''));
      final yearlyIncome = yearlyIncomeInManYen * 10000; // 万円を円に変換
      final monthlyIncome = yearlyIncome / 12; // 年収を月収に変換

      final downPaymentInManYen = double.parse(_downPaymentController.text.replaceAll(',', ''));
      final downPayment = downPaymentInManYen * 10000; // 万円を円に変換

      // 金利：入力されていればその値、なければデフォルト0.6%
      final interestRate = _interestRateController.text.isEmpty
          ? 0.6
          : double.parse(_interestRateController.text);

      ref.read(mortgageDiagnosisInputProvider.notifier).updateMonthlyIncome(monthlyIncome);
      ref.read(mortgageDiagnosisInputProvider.notifier).updateDownPayment(downPayment);
      ref.read(mortgageDiagnosisInputProvider.notifier).updateLoanYears(_selectedLoanYears);
      ref.read(mortgageDiagnosisInputProvider.notifier).updatePropertyType(_selectedPropertyType);
      ref.read(mortgageDiagnosisInputProvider.notifier).updateInterestRate(interestRate);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MortgageResultPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('住宅ローン診断'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'かんたん4ステップ',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '世帯年収、頭金、返済期間、物件タイプを入力してください',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.grey[700],
                                ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/images/mascot_input.png',
                      height: 96,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // 金利入力（任意・折りたたみ式）
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue[200]!, width: 1),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                      leading: Icon(Icons.info_outline, size: 20, color: Colors.blue[700]),
                      title: Text(
                        '金利（デフォルト: 0.6%）',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      subtitle: Text(
                        '2025年の平均的な変動金利で計算します',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          '金融機関から提示された金利がある場合は入力してください。空欄の場合は0.6%で計算されます。',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _interestRateController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            hintText: '例: 0.6',
                            suffixText: '%',
                            labelText: '年利（任意）',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return null; // 任意入力なのでOK
                            }
                            final rate = double.tryParse(value);
                            if (rate == null || rate < 0 || rate > 10) {
                              return '0〜10の範囲で入力してください';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 世帯年収入力
                Text(
                  '1. 世帯の年収（万円）',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  '世帯全員の年収を合計した金額を万円単位で入力してください',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _incomeController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    _ThousandsSeparatorInputFormatter(),
                  ],
                  decoration: InputDecoration(
                    hintText: '例: 540',
                    suffixText: '万円',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  style: const TextStyle(fontSize: 20),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '年収を入力してください';
                    }
                    final income = double.tryParse(value.replaceAll(',', ''));
                    if (income == null || income <= 0) {
                      return '正しい金額を入力してください';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // 頭金入力
                Text(
                  '2. 頭金（万円）',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  '用意できる頭金の金額を万円単位で入力（0でも可）',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _downPaymentController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    _ThousandsSeparatorInputFormatter(),
                  ],
                  decoration: InputDecoration(
                    hintText: '例: 100',
                    suffixText: '万円',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  style: const TextStyle(fontSize: 20),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '頭金を入力してください（0の場合は0と入力）';
                    }
                    final downPayment = double.tryParse(value.replaceAll(',', ''));
                    if (downPayment == null || downPayment < 0) {
                      return '正しい金額を入力してください';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // 返済期間選択
                Text(
                  '3. 返済期間',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _YearCard(
                        years: 30,
                        isSelected: _selectedLoanYears == 30,
                        onTap: () {
                          setState(() {
                            _selectedLoanYears = 30;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _YearCard(
                        years: 35,
                        isSelected: _selectedLoanYears == 35,
                        onTap: () {
                          setState(() {
                            _selectedLoanYears = 35;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _YearCard(
                        years: 40,
                        isSelected: _selectedLoanYears == 40,
                        onTap: () {
                          setState(() {
                            _selectedLoanYears = 40;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // 物件タイプ選択
                Text(
                  '4. 物件タイプ',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _PropertyTypeCard(
                        type: 'house',
                        label: '戸建て',
                        icon: Icons.home,
                        isSelected: _selectedPropertyType == 'house',
                        onTap: () {
                          setState(() {
                            _selectedPropertyType = 'house';
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _PropertyTypeCard(
                        type: 'apartment',
                        label: 'マンション',
                        icon: Icons.apartment,
                        isSelected: _selectedPropertyType == 'apartment',
                        onTap: () {
                          setState(() {
                            _selectedPropertyType = 'apartment';
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 物件タイプの説明
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    key: ValueKey(_selectedPropertyType),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.purple[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.purple[200]!,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: Colors.purple[700],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _selectedPropertyType == 'house'
                                ? '戸建ての場合、固定資産税や将来の修繕費用を考慮した診断になります。'
                                : 'マンションの場合、管理費・修繕積立金（月約2.5万円）と固定資産税を含めた総住居費で診断します。',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // 診断ボタン
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _onDiagnose,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9B59B6),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      '診断する',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 返済期間カード
class _YearCard extends StatelessWidget {
  const _YearCard({
    required this.years,
    required this.isSelected,
    required this.onTap,
  });

  final int years;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF9B59B6) : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF9B59B6) : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Text(
              '$years年',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 物件タイプカード
class _PropertyTypeCard extends StatelessWidget {
  const _PropertyTypeCard({
    required this.type,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String type;
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF9B59B6) : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF9B59B6) : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? Colors.white : Colors.grey[700],
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 千の位区切りのInputFormatter
class _ThousandsSeparatorInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat('#,###');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final value = int.tryParse(newValue.text.replaceAll(',', ''));
    if (value == null) {
      return oldValue;
    }

    final newText = _formatter.format(value);
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
