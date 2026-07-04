/// 地域コスト区分
enum RegionalCost {
  low('low', '地方・郊外'),
  medium('medium', '標準'),
  high('high', '都市部・高コスト');

  const RegionalCost(this.id, this.displayName);
  final String id;
  final String displayName;
}

/// 貯蓄優先度
enum SavingsPriority {
  low('low', '最低限'),
  medium('medium', '標準'),
  high('high', 'しっかり貯める');

  const SavingsPriority(this.id, this.displayName);
  final String id;
  final String displayName;
}

/// 外食頻度
enum DiningOutFrequency {
  low('low', '少なめ'),
  medium('medium', '標準'),
  high('high', '多め');

  const DiningOutFrequency(this.id, this.displayName);
  final String id;
  final String displayName;
}

/// 診断タイプ
enum DiagnosisType {
  rent('rent', '家賃診断'),
  mortgage('mortgage', '住宅ローン診断'),
  livingCost('living_cost', '生活費診断');

  const DiagnosisType(this.id, this.displayName);
  final String id;
  final String displayName;
}
