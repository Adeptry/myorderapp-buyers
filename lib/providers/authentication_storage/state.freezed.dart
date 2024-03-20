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

AuthenticationStorageState _$AuthenticationStorageStateFromJson(
    Map<String, dynamic> json) {
  return _AuthenticationStorageState.fromJson(json);
}

/// @nodoc
mixin _$AuthenticationStorageState {
  String? get accessToken => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthenticationStorageStateCopyWith<AuthenticationStorageState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationStorageStateCopyWith<$Res> {
  factory $AuthenticationStorageStateCopyWith(AuthenticationStorageState value,
          $Res Function(AuthenticationStorageState) then) =
      _$AuthenticationStorageStateCopyWithImpl<$Res,
          AuthenticationStorageState>;
  @useResult
  $Res call({String? accessToken, String? refreshToken, DateTime? expiresAt});
}

/// @nodoc
class _$AuthenticationStorageStateCopyWithImpl<$Res,
        $Val extends AuthenticationStorageState>
    implements $AuthenticationStorageStateCopyWith<$Res> {
  _$AuthenticationStorageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_value.copyWith(
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthenticationStorageStateImplCopyWith<$Res>
    implements $AuthenticationStorageStateCopyWith<$Res> {
  factory _$$AuthenticationStorageStateImplCopyWith(
          _$AuthenticationStorageStateImpl value,
          $Res Function(_$AuthenticationStorageStateImpl) then) =
      __$$AuthenticationStorageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? accessToken, String? refreshToken, DateTime? expiresAt});
}

/// @nodoc
class __$$AuthenticationStorageStateImplCopyWithImpl<$Res>
    extends _$AuthenticationStorageStateCopyWithImpl<$Res,
        _$AuthenticationStorageStateImpl>
    implements _$$AuthenticationStorageStateImplCopyWith<$Res> {
  __$$AuthenticationStorageStateImplCopyWithImpl(
      _$AuthenticationStorageStateImpl _value,
      $Res Function(_$AuthenticationStorageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_$AuthenticationStorageStateImpl(
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthenticationStorageStateImpl extends _AuthenticationStorageState
    with DiagnosticableTreeMixin {
  const _$AuthenticationStorageStateImpl(
      {this.accessToken, this.refreshToken, this.expiresAt})
      : super._();

  factory _$AuthenticationStorageStateImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AuthenticationStorageStateImplFromJson(json);

  @override
  final String? accessToken;
  @override
  final String? refreshToken;
  @override
  final DateTime? expiresAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthenticationStorageState(accessToken: $accessToken, refreshToken: $refreshToken, expiresAt: $expiresAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthenticationStorageState'))
      ..add(DiagnosticsProperty('accessToken', accessToken))
      ..add(DiagnosticsProperty('refreshToken', refreshToken))
      ..add(DiagnosticsProperty('expiresAt', expiresAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationStorageStateImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, accessToken, refreshToken, expiresAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationStorageStateImplCopyWith<_$AuthenticationStorageStateImpl>
      get copyWith => __$$AuthenticationStorageStateImplCopyWithImpl<
          _$AuthenticationStorageStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthenticationStorageStateImplToJson(
      this,
    );
  }
}

abstract class _AuthenticationStorageState extends AuthenticationStorageState {
  const factory _AuthenticationStorageState(
      {final String? accessToken,
      final String? refreshToken,
      final DateTime? expiresAt}) = _$AuthenticationStorageStateImpl;
  const _AuthenticationStorageState._() : super._();

  factory _AuthenticationStorageState.fromJson(Map<String, dynamic> json) =
      _$AuthenticationStorageStateImpl.fromJson;

  @override
  String? get accessToken;
  @override
  String? get refreshToken;
  @override
  DateTime? get expiresAt;
  @override
  @JsonKey(ignore: true)
  _$$AuthenticationStorageStateImplCopyWith<_$AuthenticationStorageStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
