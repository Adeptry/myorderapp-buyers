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
import 'package:pay_ios/pay_ios.dart';
import 'package:pay_android/pay_android.dart';

import '../../constants/widget_constants.dart';
import '../../extensions/build_context_extensions.dart';
import '../../extensions/myorderapp_square/square_card_extensions.dart';
import '../scaffolds/current_order_payment_scaffold.dart';

enum CurrentOrderPaymentBottomSheetAction {
  createSquareCard,
  postPayment,
}

class CurrentOrderPaymentBottomSheet extends StatelessWidget {
  final bool isLoading;
  final SquareCard? preferredSquareCard;
  final CurrentOrderSelectedPaymentMethod selectedPaymentMethod;
  final void Function() onPressedCreateSquareCard;
  final void Function() onPressedPay;

  const CurrentOrderPaymentBottomSheet({
    required this.onPressedCreateSquareCard,
    required this.onPressedPay,
    required this.preferredSquareCard,
    required this.isLoading,
    required this.selectedPaymentMethod,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                    Expanded(
                      child: _buildFab(context, selectedPaymentMethod),
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

  _buildFab(
    BuildContext context,
    CurrentOrderSelectedPaymentMethod selectedPaymentMethod,
  ) {
    switch (selectedPaymentMethod) {
      case CurrentOrderSelectedPaymentMethod.googlePay:
        return SizedBox(
          height: 45,
          child: RawGooglePayButton(
            onPressed: isLoading ? null : onPressedPay,
            type: GooglePayButtonType.buy,
          ),
        );
      case CurrentOrderSelectedPaymentMethod.applePay:
        return SizedBox(
          height: 45,
          child: RawApplePayButton(
            onPressed: isLoading ? null : onPressedPay,
            style: ApplePayButtonStyle.black,
            type: ApplePayButtonType.buy,
          ),
        );
      case CurrentOrderSelectedPaymentMethod.squareCard:
        return FloatingActionButton.extended(
          onPressed: isLoading ? null : onPressedPay,
          icon: const Icon(Icons.shopping_cart_checkout),
          label: Text(
            context.l10n
                .payWithSquareCard(preferredSquareCard?.formattedSummary ?? ""),
          ),
        );
      case CurrentOrderSelectedPaymentMethod.none:
        return FloatingActionButton.extended(
          onPressed: onPressedCreateSquareCard,
          icon: isLoading ? null : const Icon(Icons.payment),
          label: Text(isLoading ? "" : context.l10n.addPayment),
        );
    }
  }
}
