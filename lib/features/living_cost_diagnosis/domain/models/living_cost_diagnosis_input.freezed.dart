// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'living_cost_diagnosis_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LivingCostDiagnosisInput _$LivingCostDiagnosisInputFromJson(
    Map<String, dynamic> json) {
  return _LivingCostDiagnosisInput.fromJson(json);
}

/// @nodoc
mixin _$LivingCostDiagnosisInput {
  HouseholdInfo get householdInfo => throw _privateConstructorUsedError;
  double get housingCost => throw _privateConstructorUsedError;
  DiningOutFrequency get diningOutFrequency =>
      throw _privateConstructorUsedError;

  /// Serializes this LivingCostDiagnosisInput to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LivingCostDiagnosisInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LivingCostDiagnosisInputCopyWith<LivingCostDiagnosisInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LivingCostDiagnosisInputCopyWith<$Res> {
  factory $LivingCostDiagnosisInputCopyWith(LivingCostDiagnosisInput value,
          $Res Function(LivingCostDiagnosisInput) then) =
      _$LivingCostDiagnosisInputCopyWithImpl<$Res, LivingCostDiagnosisInput>;
  @useResult
  $Res call(
      {HouseholdInfo householdInfo,
      double housingCost,
      DiningOutFrequency diningOutFrequency});

  $HouseholdInfoCopyWith<$Res> get householdInfo;
}

/// @nodoc
class _$LivingCostDiagnosisInputCopyWithImpl<$Res,
        $Val extends LivingCostDiagnosisInput>
    implements $LivingCostDiagnosisInputCopyWith<$Res> {
  _$LivingCostDiagnosisInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LivingCostDiagnosisInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? householdInfo = null,
    Object? housingCost = null,
    Object? diningOutFrequency = null,
  }) {
    return _then(_value.copyWith(
      householdInfo: null == householdInfo
          ? _value.householdInfo
          : householdInfo // ignore: cast_nullable_to_non_nullable
              as HouseholdInfo,
      housingCost: null == housingCost
          ? _value.housingCost
          : housingCost // ignore: cast_nullable_to_non_nullable
              as double,
      diningOutFrequency: null == diningOutFrequency
          ? _value.diningOutFrequency
          : diningOutFrequency // ignore: cast_nullable_to_non_nullable
              as DiningOutFrequency,
    ) as $Val);
  }

  /// Create a copy of LivingCostDiagnosisInput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HouseholdInfoCopyWith<$Res> get householdInfo {
    return $HouseholdInfoCopyWith<$Res>(_value.householdInfo, (value) {
      return _then(_value.copyWith(householdInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LivingCostDiagnosisInputImplCopyWith<$Res>
    implements $LivingCostDiagnosisInputCopyWith<$Res> {
  factory _$$LivingCostDiagnosisInputImplCopyWith(
          _$LivingCostDiagnosisInputImpl value,
          $Res Function(_$LivingCostDiagnosisInputImpl) then) =
      __$$LivingCostDiagnosisInputImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {HouseholdInfo householdInfo,
      double housingCost,
      DiningOutFrequency diningOutFrequency});

  @override
  $HouseholdInfoCopyWith<$Res> get householdInfo;
}

/// @nodoc
class __$$LivingCostDiagnosisInputImplCopyWithImpl<$Res>
    extends _$LivingCostDiagnosisInputCopyWithImpl<$Res,
        _$LivingCostDiagnosisInputImpl>
    implements _$$LivingCostDiagnosisInputImplCopyWith<$Res> {
  __$$LivingCostDiagnosisInputImplCopyWithImpl(
      _$LivingCostDiagnosisInputImpl _value,
      $Res Function(_$LivingCostDiagnosisInputImpl) _then)
      : super(_value, _then);

  /// Create a copy of LivingCostDiagnosisInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? householdInfo = null,
    Object? housingCost = null,
    Object? diningOutFrequency = null,
  }) {
    return _then(_$LivingCostDiagnosisInputImpl(
      householdInfo: null == householdInfo
          ? _value.householdInfo
          : householdInfo // ignore: cast_nullable_to_non_nullable
              as HouseholdInfo,
      housingCost: null == housingCost
          ? _value.housingCost
          : housingCost // ignore: cast_nullable_to_non_nullable
              as double,
      diningOutFrequency: null == diningOutFrequency
          ? _value.diningOutFrequency
          : diningOutFrequency // ignore: cast_nullable_to_non_nullable
              as DiningOutFrequency,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LivingCostDiagnosisInputImpl implements _LivingCostDiagnosisInput {
  const _$LivingCostDiagnosisInputImpl(
      {required this.householdInfo,
      this.housingCost = 0,
      this.diningOutFrequency = DiningOutFrequency.medium});

  factory _$LivingCostDiagnosisInputImpl.fromJson(Map<String, dynamic> json) =>
      _$$LivingCostDiagnosisInputImplFromJson(json);

  @override
  final HouseholdInfo householdInfo;
  @override
  @JsonKey()
  final double housingCost;
  @override
  @JsonKey()
  final DiningOutFrequency diningOutFrequency;

  @override
  String toString() {
    return 'LivingCostDiagnosisInput(householdInfo: $householdInfo, housingCost: $housingCost, diningOutFrequency: $diningOutFrequency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LivingCostDiagnosisInputImpl &&
            (identical(other.householdInfo, householdInfo) ||
                other.householdInfo == householdInfo) &&
            (identical(other.housingCost, housingCost) ||
                other.housingCost == housingCost) &&
            (identical(other.diningOutFrequency, diningOutFrequency) ||
                other.diningOutFrequency == diningOutFrequency));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, householdInfo, housingCost, diningOutFrequency);

  /// Create a copy of LivingCostDiagnosisInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LivingCostDiagnosisInputImplCopyWith<_$LivingCostDiagnosisInputImpl>
      get copyWith => __$$LivingCostDiagnosisInputImplCopyWithImpl<
          _$LivingCostDiagnosisInputImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LivingCostDiagnosisInputImplToJson(
      this,
    );
  }
}

abstract class _LivingCostDiagnosisInput implements LivingCostDiagnosisInput {
  const factory _LivingCostDiagnosisInput(
          {required final HouseholdInfo householdInfo,
          final double housingCost,
          final DiningOutFrequency diningOutFrequency}) =
      _$LivingCostDiagnosisInputImpl;

  factory _LivingCostDiagnosisInput.fromJson(Map<String, dynamic> json) =
      _$LivingCostDiagnosisInputImpl.fromJson;

  @override
  HouseholdInfo get householdInfo;
  @override
  double get housingCost;
  @override
  DiningOutFrequency get diningOutFrequency;

  /// Create a copy of LivingCostDiagnosisInput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LivingCostDiagnosisInputImplCopyWith<_$LivingCostDiagnosisInputImpl>
      get copyWith => throw _privateConstructorUsedError;
}
