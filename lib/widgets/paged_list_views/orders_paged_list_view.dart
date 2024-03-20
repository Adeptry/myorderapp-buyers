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
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:myorderapp_square/myorderapp_square.dart';

import '../../constants/widget_constants.dart';
import '../../extensions/build_context_extensions.dart';
import '../../providers/apis/provider.dart';
import '../../providers/current_order/provider.dart';
import '../../providers/merchant/provider.dart';
import '../../providers/merchant_id_or_path/provider.dart';
import '../list_tiles/order_list_tile.dart';

class OrdersPagedListView extends ConsumerStatefulWidget {
  final Function(OrderEntity order)? onTap;

  const OrdersPagedListView({super.key, this.onTap});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<OrdersPagedListView> {
  final PagingController<int, OrderEntity> _pagingController =
      PagingController(firstPageKey: 1);

  String? _lastIdempotencyKey;

  @override
  void initState() {
    final merchantIdOrPath = ref.read(merchantIdOrPathProvider);
    _pagingController.addPageRequestListener((page) async {
      final api = ref.read(ordersApiProvider);
      try {
        final response = await api.getOrders(
          page: page,
          actingAs: "customer",
          orderSort: "DESC",
          orderField: "closedDate",
          limit: 12,
          closed: true,
          lineItems: true,
          location: true,
          merchantIdOrPath: merchantIdOrPath,
          xCustomLang: context.locale.languageCode,
        );

        final isLastPage = (response.data?.pages ?? 0) <= page;
        if (isLastPage) {
          _pagingController.appendLastPage(response.data?.data ?? []);
        } else {
          final nextPageKey = page + 1;
          _pagingController.appendPage(response.data?.data ?? [], nextPageKey);
        }
      } catch (error) {
        _pagingController.error = error;
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final merchantIdOrPath = ref.watch(merchantIdOrPathProvider);
    ref.listen(CurrentOrderProvider(merchantIdOrPath: merchantIdOrPath),
        (_, next) {
      if (next.value?.idempotencyKey != _lastIdempotencyKey) {
        _pagingController.refresh();
        _lastIdempotencyKey =
            next.value?.idempotencyKey; // Update the last UUID
      }
    });

    final merchantState = ref.watch(
      MerchantProvider(
        merchantIdOrPath: merchantIdOrPath,
        xCustomLang: context.locale.languageCode,
      ),
    );
    final merchant = merchantState.valueOrNull;

    return RefreshIndicator(
      onRefresh: () => Future.sync(
        () {
          _pagingController.refresh();
        },
      ),
      child: PagedListView<int, OrderEntity>.separated(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<OrderEntity>(
          firstPageErrorIndicatorBuilder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.receipt),
              const SizedBox(height: WidgetConstants.defaultPaddingDouble),
              Text(
                context.l10n.ordersPagedListViewNoItemsTitle,
                style: context.headerTextStyle,
              ),
              const SizedBox(height: WidgetConstants.extraSmallPaddingDouble),
              Text(
                context.l10n.ordersPagedListViewNoItemsSubtitle,
                style: context.bodyLargeTextStyle,
              ),
            ],
          ),
          noItemsFoundIndicatorBuilder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.receipt),
              const SizedBox(height: WidgetConstants.defaultPaddingDouble),
              Text(
                context.l10n.ordersPagedListViewNoItemsTitle,
                style: context.headerTextStyle,
              ),
              const SizedBox(height: WidgetConstants.extraSmallPaddingDouble),
              Text(
                context.l10n.ordersPagedListViewNoItemsSubtitle,
                style: context.bodyLargeTextStyle,
              ),
            ],
          ),
          itemBuilder: (context, order, index) => OrderListTile(
            order: order,
            currencyCode: merchant?.currencyCode ?? 'USD',
            onTap: widget.onTap,
          ),
        ),
        separatorBuilder: (context, index) => const Divider(),
        physics: const AlwaysScrollableScrollPhysics(),
      ),
    );
  }
}
