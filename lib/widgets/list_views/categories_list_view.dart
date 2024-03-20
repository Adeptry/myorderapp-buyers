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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myorderapp/extensions/dart/list_extensions.dart';
import 'package:myorderapp_square/myorderapp_square.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../constants/widget_constants.dart';
import '../../extensions/build_context_extensions.dart';
import '../../providers/category_scaffold/provider.dart';
import '../list_tiles/item_list_tile.dart';

final GlobalKey<CategoriesListViewState> categoriesListViewStateGlobalKey =
    GlobalKey();

class CategoriesListView extends ConsumerStatefulWidget {
  final List<CategoryEntity> categories;
  final String currencyCode;
  final Function(ItemEntity) onTapItem;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  static const iconButtonSize = 48.0;

  CategoriesListView({
    super.key,
    required this.categories,
    required this.onTapItem,
    required this.currencyCode,
  });

  @override
  ConsumerState<CategoriesListView> createState() => CategoriesListViewState();
}

class CategoriesListViewState extends ConsumerState<CategoriesListView> {
  @override
  Widget build(BuildContext context) {
    final categoryScaffoldProvider = CategoryScaffoldProvider(
      context.locale.languageCode,
    );
    final state = ref.watch(categoryScaffoldProvider);
    final notifier = ref.watch(categoryScaffoldProvider.notifier);

    return Stack(
      children: [
        ScrollablePositionedList.separated(
          itemScrollController: widget.itemScrollController,
          scrollOffsetController: widget.scrollOffsetController,
          itemPositionsListener: widget.itemPositionsListener,
          scrollOffsetListener: widget.scrollOffsetListener,
          padding: const EdgeInsets.only(
            bottom: WidgetConstants.floatingActionButtonBottomPadding,
          ),
          itemCount: widget.categories.length,
          itemBuilder: (context, expansionIndex) {
            final category = widget.categories[expansionIndex];
            final initiallyExpanded =
                state.expanded.safeGet(expansionIndex) ?? true;
            Key key = ValueKey("$expansionIndex-$initiallyExpanded");
            return ExpansionTile(
              key: key,
              expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
              initiallyExpanded: initiallyExpanded,
              shape: const Border(),
              title: Text(category.name ?? ''),
              maintainState: false,
              textColor: context.headerTextStyle?.color,
              onExpansionChanged: (value) async {
                if (value) {
                  await widget.itemScrollController.scrollTo(
                    index: expansionIndex,
                    duration: WidgetConstants.fastAnimationDuration,
                    curve: Curves.easeInOut,
                  );
                }
                notifier.onExpansionChanged(
                  index: expansionIndex,
                  expanded: value,
                );
              },
              subtitle:
                  Text(context.l10n.itemsCount(category.items?.length ?? 0)),
              children: category.items?.map<Widget>((item) {
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        child: ItemListTile(
                          item: item,
                          onTap: widget.onTapItem,
                          currencyCode: widget.currencyCode,
                          shouldLoadNetworkImage:
                              state.expandedAtIndex(expansionIndex),
                        ),
                      ),
                    );
                  }).toList() ??
                  [],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        ),
      ],
    );
  }

  Future<void> scrollTo(int index) {
    return widget.itemScrollController.scrollTo(
      index: index,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }
}
