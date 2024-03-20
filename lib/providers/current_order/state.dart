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

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myorderapp_square/myorderapp_square.dart';

import '../../../extensions/intl/num_intl_extensions.dart';
import '../../../extensions/myorderapp_square/business_hours_period_entity_list_extensions.dart';

part 'state.freezed.dart';

@freezed
class CurrentOrderState with _$CurrentOrderState {
  const CurrentOrderState._();

  const factory CurrentOrderState({
    OrderEntity? order,
    @Default(0) int tipMoneyAbsoluteAmount,
    @Default(0) int tipMoneyPercentage,
    DateTime? pickupDateTime,
    String? note,
    String? idempotencyKey,
  }) = _CheckoutState;

  bool get isAsap => pickupDateTime == null;

  DateTime? pickupOrAsapDateTime({required num? leadDurationMinutes}) {
    return pickupDateTime ??
        order?.location?.businessHours?.firstPickupDateTimeWithin(
          minutes: leadDurationMinutes?.toInt() ?? 15,
        );
  }

  int get tipMoneyPercentageAmount =>
      ((order?.totalMoneyAmount ?? 0) * (tipMoneyPercentage / 100)).round();

  int get tipMoneyAmount => tipMoneyPercentageAmount + tipMoneyAbsoluteAmount;

  int get totalPlusTipMoneyAmount =>
      (((order?.totalMoneyAmount?.round() ?? 0)) + tipMoneyAmount);

  double? totalPlusTipMoneyAmountToDoubleInCurrency(String? currencyCode) {
    return totalPlusTipMoneyAmount.toDoubleInCurrency(currencyCode);
  }

  String formattedTipMoneyAmount(String? currencyCode) {
    return "${((tipMoneyAmount)).formatSimpleCurrency(currencyCode ?? "USD")}";
  }

  String? formattedTotalMoneyPlusTipAmount(String? currencyCode) =>
      totalPlusTipMoneyAmount.formatSimpleCurrency(currencyCode);

  String? totalPlusTipMoneyAmountToStringAsFixedInCurrency(
    String? currencyCode,
  ) =>
      totalPlusTipMoneyAmount.toStringAsFixedInCurrency(currencyCode);
}
