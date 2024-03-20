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
import '../../extensions/myorderapp_square/order_entity_extensions.dart';
import '../list_tiles/date_list_tile.dart';
import '../list_tiles/header_list_tile.dart';
import '../list_tiles/line_item_list_tile.dart';
import '../list_tiles/location_list_tile.dart';
import '../list_tiles/time_list_tile.dart';

enum _LocationSectionItems {
  header,
  detail,
}

enum _DateTimeSectionItems {
  header,
  dateDetail,
  timeDetail,
}

enum _LineItemSectionItems {
  header,
}

enum _TotalsSectionItems {
  header,
  subtotal,
  tax,
  tip,
  total,
}

enum _NoteSectionItems {
  header,
  detail,
}

class OrderListView extends StatelessWidget {
  final OrderEntity order;
  final String currencyCode;
  final Function(LocationEntity location)? onTapLaunchMaps;

  const OrderListView(
    this.order, {
    required this.currencyCode,
    this.onTapLaunchMaps,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final lineItems = order.lineItems ?? [];

    return ListView.separated(
      itemCount: _LocationSectionItems.values.length +
          _DateTimeSectionItems.values.length +
          _LineItemSectionItems.values.length +
          lineItems.length +
          _TotalsSectionItems.values.length +
          _NoteSectionItems.values.length,
      itemBuilder: (context, index) {
        int runningTotal = 0;
        int sectionIndex = 0;

        runningTotal += _LocationSectionItems.values.length;
        if (index < runningTotal) {
          sectionIndex = index;
          switch (_LocationSectionItems.values[sectionIndex]) {
            case _LocationSectionItems.header:
              return HeaderListTile(context.l10n.pickupLocation);
            case _LocationSectionItems.detail:
              return LocationListTile(
                order.location,
                onTapLaunchMaps: onTapLaunchMaps,
                trailing: const Icon(Icons.assistant_direction_outlined),
              );
          }
        }

        runningTotal += _DateTimeSectionItems.values.length;
        if (index < runningTotal) {
          sectionIndex =
              index - runningTotal + _DateTimeSectionItems.values.length;
          switch (_DateTimeSectionItems.values[sectionIndex]) {
            case _DateTimeSectionItems.header:
              return HeaderListTile(context.l10n.pickupTime);
            case _DateTimeSectionItems.dateDetail:
              return DateListTile(order.pickupDate ?? DateTime.now());
            case _DateTimeSectionItems.timeDetail:
              return TimeListTile(order.pickupDate ?? DateTime.now());
          }
        }

        runningTotal += _LineItemSectionItems.values.length;
        if (index < runningTotal) {
          sectionIndex =
              index - runningTotal + _LineItemSectionItems.values.length;
          switch (_LineItemSectionItems.values[sectionIndex]) {
            case _LineItemSectionItems.header:
              return HeaderListTile(context.l10n.items);
          }
        }

        runningTotal += lineItems.length;
        if (index < runningTotal) {
          sectionIndex = index - runningTotal + lineItems.length;
          return LineItemListTile(
            lineItem: lineItems[sectionIndex],
            currencyCode: currencyCode,
          );
        }

        runningTotal += _TotalsSectionItems.values.length;
        if (index < runningTotal) {
          sectionIndex =
              index - runningTotal + _TotalsSectionItems.values.length;
          switch (_TotalsSectionItems.values[sectionIndex]) {
            case _TotalsSectionItems.header:
              return const HeaderListTile("Totals");
            case _TotalsSectionItems.subtotal:
              return ListTile(
                title: Text(context.l10n.subtotal),
                trailing: Text(
                  order.formattedSubtotalMoneyAmount(
                    currencyCode,
                  ),
                ),
              );
            case _TotalsSectionItems.tax:
              return ListTile(
                title: Text(context.l10n.tax),
                trailing: Text(
                  order.formattedTotalTaxMoneyAmount(
                    currencyCode,
                  ),
                ),
              );
            case _TotalsSectionItems.tip:
              return ListTile(
                title: Text(context.l10n.tip),
                trailing: Text(
                  order.formattedTotalTipMoneyAmount(
                    currencyCode,
                  ),
                ),
              );
            case _TotalsSectionItems.total:
              return ListTile(
                title: Text(context.l10n.total),
                trailing: Text(
                  order.formattedTotalMoneyAmount(currencyCode),
                ),
              );
          }
        }

        runningTotal += _NoteSectionItems.values.length;
        if (index < runningTotal) {
          sectionIndex = index - runningTotal + _NoteSectionItems.values.length;
          switch (_NoteSectionItems.values[sectionIndex]) {
            case _NoteSectionItems.header:
              return HeaderListTile(context.l10n.noteTitle);
            case _NoteSectionItems.detail:
              return ListTile(title: Text(order.note ?? ""));
          }
        }

        // Catch-all return, just in case something goes wrong.
        throw Exception("Index $index is out of bounds");
      },
      separatorBuilder: (context, index) {
        return const SizedBox.shrink();
      },
    );
  }
}
