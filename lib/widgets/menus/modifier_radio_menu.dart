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

import '../../constants/widget_constants.dart';
import '../../extensions/myorderapp_square/modifier_entity_extensions.dart';

class ModifierRadioMenu extends StatelessWidget {
  final Map<ModifierEntity, bool> modifierToSelectedMap;
  final int minSelectedModifiers;
  final int maxSelectedModifiers;
  final MoaSelectionType? selectionType;
  final String currencyCode;

  final Function(ModifierEntity, bool) onModifierSelectedChanged;

  const ModifierRadioMenu({
    required this.modifierToSelectedMap,
    required this.minSelectedModifiers,
    required this.maxSelectedModifiers,
    required this.selectionType,
    required this.onModifierSelectedChanged,
    required this.currencyCode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (selectionType == MoaSelectionType.SINGLE) {
      if (modifierToSelectedMap.length <= WidgetConstants.radioThreshold) {
        return Column(
          children: modifierToSelectedMap.keys
              .map(
                (value) => RadioListTile<ModifierEntity>(
                  title: Text(value.name ?? ''),
                  secondary: Text(
                    value.formattedMoneyAmount(currencyCode),
                  ),
                  value: value,
                  groupValue: _firstSelected(),
                  toggleable: true,
                  onChanged: (ModifierEntity? onChangedValue) {
                    final currentlySelectedValue = _firstSelected();
                    if (onChangedValue != null) {
                      if (currentlySelectedValue != null) {
                        onModifierSelectedChanged(
                          currentlySelectedValue,
                          false,
                        );
                      }

                      onModifierSelectedChanged(onChangedValue, true);
                    } else if (currentlySelectedValue != null) {
                      onModifierSelectedChanged(currentlySelectedValue, false);
                    }
                  },
                ),
              )
              .toList(),
        );
      } else {
        return ListTile(
          title: DropdownButton<ModifierEntity>(
            isExpanded: true,
            value: _firstSelected(),
            onChanged: (ModifierEntity? onChangedValue) {
              if (onChangedValue != null) {
                final currentlySelectedValue = _firstSelected();
                if (currentlySelectedValue != null) {
                  onModifierSelectedChanged(currentlySelectedValue, false);
                }

                if (onChangedValue != currentlySelectedValue) {
                  onModifierSelectedChanged(onChangedValue, true);
                }
              }
            },
            items: modifierToSelectedMap.keys
                .map<DropdownMenuItem<ModifierEntity>>(
                  (value) => DropdownMenuItem<ModifierEntity>(
                    value: value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(value.name ?? ''),
                        Text(
                          value.formattedMoneyAmount(
                            currencyCode,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        );
      }
    } else {
      return Column(
        children: modifierToSelectedMap.keys
            .map(
              (value) => CheckboxListTile(
                title: Text(value.name ?? ''),
                secondary: Text(
                  value.formattedMoneyAmount(currencyCode),
                ),
                value: modifierToSelectedMap[value],
                onChanged: (bool? onChangedValue) {
                  if (onChangedValue != null) {
                    if (onChangedValue &&
                        maxSelectedModifiers != -1 &&
                        _numSelected() >= maxSelectedModifiers) {
                      return;
                    }

                    onModifierSelectedChanged(value, onChangedValue);
                  }
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
            )
            .toList(),
      );
    }
  }

  int _numSelected() {
    return modifierToSelectedMap.values.where((element) => element).length;
  }

  ModifierEntity? _firstSelected() {
    for (MapEntry<ModifierEntity, bool> entry
        in modifierToSelectedMap.entries) {
      if (entry.value) {
        return entry.key;
      }
    }
    return null;
  }
}
