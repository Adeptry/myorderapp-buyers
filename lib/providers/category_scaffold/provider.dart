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

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../constants/widget_constants.dart';
import '../app_config/provider.dart';
import '../category_list/provider.dart';
import '../merchant_id_or_path/provider.dart';
import 'state.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class CategoryScaffold extends _$CategoryScaffold {
  @override
  CategoryScaffoldState build(String? xCustomLang) {
    final merchantIdOrPath = ref.watch(merchantIdOrPathProvider);
    final categoryListValue = ref.watch(
      CategoryListProvider(
        merchantIdOrPath: merchantIdOrPath,
        xCustomLang: xCustomLang,
      ),
    );
    final categoryList = categoryListValue.valueOrNull ?? [];
    final appConfigState = ref.watch(
      AppConfigProvider(
        merchantIdOrPath: merchantIdOrPath,
      ),
    );
    final appConfigValue = appConfigState.valueOrNull;

    return CategoryScaffoldState(
      expanded: List.generate(
        categoryList.length,
        (index) =>
            (categoryList[index].items?.length ?? 0) <
            (appConfigValue?.categoryCollapseThreshold ??
                WidgetConstants.radioThreshold),
      ),
    );
  }

  void toggleExpanded({required int index}) {
    final List<bool> expandedList = List<bool>.from(state.expanded);
    expandedList[index] = !expandedList[index];
    state = state.copyWith(expanded: expandedList);
  }

  void onExpansionChanged({required int index, required bool expanded}) {
    final List<bool> expandedList = List<bool>.from(state.expanded);
    expandedList[index] = expanded;
    state = state.copyWith(expanded: expandedList);
  }

  void toggleAllExpanded() {
    final anyExpanded = state.anyExpanded();
    state = state.copyWith(
      expanded: List.generate(
        state.expanded.length,
        (index) => !anyExpanded,
      ),
    );
  }
}
