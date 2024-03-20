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

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myorderapp_square/myorderapp_square.dart';

import '../../../extensions/intl/num_intl_extensions.dart';

part 'state.freezed.dart';

@freezed
class ItemScaffoldState with _$ItemScaffoldState {
  const ItemScaffoldState._();

  const factory ItemScaffoldState({
    required ItemEntity item,
    VariationEntity? selectedVariation,
    String? note,
    @Default(1) int quantity,
    @Default(false) bool fetched,
    Map<ItemModifierListEntity, Map<ModifierEntity, bool>>?
        itemModifierListsToSelectedModifiers,
  }) = _ItemScaffoldState;

  num get totalPriceAmount {
    num amount = 0;
    amount += selectedVariation?.priceMoneyAmount ?? 0;
    for (final modifier in selectedModifiers) {
      amount += modifier.priceMoneyAmount ?? 0;
    }
    return amount * quantity;
  }

  String formattedPriceAmount(String? currencyCode) {
    return ((totalPriceAmount)).formatSimpleCurrency(currencyCode) ?? "";
  }

  OrdersVariationLineItemInput get variationLineItemInput {
    return OrdersVariationLineItemInput(
      id: selectedVariation!.id!,
      quantity: quantity,
      modifierIds: selectedModifiers.map((value) => value.id!).toList(),
      note: note,
    );
  }

  OrderPostCurrentBody get orderPostCurrentBody {
    return OrderPostCurrentBody(variations: [variationLineItemInput]);
  }

  List<ModifierEntity> get selectedModifiers {
    final selectedModifiers = <ModifierEntity>[];
    itemModifierListsToSelectedModifiers?.forEach((key, value) {
      value.forEach((key, value) {
        if (value) {
          selectedModifiers.add(key);
        }
      });
    });
    return selectedModifiers;
  }

  List<ItemModifierListEntity> get unsatisfiedMinimumItemModifierLists {
    List<ItemModifierListEntity> unsatisfiedLists = [];

    for (final itemModifierList
        in (itemModifierListsToSelectedModifiers?.keys ??
            const Iterable.empty())) {
      num minSelected = itemModifierList.minSelectedModifiers ?? -1;
      num actualSelected = 0;

      final selectedModifiersMap =
          itemModifierListsToSelectedModifiers?[itemModifierList];
      selectedModifiersMap?.forEach((modifier, isSelected) {
        if (isSelected) {
          actualSelected++;
        }
      });

      if (minSelected != -1 && actualSelected < minSelected) {
        unsatisfiedLists.add(itemModifierList);
      }
    }

    return unsatisfiedLists;
  }
}
