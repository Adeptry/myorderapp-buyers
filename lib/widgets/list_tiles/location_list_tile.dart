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
import '../../extensions/myorderapp_square/address_entity_extensions.dart';
import '../../extensions/myorderapp_square/business_hours_period_entity_extensions.dart';
import '../../extensions/myorderapp_square/business_hours_period_entity_list_extensions.dart';

class LocationListTile extends StatelessWidget {
  final LocationEntity? location;
  final bool? selected;
  final Widget? leading;
  final Widget? trailing;
  final Function(LocationEntity location)? onTapToSelect;
  final Function(LocationEntity location)? onTapLaunchMaps;

  const LocationListTile(
    this.location, {
    this.onTapToSelect,
    this.onTapLaunchMaps,
    this.selected,
    this.leading,
    this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locationBusinessHours = location?.businessHours;

    final businessHours = locationBusinessHours?.nextBusinessHours();
    final todaysBusinessHoursIncludesNow =
        locationBusinessHours?.nowIsWithinBusinessHoursToday();

    final captionString =
        context.l10n.opens(businessHours?.formattedSummary(context) ?? "");

    final selectedOrFalse = selected ?? false;
    return ListTile(
      title: Text(
        location?.address?.addressLine1 ?? "",
        style: context.bodyLargeTextStyle,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            location?.address?.formattedLocalitySummary ?? "",
          ),
          if (todaysBusinessHoursIncludesNow != null) ...[
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: todaysBusinessHoursIncludesNow
                        ? context.l10n.open
                        : context.l10n.closed,
                    style: context.captionTextStyle?.copyWith(
                      color: todaysBusinessHoursIncludesNow
                          ? context.theme.colorScheme.primary
                          : context.theme.colorScheme.error,
                    ),
                  ),
                  const TextSpan(
                    text: ' ', // This acts like your SizedBox.
                  ),
                  TextSpan(
                    text: captionString,
                    style: context.captionTextStyle,
                  ),
                ],
              ),
            )
          ],
        ],
      ),
      selected: selectedOrFalse,
      leading: leading,
      trailing: (selectedOrFalse && onTapToSelect != null
          ? const Icon(Icons.check_circle_rounded)
          : trailing),
      onTap: onTapToSelect != null
          ? () => onTapToSelect?.call(location!)
          : onTapLaunchMaps != null
              ? () => onTapLaunchMaps?.call(location!)
              : null,
    );
  }
}
