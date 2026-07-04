import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kurashi_yohaku_shindan/features/rent_diagnosis/presentation/pages/result_page.dart';
import 'package:kurashi_yohaku_shindan/features/rent_diagnosis/presentation/providers/rent_diagnosis_provider.dart';
import 'package:intl/intl.dart';

/// 入力画面
class RentInputPage extends ConsumerStatefulWidget {
  const RentInputPage({super.key});

  @override
  ConsumerState<RentInputPage> createState() => _RentInputPageState();
}

class _RentInputPageState extends ConsumerState<RentInputPage> {
  final _formKey = GlobalKey<FormState>();
  final _incomeController = TextEditingController();
  int _selectedHouseholdSize = 1;

  @override
  void dispose() {
    _incomeController.dispose();
    super.dispose();
  }

  void _onDiagnose() {
    if (_formKey.currentState!.validate()) {
      final incomeInManYen = double.parse(_incomeController.text.replaceAll(',', ''));
      final income = incomeInManYen * 10000; // 万円を円に変換
      ref.read(rentDiagnosisInputProvider.notifier).updateMonthlyIncome(income);
      ref
          .read(rentDiagnosisInputProvider.notifier)
          .updateHouseholdSize(_selectedHouseholdSize);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const RentResultPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('家賃診断'),
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
                            'かんたん2ステップ',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '月の手取りと世帯人数を入力してください',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
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
                const SizedBox(height: 32),

                // 月手取り入力
                Text(
                  _selectedHouseholdSize == 1
                      ? '1. 月の手取り（万円）'
                      : '1. 世帯の合計手取り（万円）',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  _selectedHouseholdSize == 1
                      ? 'あなたの月の手取り額を万円単位で入力してください'
                      : '2人の手取りを合計した金額を万円単位で入力してください',
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
                    hintText: _selectedHouseholdSize == 1
                        ? '例: 25'
                        : '例: 45（2人の合計）',
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
                      return '月の手取りを入力してください';
                    }
                    final income = double.tryParse(value.replaceAll(',', ''));
                    if (income == null || income <= 0) {
                      return '正しい金額を入力してください';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // 世帯人数選択
                Text(
                  '2. 世帯人数',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _HouseholdSizeCard(
                        size: 1,
                        label: '1人暮らし',
                        isSelected: _selectedHouseholdSize == 1,
                        onTap: () {
                          setState(() {
                            _selectedHouseholdSize = 1;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _HouseholdSizeCard(
                        size: 2,
                        label: '2人暮らし',
                        isSelected: _selectedHouseholdSize == 2,
                        onTap: () {
                          setState(() {
                            _selectedHouseholdSize = 2;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 世帯人数の説明
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    key: ValueKey(_selectedHouseholdSize),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.blue[200]!,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: Colors.blue[700],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _selectedHouseholdSize == 1
                                ? '手取りの23-32%を家賃の目安として計算します。\n\n例: 手取り25万円の場合、適正家賃は約5.8〜8万円です。家賃以外に生活費・貯蓄・余裕資金が必要になるため、この範囲が無理なく続けやすい水準です。'
                                : '合計手取りの22-30%を家賃の目安として計算します。\n\n'
                                    '例: 合計手取り45万円の場合、適正家賃は約9.9〜13.5万円です。2人暮らしは生活費が効率的になるため、1人暮らしより少し抑えめの比率になっています。',
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
                      backgroundColor: Theme.of(context).primaryColor,
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

/// 世帯人数選択カード
class _HouseholdSizeCard extends StatelessWidget {
  const _HouseholdSizeCard({
    required this.size,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final int size;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Text(
              '$size人',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.white : Colors.grey[700],
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
