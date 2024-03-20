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

import '../../extensions/dart/set_extensions.dart';

class TipSegmentedButton extends StatelessWidget {
  final int? _selectedPercentage;
  final List<int> _percentages;
  final Function(int? percentage) _onPercentageChanged;

  const TipSegmentedButton({
    required List<int> percentages,
    required dynamic Function(int?) onPercentageChanged,
    required int? selectedPercentage,
    super.key,
  })  : _onPercentageChanged = onPercentageChanged,
        _percentages = percentages,
        _selectedPercentage = selectedPercentage;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<int>(
      segments: <ButtonSegment<int>>[
        ..._percentages.map((percentInt) {
          return ButtonSegment<int>(
            value: percentInt,
            label: Text(
              percentInt == _selectedPercentage ? '' : '$percentInt%',
              maxLines: 1,
            ),
          );
        }),
      ],
      selected: setFromNullable<int>(_selectedPercentage),
      emptySelectionAllowed: true,
      onSelectionChanged: (Set<int> newSelection) {
        _onPercentageChanged(newSelection.firstIfNotEmpty);
      },
    );
  }
}
