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

import '../../constants/widget_constants.dart';
import '../../extensions/build_context_extensions.dart';
import 'tip_segmented_button.dart';

class TipColumn extends StatelessWidget {
  final String _currencySymbol;
  final String? _formattedAmount;
  final List<int> _selectablePercentages;
  final Function(int? percentage) _onPercentageChanged;
  final Function(int amount) _onAbsoluteChanged;
  final int? _selectedPercentage;

  const TipColumn({
    required String currencySymbol,
    required String? formattedAmount,
    required List<int> selectablePercentages,
    required dynamic Function(int) onAbsoluteChanged,
    required dynamic Function(int?) onPercentageChanged,
    required int? selectedPercentage,
    super.key,
  })  : _onAbsoluteChanged = onAbsoluteChanged,
        _onPercentageChanged = onPercentageChanged,
        _selectablePercentages = selectablePercentages,
        _formattedAmount = formattedAmount,
        _currencySymbol = currencySymbol,
        _selectedPercentage = selectedPercentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(context.l10n.tipColumnTitle),
            Text(
              _formattedAmount ?? "",
              style: context.captionTextStyle,
            ),
          ],
        ),
        const SizedBox(height: WidgetConstants.defaultPaddingDouble),
        Row(
          children: [
            Expanded(
              child: TipSegmentedButton(
                percentages: _selectablePercentages,
                onPercentageChanged: (percentage) {
                  _onPercentageChanged(percentage);
                },
                selectedPercentage: _selectedPercentage,
              ),
            ),
            const SizedBox(width: WidgetConstants.defaultPaddingDouble),
            TextButton(
              onPressed: () {
                _showMoneyInputDialog(context);
              },
              child: Text(context.l10n.customTip),
            ),
          ],
        ),
      ],
    );
  }

  void _showMoneyInputDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(context.l10n.enterTipAmount),
          content: TextField(
            controller: controller,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              prefixText: _currencySymbol,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(context.l10n.cancel),
            ),
            TextButton(
              onPressed: () {
                double? amount = double.tryParse(controller.text);
                if (amount != null) {
                  _onAbsoluteChanged((amount * 100).round());
                  Navigator.of(context).pop();
                } else {
                  controller.text = "";
                }
              },
              child: Text(context.l10n.add),
            ),
          ],
        );
      },
    );
  }
}
