// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rent_diagnosis_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RentDiagnosisInput _$RentDiagnosisInputFromJson(Map<String, dynamic> json) {
  return _RentDiagnosisInput.fromJson(json);
}

/// @nodoc
mixin _$RentDiagnosisInput {
  HouseholdInfo get householdInfo => throw _privateConstructorUsedError;

  /// Serializes this RentDiagnosisInput to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RentDiagnosisInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RentDiagnosisInputCopyWith<RentDiagnosisInput> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RentDiagnosisInputCopyWith<$Res> {
  factory $RentDiagnosisInputCopyWith(
          RentDiagnosisInput value, $Res Function(RentDiagnosisInput) then) =
      _$RentDiagnosisInputCopyWithImpl<$Res, RentDiagnosisInput>;
  @useResult
  $Res call({HouseholdInfo householdInfo});

  $HouseholdInfoCopyWith<$Res> get householdInfo;
}

/// @nodoc
class _$RentDiagnosisInputCopyWithImpl<$Res, $Val extends RentDiagnosisInput>
    implements $RentDiagnosisInputCopyWith<$Res> {
  _$RentDiagnosisInputCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RentDiagnosisInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? householdInfo = null,
  }) {
    return _then(_value.copyWith(
      householdInfo: null == householdInfo
          ? _value.householdInfo
          : householdInfo // ignore: cast_nullable_to_non_nullable
              as HouseholdInfo,
    ) as $Val);
  }

  /// Create a copy of RentDiagnosisInput
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
abstract class _$$RentDiagnosisInputImplCopyWith<$Res>
    implements $RentDiagnosisInputCopyWith<$Res> {
  factory _$$RentDiagnosisInputImplCopyWith(_$RentDiagnosisInputImpl value,
          $Res Function(_$RentDiagnosisInputImpl) then) =
      __$$RentDiagnosisInputImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({HouseholdInfo householdInfo});

  @override
  $HouseholdInfoCopyWith<$Res> get householdInfo;
}

/// @nodoc
class __$$RentDiagnosisInputImplCopyWithImpl<$Res>
    extends _$RentDiagnosisInputCopyWithImpl<$Res, _$RentDiagnosisInputImpl>
    implements _$$RentDiagnosisInputImplCopyWith<$Res> {
  __$$RentDiagnosisInputImplCopyWithImpl(_$RentDiagnosisInputImpl _value,
      $Res Function(_$RentDiagnosisInputImpl) _then)
      : super(_value, _then);

  /// Create a copy of RentDiagnosisInput
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? householdInfo = null,
  }) {
    return _then(_$RentDiagnosisInputImpl(
      householdInfo: null == householdInfo
          ? _value.householdInfo
          : householdInfo // ignore: cast_nullable_to_non_nullable
              as HouseholdInfo,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RentDiagnosisInputImpl implements _RentDiagnosisInput {
  const _$RentDiagnosisInputImpl({required this.householdInfo});

  factory _$RentDiagnosisInputImpl.fromJson(Map<String, dynamic> json) =>
      _$$RentDiagnosisInputImplFromJson(json);

  @override
  final HouseholdInfo householdInfo;

  @override
  String toString() {
    return 'RentDiagnosisInput(householdInfo: $householdInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RentDiagnosisInputImpl &&
            (identical(other.householdInfo, householdInfo) ||
                other.householdInfo == householdInfo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, householdInfo);

  /// Create a copy of RentDiagnosisInput
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RentDiagnosisInputImplCopyWith<_$RentDiagnosisInputImpl> get copyWith =>
      __$$RentDiagnosisInputImplCopyWithImpl<_$RentDiagnosisInputImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RentDiagnosisInputImplToJson(
      this,
    );
  }
}

abstract class _RentDiagnosisInput implements RentDiagnosisInput {
  const factory _RentDiagnosisInput(
      {required final HouseholdInfo householdInfo}) = _$RentDiagnosisInputImpl;

  factory _RentDiagnosisInput.fromJson(Map<String, dynamic> json) =
      _$RentDiagnosisInputImpl.fromJson;

  @override
  HouseholdInfo get householdInfo;

  /// Create a copy of RentDiagnosisInput
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RentDiagnosisInputImplCopyWith<_$RentDiagnosisInputImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
