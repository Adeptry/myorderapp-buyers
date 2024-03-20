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

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:myorderapp_square/myorderapp_square.dart';

import '../intl/num_intl_extensions.dart';
import 'line_item_modifier_entity_extensions.dart';

extension LineItemEntityExtensions on LineItemEntity {
  String get formattedSummary {
    return "${quantity}x $name";
  }

  String formattedTotalMoneyAmount(String? currencyCode) {
    return "${((totalMoneyAmount ?? 0)).formatSimpleCurrency(currencyCode ?? "USD")}";
  }

  String formattedVariationAndModifiersTotalMoneyAmount(String? currencyCode) {
    return "${((variationAndModifiersTotalMoneyAmount ?? 0)).formatSimpleCurrency(currencyCode ?? "USD")}";
  }

  num? get variationAndModifiersTotalMoneyAmount {
    return (variationTotalMoneyAmount ?? 0) +
        (modifiers?.fold(0, (previousValue, element) {
              return (previousValue ?? 0) + (element.totalMoneyAmount ?? 0);
            }) ??
            0);
  }

  String formattedModfiersSummary(String? currencyCode) {
    return (modifiers ?? []).map((e) {
      return e.formattedSummary(currencyCode);
    }).join(", ");
  }

  AnalyticsEventItem analyticsEventItem() => AnalyticsEventItem(
        itemName: name,
        price: ((totalMoneyAmount ?? 0) / 100),
        quantity: int.tryParse(quantity ?? "0"),
      );
}
