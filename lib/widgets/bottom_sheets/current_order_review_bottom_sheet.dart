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

import '../../constants/widget_constants.dart';
import '../../extensions/build_context_extensions.dart';
import '../../extensions/intl/string_intl_extensions.dart';
import '../../extensions/myorderapp_square/order_entity_extensions.dart';
import '../../providers/current_order/state.dart';
import '../misc/tip_column.dart';

class CurrentOrderReviewBottomSheet extends StatelessWidget {
  final CurrentOrderState? state;
  final String currencyCode;
  final void Function()? onCheckoutPressed;
  final void Function({int? tipMoneyPercentage, int? tipMoneyAbsoluteAmount})
      setTipMoney;

  const CurrentOrderReviewBottomSheet({
    required this.onCheckoutPressed,
    required this.state,
    required this.currencyCode,
    required this.setTipMoney,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final order = state?.order;
    return BottomSheet(
      enableDrag: false,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(WidgetConstants.largePaddingDouble),
          child: IntrinsicHeight(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(context.l10n.subtotal),
                    const Spacer(),
                    Text(
                      order?.formattedSubtotalMoneyAmount(
                            currencyCode,
                          ) ??
                          "",
                      style: context.captionTextStyle,
                    ),
                  ],
                ),
                const SizedBox(height: WidgetConstants.mediumPaddingDouble),
                Row(
                  children: [
                    Text(context.l10n.tax),
                    const Spacer(),
                    Text(
                      order?.formattedTotalTaxMoneyAmount(
                            currencyCode,
                          ) ??
                          "",
                      style: context.captionTextStyle,
                    ),
                  ],
                ),
                const SizedBox(height: WidgetConstants.mediumPaddingDouble),
                TipColumn(
                  currencySymbol: simpleCurrencySymbol(currencyCode),
                  formattedAmount:
                      (state?.formattedTipMoneyAmount(currencyCode)),
                  selectedPercentage: state?.tipMoneyPercentage,
                  selectablePercentages: const [10, 15, 20],
                  onAbsoluteChanged: (tipMoneyAbsoluteAmount) {
                    setTipMoney(
                      tipMoneyPercentage: 0,
                      tipMoneyAbsoluteAmount: tipMoneyAbsoluteAmount,
                    );
                  },
                  onPercentageChanged: (tipMoneyPercentage) {
                    setTipMoney(
                      tipMoneyPercentage: tipMoneyPercentage,
                      tipMoneyAbsoluteAmount: 0,
                    );
                  },
                ),
                const SizedBox(height: WidgetConstants.mediumPaddingDouble),
                Row(
                  children: [
                    Expanded(
                      child: FloatingActionButton.extended(
                        onPressed: onCheckoutPressed,
                        icon: const Icon(Icons.shopping_cart_checkout),
                        label: Text(
                          "${context.l10n.continueToCheckout} ${state?.formattedTotalMoneyPlusTipAmount(currencyCode)}",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      onClosing: () {},
    );
  }
}
