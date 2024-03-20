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

import 'package:myorderapp_square/myorderapp_square.dart';

import '../dart/optional_num_extensions.dart';
import '../intl/num_intl_extensions.dart';

extension OrderEntityExtensions on OrderEntity {
  String formattedSubtotalMoneyAmount(String? currencyCode) {
    return "${((subtotalMoneyAmount.orZero)).formatSimpleCurrency(currencyCode ?? "USD")}";
  }

  String formattedTotalMoneyAmount(String? currencyCode) {
    return "${((totalMoneyAmount.orZero)).formatSimpleCurrency(currencyCode ?? "USD")}";
  }

  String formattedTotalTaxMoneyAmount(String? currencyCode) {
    return "${((totalTaxMoneyAmount.orZero)).formatSimpleCurrency(currencyCode ?? "USD")}";
  }

  String formattedTotalTipMoneyAmount(String? currencyCode) {
    return "${((totalTipMoneyAmount.orZero)).formatSimpleCurrency(currencyCode ?? "USD")}";
  }
}
