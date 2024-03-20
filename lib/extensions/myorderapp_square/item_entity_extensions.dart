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

import 'dart:math';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:myorderapp_square/myorderapp_square.dart';

import '../dart/optional_bool_extensions.dart';
import '../intl/double_intl_extensions.dart';

extension ItemEntityExtensions on ItemEntity {
  List<VariationEntity> get enabledVariations =>
      (variations?.where((variation) => variation.moaEnabled.orFalse) ?? [])
          .toList();

  String formattedPriceRange(String? currencyCode) {
    var priceRange = variations!
        .fold<List<double>>([double.infinity, double.negativeInfinity],
            (List<double> acc, VariationEntity variation) {
      double price = variation.priceMoneyAmount?.toDouble() ?? double.infinity;
      return [min(acc[0], price), max(acc[1], price)];
    });

    // Use the extension to format the price
    String? lowestPrice = (priceRange[0]).formatSimpleCurrency(currencyCode);
    String? highestPrice = (priceRange[1]).formatSimpleCurrency(currencyCode);

    String priceRangeStr = "";

    // If both prices are the same, display only one price
    if (lowestPrice != null && highestPrice != null) {
      if (lowestPrice == highestPrice) {
        priceRangeStr = lowestPrice;
      } else {
        priceRangeStr = "$lowestPrice to $highestPrice";
      }
    }

    return priceRangeStr;
  }

  AnalyticsEventItem analyticsEventItem() =>
      AnalyticsEventItem(itemName: name, itemId: id);
}
