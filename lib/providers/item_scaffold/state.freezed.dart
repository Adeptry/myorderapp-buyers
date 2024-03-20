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
mixin _$ItemScaffoldState {
  ItemEntity get item => throw _privateConstructorUsedError;
  VariationEntity? get selectedVariation => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  bool get fetched => throw _privateConstructorUsedError;
  Map<ItemModifierListEntity, Map<ModifierEntity, bool>>?
      get itemModifierListsToSelectedModifiers =>
          throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ItemScaffoldStateCopyWith<ItemScaffoldState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemScaffoldStateCopyWith<$Res> {
  factory $ItemScaffoldStateCopyWith(
          ItemScaffoldState value, $Res Function(ItemScaffoldState) then) =
      _$ItemScaffoldStateCopyWithImpl<$Res, ItemScaffoldState>;
  @useResult
  $Res call(
      {ItemEntity item,
      VariationEntity? selectedVariation,
      String? note,
      int quantity,
      bool fetched,
      Map<ItemModifierListEntity, Map<ModifierEntity, bool>>?
          itemModifierListsToSelectedModifiers});
}

/// @nodoc
class _$ItemScaffoldStateCopyWithImpl<$Res, $Val extends ItemScaffoldState>
    implements $ItemScaffoldStateCopyWith<$Res> {
  _$ItemScaffoldStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
    Object? selectedVariation = freezed,
    Object? note = freezed,
    Object? quantity = null,
    Object? fetched = null,
    Object? itemModifierListsToSelectedModifiers = freezed,
  }) {
    return _then(_value.copyWith(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as ItemEntity,
      selectedVariation: freezed == selectedVariation
          ? _value.selectedVariation
          : selectedVariation // ignore: cast_nullable_to_non_nullable
              as VariationEntity?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      fetched: null == fetched
          ? _value.fetched
          : fetched // ignore: cast_nullable_to_non_nullable
              as bool,
      itemModifierListsToSelectedModifiers: freezed ==
              itemModifierListsToSelectedModifiers
          ? _value.itemModifierListsToSelectedModifiers
          : itemModifierListsToSelectedModifiers // ignore: cast_nullable_to_non_nullable
              as Map<ItemModifierListEntity, Map<ModifierEntity, bool>>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemScaffoldStateImplCopyWith<$Res>
    implements $ItemScaffoldStateCopyWith<$Res> {
  factory _$$ItemScaffoldStateImplCopyWith(_$ItemScaffoldStateImpl value,
          $Res Function(_$ItemScaffoldStateImpl) then) =
      __$$ItemScaffoldStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ItemEntity item,
      VariationEntity? selectedVariation,
      String? note,
      int quantity,
      bool fetched,
      Map<ItemModifierListEntity, Map<ModifierEntity, bool>>?
          itemModifierListsToSelectedModifiers});
}

/// @nodoc
class __$$ItemScaffoldStateImplCopyWithImpl<$Res>
    extends _$ItemScaffoldStateCopyWithImpl<$Res, _$ItemScaffoldStateImpl>
    implements _$$ItemScaffoldStateImplCopyWith<$Res> {
  __$$ItemScaffoldStateImplCopyWithImpl(_$ItemScaffoldStateImpl _value,
      $Res Function(_$ItemScaffoldStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
    Object? selectedVariation = freezed,
    Object? note = freezed,
    Object? quantity = null,
    Object? fetched = null,
    Object? itemModifierListsToSelectedModifiers = freezed,
  }) {
    return _then(_$ItemScaffoldStateImpl(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as ItemEntity,
      selectedVariation: freezed == selectedVariation
          ? _value.selectedVariation
          : selectedVariation // ignore: cast_nullable_to_non_nullable
              as VariationEntity?,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      fetched: null == fetched
          ? _value.fetched
          : fetched // ignore: cast_nullable_to_non_nullable
              as bool,
      itemModifierListsToSelectedModifiers: freezed ==
              itemModifierListsToSelectedModifiers
          ? _value._itemModifierListsToSelectedModifiers
          : itemModifierListsToSelectedModifiers // ignore: cast_nullable_to_non_nullable
              as Map<ItemModifierListEntity, Map<ModifierEntity, bool>>?,
    ));
  }
}

/// @nodoc

class _$ItemScaffoldStateImpl extends _ItemScaffoldState
    with DiagnosticableTreeMixin {
  const _$ItemScaffoldStateImpl(
      {required this.item,
      this.selectedVariation,
      this.note,
      this.quantity = 1,
      this.fetched = false,
      final Map<ItemModifierListEntity, Map<ModifierEntity, bool>>?
          itemModifierListsToSelectedModifiers})
      : _itemModifierListsToSelectedModifiers =
            itemModifierListsToSelectedModifiers,
        super._();

  @override
  final ItemEntity item;
  @override
  final VariationEntity? selectedVariation;
  @override
  final String? note;
  @override
  @JsonKey()
  final int quantity;
  @override
  @JsonKey()
  final bool fetched;
  final Map<ItemModifierListEntity, Map<ModifierEntity, bool>>?
      _itemModifierListsToSelectedModifiers;
  @override
  Map<ItemModifierListEntity, Map<ModifierEntity, bool>>?
      get itemModifierListsToSelectedModifiers {
    final value = _itemModifierListsToSelectedModifiers;
    if (value == null) return null;
    if (_itemModifierListsToSelectedModifiers is EqualUnmodifiableMapView)
      return _itemModifierListsToSelectedModifiers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ItemScaffoldState(item: $item, selectedVariation: $selectedVariation, note: $note, quantity: $quantity, fetched: $fetched, itemModifierListsToSelectedModifiers: $itemModifierListsToSelectedModifiers)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ItemScaffoldState'))
      ..add(DiagnosticsProperty('item', item))
      ..add(DiagnosticsProperty('selectedVariation', selectedVariation))
      ..add(DiagnosticsProperty('note', note))
      ..add(DiagnosticsProperty('quantity', quantity))
      ..add(DiagnosticsProperty('fetched', fetched))
      ..add(DiagnosticsProperty('itemModifierListsToSelectedModifiers',
          itemModifierListsToSelectedModifiers));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemScaffoldStateImpl &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.selectedVariation, selectedVariation) ||
                other.selectedVariation == selectedVariation) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.fetched, fetched) || other.fetched == fetched) &&
            const DeepCollectionEquality().equals(
                other._itemModifierListsToSelectedModifiers,
                _itemModifierListsToSelectedModifiers));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      item,
      selectedVariation,
      note,
      quantity,
      fetched,
      const DeepCollectionEquality()
          .hash(_itemModifierListsToSelectedModifiers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemScaffoldStateImplCopyWith<_$ItemScaffoldStateImpl> get copyWith =>
      __$$ItemScaffoldStateImplCopyWithImpl<_$ItemScaffoldStateImpl>(
          this, _$identity);
}

abstract class _ItemScaffoldState extends ItemScaffoldState {
  const factory _ItemScaffoldState(
      {required final ItemEntity item,
      final VariationEntity? selectedVariation,
      final String? note,
      final int quantity,
      final bool fetched,
      final Map<ItemModifierListEntity, Map<ModifierEntity, bool>>?
          itemModifierListsToSelectedModifiers}) = _$ItemScaffoldStateImpl;
  const _ItemScaffoldState._() : super._();

  @override
  ItemEntity get item;
  @override
  VariationEntity? get selectedVariation;
  @override
  String? get note;
  @override
  int get quantity;
  @override
  bool get fetched;
  @override
  Map<ItemModifierListEntity, Map<ModifierEntity, bool>>?
      get itemModifierListsToSelectedModifiers;
  @override
  @JsonKey(ignore: true)
  _$$ItemScaffoldStateImplCopyWith<_$ItemScaffoldStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
