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

part 'state.freezed.dart';

@freezed
class CategoryScaffoldState with _$CategoryScaffoldState {
  const CategoryScaffoldState._();

  const factory CategoryScaffoldState({
    required List<bool> expanded,
  }) = _CategoryScaffoldState;

  bool expandedAtIndex(int index) {
    return expanded[index];
  }

  bool everyCollapsed() {
    return expanded.every((element) => !element);
  }

  bool anyCollapsed() {
    return expanded.any((element) => !element);
  }

  bool everyExpanded() {
    return expanded.every((element) => element);
  }

  bool anyExpanded() {
    if (expanded.isEmpty) {
      return true;
    } else {
      return expanded.any((element) => element);
    }
  }
}
