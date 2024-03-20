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
import '../../providers/customer/provider.dart';
import '../../providers/merchant_id_or_path/provider.dart';
import '../list_tiles/location_list_tile.dart';

class LocationsPagedListView extends ConsumerStatefulWidget {
  final Function(LocationEntity location)? onTap;

  const LocationsPagedListView({super.key, this.onTap});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<LocationsPagedListView> {
  final PagingController<int, LocationEntity> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    final merchantIdOrPath = ref.read(merchantIdOrPathProvider);
    _pagingController.addPageRequestListener((page) async {
      final api = ref.read(locationsApiProvider);
      try {
        final response = await api.getLocationsMe(
          page: page,
          limit: 12,
          businessHours: true,
          actingAs: "customer",
          address: true,
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
    final customer =
        ref.watch(CustomerProvider(merchantIdOrPath: merchantIdOrPath));
    final customersPreferredLocationId = customer.value?.preferredLocation?.id;
    return RefreshIndicator(
      onRefresh: () => Future.sync(
        () {
          _pagingController.refresh();
        },
      ),
      child: PagedListView<int, LocationEntity>.separated(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<LocationEntity>(
          firstPageErrorIndicatorBuilder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.store),
              const SizedBox(height: WidgetConstants.defaultPaddingDouble),
              Text(
                context.l10n.locationsPagedListViewNoItemsTitle,
                style: context.headerTextStyle,
              ),
              const SizedBox(height: WidgetConstants.extraSmallPaddingDouble),
              Text(
                context.l10n.locationsPagedListViewNoItemsSubtitle,
                style: context.bodyLargeTextStyle,
              ),
            ],
          ),
          noItemsFoundIndicatorBuilder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.store),
              const SizedBox(height: WidgetConstants.defaultPaddingDouble),
              Text(
                context.l10n.locationsPagedListViewNoItemsTitle,
                style: context.headerTextStyle,
              ),
              const SizedBox(height: WidgetConstants.extraSmallPaddingDouble),
              Text(
                context.l10n.locationsPagedListViewNoItemsSubtitle,
                style: context.bodyLargeTextStyle,
              ),
            ],
          ),
          itemBuilder: (context, location, index) => LocationListTile(
            location,
            onTapToSelect: widget.onTap,
            selected: customersPreferredLocationId == location.id,
          ),
        ),
        separatorBuilder: (context, index) => const Divider(),
        physics: const AlwaysScrollableScrollPhysics(),
      ),
    );
  }
}
