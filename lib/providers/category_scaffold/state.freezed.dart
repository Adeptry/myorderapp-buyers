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
mixin _$CategoryScaffoldState {
  List<bool> get expanded => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CategoryScaffoldStateCopyWith<CategoryScaffoldState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryScaffoldStateCopyWith<$Res> {
  factory $CategoryScaffoldStateCopyWith(CategoryScaffoldState value,
          $Res Function(CategoryScaffoldState) then) =
      _$CategoryScaffoldStateCopyWithImpl<$Res, CategoryScaffoldState>;
  @useResult
  $Res call({List<bool> expanded});
}

/// @nodoc
class _$CategoryScaffoldStateCopyWithImpl<$Res,
        $Val extends CategoryScaffoldState>
    implements $CategoryScaffoldStateCopyWith<$Res> {
  _$CategoryScaffoldStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expanded = null,
  }) {
    return _then(_value.copyWith(
      expanded: null == expanded
          ? _value.expanded
          : expanded // ignore: cast_nullable_to_non_nullable
              as List<bool>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoryScaffoldStateImplCopyWith<$Res>
    implements $CategoryScaffoldStateCopyWith<$Res> {
  factory _$$CategoryScaffoldStateImplCopyWith(
          _$CategoryScaffoldStateImpl value,
          $Res Function(_$CategoryScaffoldStateImpl) then) =
      __$$CategoryScaffoldStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<bool> expanded});
}

/// @nodoc
class __$$CategoryScaffoldStateImplCopyWithImpl<$Res>
    extends _$CategoryScaffoldStateCopyWithImpl<$Res,
        _$CategoryScaffoldStateImpl>
    implements _$$CategoryScaffoldStateImplCopyWith<$Res> {
  __$$CategoryScaffoldStateImplCopyWithImpl(_$CategoryScaffoldStateImpl _value,
      $Res Function(_$CategoryScaffoldStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expanded = null,
  }) {
    return _then(_$CategoryScaffoldStateImpl(
      expanded: null == expanded
          ? _value._expanded
          : expanded // ignore: cast_nullable_to_non_nullable
              as List<bool>,
    ));
  }
}

/// @nodoc

class _$CategoryScaffoldStateImpl extends _CategoryScaffoldState
    with DiagnosticableTreeMixin {
  const _$CategoryScaffoldStateImpl({required final List<bool> expanded})
      : _expanded = expanded,
        super._();

  final List<bool> _expanded;
  @override
  List<bool> get expanded {
    if (_expanded is EqualUnmodifiableListView) return _expanded;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expanded);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CategoryScaffoldState(expanded: $expanded)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CategoryScaffoldState'))
      ..add(DiagnosticsProperty('expanded', expanded));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryScaffoldStateImpl &&
            const DeepCollectionEquality().equals(other._expanded, _expanded));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_expanded));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryScaffoldStateImplCopyWith<_$CategoryScaffoldStateImpl>
      get copyWith => __$$CategoryScaffoldStateImplCopyWithImpl<
          _$CategoryScaffoldStateImpl>(this, _$identity);
}

abstract class _CategoryScaffoldState extends CategoryScaffoldState {
  const factory _CategoryScaffoldState({required final List<bool> expanded}) =
      _$CategoryScaffoldStateImpl;
  const _CategoryScaffoldState._() : super._();

  @override
  List<bool> get expanded;
  @override
  @JsonKey(ignore: true)
  _$$CategoryScaffoldStateImplCopyWith<_$CategoryScaffoldStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
