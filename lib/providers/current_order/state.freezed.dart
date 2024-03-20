/*
    This code is part of the myorderapp-customers front-end.
    Copyright (C) 2024  Adeptry, LLC

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>
 */

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CurrentOrderState {
  OrderEntity? get order => throw _privateConstructorUsedError;
  int get tipMoneyAbsoluteAmount => throw _privateConstructorUsedError;
  int get tipMoneyPercentage => throw _privateConstructorUsedError;
  DateTime? get pickupDateTime => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  String? get idempotencyKey => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CurrentOrderStateCopyWith<CurrentOrderState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentOrderStateCopyWith<$Res> {
  factory $CurrentOrderStateCopyWith(
          CurrentOrderState value, $Res Function(CurrentOrderState) then) =
      _$CurrentOrderStateCopyWithImpl<$Res, CurrentOrderState>;
  @useResult
  $Res call(
      {OrderEntity? order,
      int tipMoneyAbsoluteAmount,
      int tipMoneyPercentage,
      DateTime? pickupDateTime,
      String? note,
      String? idempotencyKey});
}

/// @nodoc
class _$CurrentOrderStateCopyWithImpl<$Res, $Val extends CurrentOrderState>
    implements $CurrentOrderStateCopyWith<$Res> {
  _$CurrentOrderStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? order = freezed,
    Object? tipMoneyAbsoluteAmount = null,
    Object? tipMoneyPercentage = null,
    Object? pickupDateTime = freezed,
    Object? note = freezed,
    Object? idempotencyKey = freezed,
  }) {
    return _then(_value.copyWith(
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderEntity?,
      tipMoneyAbsoluteAmount: null == tipMoneyAbsoluteAmount
          ? _value.tipMoneyAbsoluteAmount
          : tipMoneyAbsoluteAmount // ignore: cast_nullable_to_non_nullable
              as int,
      tipMoneyPercentage: null == tipMoneyPercentage
          ? _value.tipMoneyPercentage
          : tipMoneyPercentage // ignore: cast_nullable_to_non_nullable
              as int,
      pickupDateTime: freezed == pickupDateTime
          ? _value.pickupDateTime
          : pickupDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      idempotencyKey: freezed == idempotencyKey
          ? _value.idempotencyKey
          : idempotencyKey // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckoutStateImplCopyWith<$Res>
    implements $CurrentOrderStateCopyWith<$Res> {
  factory _$$CheckoutStateImplCopyWith(
          _$CheckoutStateImpl value, $Res Function(_$CheckoutStateImpl) then) =
      __$$CheckoutStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {OrderEntity? order,
      int tipMoneyAbsoluteAmount,
      int tipMoneyPercentage,
      DateTime? pickupDateTime,
      String? note,
      String? idempotencyKey});
}

/// @nodoc
class __$$CheckoutStateImplCopyWithImpl<$Res>
    extends _$CurrentOrderStateCopyWithImpl<$Res, _$CheckoutStateImpl>
    implements _$$CheckoutStateImplCopyWith<$Res> {
  __$$CheckoutStateImplCopyWithImpl(
      _$CheckoutStateImpl _value, $Res Function(_$CheckoutStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? order = freezed,
    Object? tipMoneyAbsoluteAmount = null,
    Object? tipMoneyPercentage = null,
    Object? pickupDateTime = freezed,
    Object? note = freezed,
    Object? idempotencyKey = freezed,
  }) {
    return _then(_$CheckoutStateImpl(
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as OrderEntity?,
      tipMoneyAbsoluteAmount: null == tipMoneyAbsoluteAmount
          ? _value.tipMoneyAbsoluteAmount
          : tipMoneyAbsoluteAmount // ignore: cast_nullable_to_non_nullable
              as int,
      tipMoneyPercentage: null == tipMoneyPercentage
          ? _value.tipMoneyPercentage
          : tipMoneyPercentage // ignore: cast_nullable_to_non_nullable
              as int,
      pickupDateTime: freezed == pickupDateTime
          ? _value.pickupDateTime
          : pickupDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      idempotencyKey: freezed == idempotencyKey
          ? _value.idempotencyKey
          : idempotencyKey // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CheckoutStateImpl extends _CheckoutState with DiagnosticableTreeMixin {
  const _$CheckoutStateImpl(
      {this.order,
      this.tipMoneyAbsoluteAmount = 0,
      this.tipMoneyPercentage = 0,
      this.pickupDateTime,
      this.note,
      this.idempotencyKey})
      : super._();

  @override
  final OrderEntity? order;
  @override
  @JsonKey()
  final int tipMoneyAbsoluteAmount;
  @override
  @JsonKey()
  final int tipMoneyPercentage;
  @override
  final DateTime? pickupDateTime;
  @override
  final String? note;
  @override
  final String? idempotencyKey;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CurrentOrderState(order: $order, tipMoneyAbsoluteAmount: $tipMoneyAbsoluteAmount, tipMoneyPercentage: $tipMoneyPercentage, pickupDateTime: $pickupDateTime, note: $note, idempotencyKey: $idempotencyKey)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CurrentOrderState'))
      ..add(DiagnosticsProperty('order', order))
      ..add(
          DiagnosticsProperty('tipMoneyAbsoluteAmount', tipMoneyAbsoluteAmount))
      ..add(DiagnosticsProperty('tipMoneyPercentage', tipMoneyPercentage))
      ..add(DiagnosticsProperty('pickupDateTime', pickupDateTime))
      ..add(DiagnosticsProperty('note', note))
      ..add(DiagnosticsProperty('idempotencyKey', idempotencyKey));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckoutStateImpl &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.tipMoneyAbsoluteAmount, tipMoneyAbsoluteAmount) ||
                other.tipMoneyAbsoluteAmount == tipMoneyAbsoluteAmount) &&
            (identical(other.tipMoneyPercentage, tipMoneyPercentage) ||
                other.tipMoneyPercentage == tipMoneyPercentage) &&
            (identical(other.pickupDateTime, pickupDateTime) ||
                other.pickupDateTime == pickupDateTime) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.idempotencyKey, idempotencyKey) ||
                other.idempotencyKey == idempotencyKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, order, tipMoneyAbsoluteAmount,
      tipMoneyPercentage, pickupDateTime, note, idempotencyKey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckoutStateImplCopyWith<_$CheckoutStateImpl> get copyWith =>
      __$$CheckoutStateImplCopyWithImpl<_$CheckoutStateImpl>(this, _$identity);
}

abstract class _CheckoutState extends CurrentOrderState {
  const factory _CheckoutState(
      {final OrderEntity? order,
      final int tipMoneyAbsoluteAmount,
      final int tipMoneyPercentage,
      final DateTime? pickupDateTime,
      final String? note,
      final String? idempotencyKey}) = _$CheckoutStateImpl;
  const _CheckoutState._() : super._();

  @override
  OrderEntity? get order;
  @override
  int get tipMoneyAbsoluteAmount;
  @override
  int get tipMoneyPercentage;
  @override
  DateTime? get pickupDateTime;
  @override
  String? get note;
  @override
  String? get idempotencyKey;
  @override
  @JsonKey(ignore: true)
  _$$CheckoutStateImplCopyWith<_$CheckoutStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
