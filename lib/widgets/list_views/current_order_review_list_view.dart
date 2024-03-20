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
import '../../providers/current_order/state.dart';
import '../list_tiles/date_list_tile.dart';
import '../list_tiles/header_list_tile.dart';
import '../list_tiles/line_item_list_tile.dart';
import '../list_tiles/location_list_tile.dart';
import '../list_tiles/time_list_tile.dart';

enum CurrentOrderListViewItem {
  locationTitle,
  locationDetail,
  dateTimeTitle,
  dateDetail,
  timeDetail,
  itemsTitle,
}

class CurrentOrderReviewListView extends StatelessWidget {
  final MerchantEntity? merchant;
  final CurrentOrderState? currentOrder;
  final Function(LineItemEntity lineItem)? deleteLineItemOnPress;
  final Function(LineItemEntity lineItem)? editLineItemOnPress;
  final Function() onTapToSelectLocation;
  final Function() onTapTime;
  final Function() onTapDate;

  const CurrentOrderReviewListView({
    super.key,
    required this.merchant,
    required this.currentOrder,
    required this.onTapToSelectLocation,
    required this.onTapDate,
    required this.onTapTime,
    this.deleteLineItemOnPress,
    this.editLineItemOnPress,
  });

  @override
  Widget build(BuildContext context) {
    final order = currentOrder?.order;
    final lineItems = order?.lineItems ?? [];
    final location = order?.location;

    final pickupOrAsapDateTime = currentOrder?.pickupOrAsapDateTime(
      leadDurationMinutes: merchant?.pickupLeadDurationMinutes,
    );
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 260),
      itemCount: CurrentOrderListViewItem.values.length + lineItems.length,
      itemBuilder: (context, index) {
        if (index < CurrentOrderListViewItem.values.length) {
          switch (CurrentOrderListViewItem.values[index]) {
            case CurrentOrderListViewItem.locationTitle:
              return HeaderListTile(context.l10n.pickupLocation);
            case CurrentOrderListViewItem.locationDetail:
              return LocationListTile(
                location,
                trailing: const Icon(Icons.edit_location_alt),
                onTapToSelect: (location) => onTapToSelectLocation(),
              );
            case CurrentOrderListViewItem.dateTimeTitle:
              return HeaderListTile(context.l10n.pickupTime);
            case CurrentOrderListViewItem.dateDetail:
              return DateListTile(
                pickupOrAsapDateTime ?? DateTime.now(),
                onTap: () => onTapDate(),
              );
            case CurrentOrderListViewItem.timeDetail:
              return TimeListTile(
                pickupOrAsapDateTime,
                isAsap: currentOrder?.isAsap,
                onTap: () => onTapTime(),
              );
            case CurrentOrderListViewItem.itemsTitle:
              return HeaderListTile(context.l10n.items);
          }
        } else {
          return LineItemListTile(
            currencyCode: merchant?.currencyCode ?? 'USD',
            deleteOnPress: deleteLineItemOnPress,
            editOnPress: editLineItemOnPress,
            lineItem: lineItems[index - CurrentOrderListViewItem.values.length],
          );
        }
      },
      separatorBuilder: (context, index) {
        if (index < CurrentOrderListViewItem.values.length) {
          switch (CurrentOrderListViewItem.values[index]) {
            case CurrentOrderListViewItem.locationTitle:
            case CurrentOrderListViewItem.dateTimeTitle:
            case CurrentOrderListViewItem.itemsTitle:
            case CurrentOrderListViewItem.dateDetail:
              return const SizedBox.shrink();
            case CurrentOrderListViewItem.locationDetail:
            case CurrentOrderListViewItem.timeDetail:
              return const Divider();
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
