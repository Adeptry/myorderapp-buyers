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

import 'package:flutter/material.dart';
import 'package:myorderapp_square/myorderapp_square.dart';

import '../../extensions/build_context_extensions.dart';
import 'modifier_radio_menu.dart';

class ItemModifierListMenu extends StatelessWidget {
  final ItemModifierListEntity itemModifierList;
  final Map<ModifierEntity, bool> modifierToSelectedMap;
  final Function(ModifierEntity, bool) onModifierSelectedChanged;
  final String currencyCode;

  const ItemModifierListMenu({
    required this.itemModifierList,
    required this.modifierToSelectedMap,
    required this.onModifierSelectedChanged,
    required this.currencyCode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;
    final l10n = context.l10n;

    final modifierList = itemModifierList.modifierList;

    final minSelectedModifiers =
        itemModifierList.minSelectedModifiers?.toInt() ?? -1;
    final maxSelectedModifiers =
        itemModifierList.maxSelectedModifiers?.toInt() ?? -1;

    final unboundMinimum =
        minSelectedModifiers == -1 || minSelectedModifiers == 0;
    final unboundMaximum = maxSelectedModifiers == -1;

    String trailingString = "";

    if (unboundMinimum && unboundMaximum) {
      trailingString = l10n.optional;
    } else if (unboundMaximum || minSelectedModifiers == maxSelectedModifiers) {
      trailingString = "${l10n.required} (${l10n.min(minSelectedModifiers)})";
    } else if (unboundMinimum) {
      trailingString = "${l10n.optional} (${l10n.max(maxSelectedModifiers)})";
    } else {
      trailingString =
          "${l10n.required} (${l10n.minMax(maxSelectedModifiers, minSelectedModifiers)})";
    }

    return Column(
      children: [
        ListTile(
          title: Text(
            modifierList?.name ?? "",
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            trailingString,
            style: !unboundMinimum
                ? context.labelSmallTextStyle?.copyWith(
                    color: theme.colorScheme.error,
                  )
                : null,
          ),
        ),
        ModifierRadioMenu(
          modifierToSelectedMap: modifierToSelectedMap,
          minSelectedModifiers: minSelectedModifiers,
          maxSelectedModifiers: maxSelectedModifiers,
          selectionType: modifierList?.selectionType ?? MoaSelectionType.SINGLE,
          onModifierSelectedChanged: onModifierSelectedChanged,
          currencyCode: currencyCode,
        ),
      ],
    );
  }
}
