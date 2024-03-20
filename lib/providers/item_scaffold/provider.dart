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

import 'package:myorderapp_square/myorderapp_square.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../apis/provider.dart';
import '../logger/provider.dart';
import 'state.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class ItemScaffold extends _$ItemScaffold {
  @override
  ItemScaffoldState? build() {
    return null;
  }

  setNote({String? note}) {
    state = state?.copyWith(note: note);
  }

  setQuantity({required int quantity}) {
    state = state?.copyWith(quantity: quantity);
  }

  setSelectedVariation({required VariationEntity selectedVariation}) {
    state = state?.copyWith(selectedVariation: selectedVariation);
  }

  setSelectedModifierInItemModifierList({
    required ItemModifierListEntity inItemModifierList,
    required ModifierEntity modifier,
    required bool selected,
  }) {
    final theModifiers = state?.itemModifierListsToSelectedModifiers ?? {};
    theModifiers[inItemModifierList]?[modifier] = selected;
    state = state?.copyWith(itemModifierListsToSelectedModifiers: theModifiers);
  }

  setSparseItem({required ItemEntity sparseItem}) {
    state = ItemScaffoldState(
      item: sparseItem,
      selectedVariation: sparseItem.variations?[0],
      itemModifierListsToSelectedModifiers:
          initialItemModifierListToSelectedModifiersMap(forItem: sparseItem),
    );
  }

  getAndSetOrThrow({
    required String itemId,
    String? locationId,
    String? xCustomLang,
  }) async {
    final api = ref.read(catalogsApiProvider);
    ItemEntity? resultItem;
    try {
      resultItem = (await api.getItem(
        id: itemId,
        locationId: locationId,
        xCustomLang: xCustomLang,
      ))
          .data;
    } catch (e) {
      ref.read(loggerProvider).e("", error: e);
      rethrow;
    }

    if (resultItem != null) {
      state = ItemScaffoldState(
        item: resultItem,
        selectedVariation: resultItem.variations?.first,
        fetched: true,
        itemModifierListsToSelectedModifiers:
            initialItemModifierListToSelectedModifiersMap(forItem: resultItem),
      );
    }
  }

  Map<ItemModifierListEntity, Map<ModifierEntity, bool>>
      initialItemModifierListToSelectedModifiersMap({
    required ItemEntity forItem,
  }) {
    final Map<ItemModifierListEntity, Map<ModifierEntity, bool>>
        newItemModifierListToSelectedModifiersMap = {};

    forItem.itemModifierLists?.forEach(
      (itemModifierList) {
        Map<ModifierEntity, bool> modifierMap = {};
        itemModifierList.modifierList?.modifiers?.forEach((modifier) {
          modifierMap[modifier] =
              itemModifierList.onByDefaultModifierIds?.contains(modifier.id) ??
                  false;
        });
        newItemModifierListToSelectedModifiersMap[itemModifierList] =
            modifierMap;
      },
    );
    return newItemModifierListToSelectedModifiersMap;
  }
}
