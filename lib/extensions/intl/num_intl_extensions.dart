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

import 'package:intl/intl.dart';

extension NumberIntlExtensions on num {
  String? formatSimpleCurrency(String? currencyCode) {
    if (currencyCode == null) {
      return null;
    }
    return NumberFormat.simpleCurrency(name: currencyCode)
        .format(toDoubleInCurrency(currencyCode));
  }

  double? toDoubleInCurrency(String? currencyCode) {
    if (currencyCode == null) {
      return null;
    } else if (currencyCode == 'JPY') {
      return toDouble();
    } else {
      return (this / 100).toDouble();
    }
  }

  String? toStringAsFixedInCurrency(String? currencyCode) {
    if (currencyCode == null) {
      return null;
    } else if (currencyCode == 'JPY') {
      return toStringAsFixed(0);
    } else {
      return toDoubleInCurrency(currencyCode)?.toStringAsFixed(2);
    }
  }
}
