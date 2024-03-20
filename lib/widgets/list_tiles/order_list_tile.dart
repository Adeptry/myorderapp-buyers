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

import '../../constants/widget_constants.dart';
import '../../extensions/build_context_extensions.dart';
import '../../extensions/intl/date_time_intl_extensions.dart';
import '../../extensions/material/list_tile_extensions.dart';
import '../../extensions/myorderapp_square/fulfillment_status_enum_extensions.dart';
import '../../extensions/myorderapp_square/order_entity_extensions.dart';

class OrderListTile extends StatelessWidget {
  final OrderEntity order;
  final String currencyCode;
  final Function(OrderEntity order)? onTap;

  const OrderListTile({
    required this.order,
    required this.currencyCode,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pickupDate = order.pickupDate;
    final closedDate = order.closedDate;
    final fulfillmentStatus = order.squareFulfillmentStatus;
    final colorForFulfilmentStatus =
        context.getColorForFulfilmentStatus(fulfillmentStatus);
    final pickupDateIsClosedDate =
        (pickupDate?.day ?? 0) == (closedDate?.day ?? 1);

    return ListTileExtension.captioned(
      onTap: () => onTap?.call(order),
      title: Text(
        context.l10n
            .orderFromDate(order.closedDate?.formattedMediumLocalDate ?? ""),
      ),
      subtitle: Text(
        context.l10n.pickupAtTime(
          pickupDateIsClosedDate
              ? pickupDate?.formattedLocalTime ?? ""
              : pickupDate?.formattedShortLocalDateTime ?? "",
        ),
      ),
      caption: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (fulfillmentStatus != null &&
              fulfillmentStatus != FulfillmentStatusEnum.PROPOSED) ...[
            Icon(
              fulfillmentStatus.iconData,
              size: context.captionTextStyle?.fontSize,
              color: colorForFulfilmentStatus,
            ),
            const SizedBox(width: WidgetConstants.extraSmallPaddingDouble),
            Text(
              context.getL10nForFulfilmentStatus(fulfillmentStatus),
              style: context.captionTextStyle
                  ?.copyWith(color: colorForFulfilmentStatus),
            ),
            const SizedBox(width: WidgetConstants.extraSmallPaddingDouble),
          ],
          Icon(
            Icons.location_pin,
            size: context.captionTextStyle?.fontSize,
            color: context.captionTextStyle?.color,
          ),
          const SizedBox(width: WidgetConstants.smallestPaddingDouble),
          Text(
            order.location?.address?.addressLine1 ?? "",
            style: context.captionTextStyle,
          ),
        ],
      ),
      trailing: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(order.formattedTotalMoneyAmount(currencyCode)),
          const SizedBox(width: WidgetConstants.extraSmallPaddingDouble),
          const Icon(Icons.chevron_right),
        ],
      ),
      leading: const Icon(Icons.receipt),
    );
  }
}
