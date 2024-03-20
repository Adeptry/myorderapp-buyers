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
import 'package:overlay_support/overlay_support.dart';

import '../../constants/widget_constants.dart';
import '../../extensions/build_context_extensions.dart';
import '../../extensions/myorderapp_square/app_config_entity_extensions.dart';
import '../../extensions/myorderapp_square/line_item_entity_extensions.dart';
import '../../providers/app_config/provider.dart';
import '../../providers/category_list/provider.dart';
import '../../providers/category_scaffold/provider.dart';
import '../../providers/current_order/provider.dart';
import '../../providers/item_scaffold/provider.dart';
import '../../providers/merchant/provider.dart';
import '../../providers/merchant_id_or_path/provider.dart';
import '../../providers/moa_firebase/provider.dart';
import '../../routes/catalog/catalog_item_route_data.dart';
import '../../routes/catalog/current_order_route_data/index.dart';
import '../../routes/root_route_data.dart';
import '../list_views/categories_list_view.dart';

final categoriesScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

final categoriesScaffoldKey = GlobalKey<ScaffoldState>();

class CatalogScaffold extends ConsumerStatefulWidget {
  const CatalogScaffold({super.key});

  @override
  ConsumerState<CatalogScaffold> createState() => _CatalogScaffoldState();
}

class _CatalogScaffoldState extends ConsumerState<CatalogScaffold> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final merchantIdOrPath = ref.watch(merchantIdOrPathProvider);

    final appConfigProvider = AppConfigProvider(
      merchantIdOrPath: merchantIdOrPath,
    );
    final appConfigNotifier = ref.watch(
      appConfigProvider.notifier,
    );
    final merchantState = ref.watch(
      MerchantProvider(
        merchantIdOrPath: merchantIdOrPath,
        xCustomLang: context.locale.languageCode,
      ),
    );
    final merchant = merchantState.valueOrNull;
    final categoryList = ref.watch(
      CategoryListProvider(
        merchantIdOrPath: merchantIdOrPath,
        xCustomLang: context.locale.languageCode,
      ),
    );
    final categoryScaffoldProvider = CategoryScaffoldProvider(
      context.locale.languageCode,
    );
    final categoryScaffoldNotifier =
        ref.watch(categoryScaffoldProvider.notifier);
    final currentOrder = ref.watch(
      CurrentOrderProvider(
        merchantIdOrPath: merchantIdOrPath,
      ),
    );

    final isDemo = ref.read(isDemoProvider);

    return ScaffoldMessenger(
      key: categoriesScaffoldMessengerKey,
      child: categoryList.when(
        data: (value) => Scaffold(
          key: categoriesScaffoldKey,
          drawer: Drawer(
            child: ListView(
              children: List.generate(
                value?.length ?? 0,
                (index) => ListTile(
                  title: Text(value?.safeGet(index)?.name ?? ''),
                  onTap: () {
                    Navigator.of(context).pop(); // Close the drawer
                    categoryScaffoldNotifier.onExpansionChanged(
                      index: index,
                      expanded: true,
                    );
                    categoriesListViewStateGlobalKey.currentState
                        ?.scrollTo(index);
                  },
                ),
              ),
            ),
          ),
          floatingActionButton: currentOrder.value?.order != null
              ? FloatingActionButton.extended(
                  onPressed: () {
                    CurrentOrderRouteData(merchantIdOrPath: merchantIdOrPath)
                        .go(context);

                    MoaFirebase.analytics?.logViewCart(
                      value: currentOrder.value!.totalPlusTipMoneyAmount / 100,
                      currency: merchant?.currencyCode,
                      items: currentOrder.value!.order?.lineItems
                          ?.map((e) => e.analyticsEventItem())
                          .toList(),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart),
                  label: Text(
                    '${context.l10n.viewOrder} ${currentOrder.value!.formattedTotalMoneyPlusTipAmount(merchant?.currencyCode)}',
                  ),
                )
              : null,
          body: RefreshIndicator(
            onRefresh: () => Future.sync(
              () {
                if (isDemo) {
                  final appConfig = appConfigNotifier.randomizeAndSet();
                  showSimpleNotification(
                    Text(appConfig.formattedSummary(context)),
                    duration: WidgetConstants.notificationDuration,
                  );
                }
              },
            ),
            child: CategoriesListView(
              key: categoriesListViewStateGlobalKey,
              currencyCode: merchant?.currencyCode ?? 'USD',
              categories: value ?? [],
              onTapItem: (item) async {
                final itemScaffoldNotifier =
                    ref.read(itemScaffoldProvider.notifier);
                itemScaffoldNotifier.setSparseItem(sparseItem: item);
                itemScaffoldNotifier.getAndSetOrThrow(
                  itemId: item.id!,
                  xCustomLang: context.locale.languageCode,
                );
                CatalogItemRouteData(
                  merchantIdOrPath: merchantIdOrPath,
                  itemId: item.id!,
                ).go(context);
                await MoaFirebase.analytics?.logSelectItem(
                  itemListId: item.id!,
                  itemListName: item.name,
                );
              },
            ),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text(
            error.toString(),
          ),
        ),
      ),
    );
  }
}
