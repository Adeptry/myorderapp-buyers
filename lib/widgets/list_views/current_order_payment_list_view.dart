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
import '../../extensions/myorderapp_square/order_entity_extensions.dart';
import '../../providers/current_order/state.dart';
import '../list_tiles/apple_pay_list_tile.dart';
import '../list_tiles/date_list_tile.dart';
import '../list_tiles/google_pay_list_tile.dart';
import '../list_tiles/header_list_tile.dart';
import '../list_tiles/location_list_tile.dart';
import '../list_tiles/name_list_tile.dart';
import '../list_tiles/phone_number_list_tile.dart';
import '../list_tiles/square_card_list_tile.dart';
import '../scaffolds/current_order_payment_scaffold.dart';

enum CurrentOrderPaymentListViewItem {
  detailsHeader,
  locationDetail,
  dateTimeDetail,
  recipientNameDetail,
  recipientPhoneDetail,
  paymentTitle,
  googlePayDetail,
  applePayDetail,
  paymentDetail,
  note,
  totalsHeader,
  subtotalDetail,
  taxDetail,
  tipDetail,
  totalDetail,
}

class CurrentOrderPaymentListView extends StatefulWidget {
  final CurrentOrderState? currentOrder;
  final CustomerEntity? customer;
  final UserEntity? user;
  final MerchantEntity? merchant;
  final SquareCard? squareCard;
  final bool isLoading;
  final bool? canUseGooglePay;
  final bool? canUseApplePay;
  final CurrentOrderSelectedPaymentMethod selectedPaymentMethod;
  final Function(CurrentOrderPaymentListViewItem)? onTapItem;
  final Function(String) onNoteChanged;
  final Function(SquareCard) onPressedDeleteSquareCard;

  const CurrentOrderPaymentListView({
    super.key,
    this.onTapItem,
    required this.currentOrder,
    required this.onNoteChanged,
    required this.customer,
    required this.user,
    required this.isLoading,
    required this.merchant,
    required this.squareCard,
    required this.onPressedDeleteSquareCard,
    required this.canUseGooglePay,
    required this.canUseApplePay,
    required this.selectedPaymentMethod,
  });

  @override
  State<CurrentOrderPaymentListView> createState() =>
      _CurrentOrderPaymentListViewState();
}

class _CurrentOrderPaymentListViewState
    extends State<CurrentOrderPaymentListView> {
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _noteController.text = widget.currentOrder?.note ?? "";
    _noteController.addListener(() {
      widget.onNoteChanged(_noteController.text);
    });
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.currentOrder?.order;
    final location = order?.location;

    return ListView.separated(
      padding:
          const EdgeInsets.only(bottom: WidgetConstants.largeBottomPadding),
      itemCount: CurrentOrderPaymentListViewItem.values.length,
      itemBuilder: (BuildContext context, int index) {
        if (index < CurrentOrderPaymentListViewItem.values.length) {
          switch (CurrentOrderPaymentListViewItem.values[index]) {
            case CurrentOrderPaymentListViewItem.detailsHeader:
              return HeaderListTile(context.l10n.pickupDetails);
            case CurrentOrderPaymentListViewItem.locationDetail:
              return LocationListTile(
                location,
                trailing: const Icon(Icons.store),
              );
            case CurrentOrderPaymentListViewItem.dateTimeDetail:
              return DateListTile(
                widget.currentOrder?.pickupOrAsapDateTime(
                      leadDurationMinutes:
                          widget.merchant?.pickupLeadDurationMinutes,
                    ) ??
                    DateTime.now(),
                showTime: true,
              );
            case CurrentOrderPaymentListViewItem.recipientNameDetail:
              return NameListTile(
                fullName: widget.isLoading ? "" : widget.user?.fullName,
                onTap: () {
                  widget.onTapItem?.call(
                    CurrentOrderPaymentListViewItem.recipientNameDetail,
                  );
                },
              );
            case CurrentOrderPaymentListViewItem.recipientPhoneDetail:
              return PhoneNumberListTile(
                phoneNumber: widget.user?.phoneNumber,
                isLoading: widget.isLoading,
                countryCode: widget.merchant?.countryCode ?? "US",
                onTap: () {
                  widget.onTapItem?.call(
                    CurrentOrderPaymentListViewItem.recipientPhoneDetail,
                  );
                },
              );

            case CurrentOrderPaymentListViewItem.paymentTitle:
              return HeaderListTile(context.l10n.paymentMethod);
            case CurrentOrderPaymentListViewItem.paymentDetail:
              return SquareCardListTile(
                isLoading: widget.isLoading,
                squareCard: widget.squareCard,
                selected: widget.selectedPaymentMethod ==
                    CurrentOrderSelectedPaymentMethod.squareCard,
                trailing: Icon(
                  widget.squareCard != null
                      ? Icons.credit_card
                      : Icons.add_card,
                ),
                onTap: (squareCard) {
                  widget.onTapItem?.call(
                    CurrentOrderPaymentListViewItem.paymentDetail,
                  );
                },
                onPressedDelete: (squareCard) {
                  widget.onPressedDeleteSquareCard(squareCard);
                },
              );
            case CurrentOrderPaymentListViewItem.applePayDetail:
              if (widget.canUseApplePay ?? false) {
                return ApplePayListTile(
                  selected: widget.selectedPaymentMethod ==
                      CurrentOrderSelectedPaymentMethod.applePay,
                  onTap: () {
                    widget.onTapItem?.call(
                      CurrentOrderPaymentListViewItem.applePayDetail,
                    );
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            case CurrentOrderPaymentListViewItem.googlePayDetail:
              if (widget.canUseGooglePay ?? false) {
                return GooglePayListTile(
                  selected: widget.selectedPaymentMethod ==
                      CurrentOrderSelectedPaymentMethod.googlePay,
                  onTap: () {
                    widget.onTapItem?.call(
                      CurrentOrderPaymentListViewItem.googlePayDetail,
                    );
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            case CurrentOrderPaymentListViewItem.note:
              return ListTile(
                title: Text(
                  context.l10n.noteTitle,
                  style: context.headerTextStyle,
                ),
                subtitle: TextField(
                  controller: _noteController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: context.l10n.noteHintText,
                  ),
                ),
              );

            case CurrentOrderPaymentListViewItem.totalsHeader:
              return HeaderListTile(context.l10n.totals);
            case CurrentOrderPaymentListViewItem.subtotalDetail:
              return ListTile(
                title: Text(context.l10n.subtotal),
                trailing: Text(
                  order?.formattedSubtotalMoneyAmount(
                        widget.merchant?.currencyCode,
                      ) ??
                      "",
                ),
              );
            case CurrentOrderPaymentListViewItem.taxDetail:
              return ListTile(
                title: Text(context.l10n.tax),
                trailing: Text(
                  order?.formattedTotalTaxMoneyAmount(
                        widget.merchant?.currencyCode,
                      ) ??
                      "",
                ),
              );
            case CurrentOrderPaymentListViewItem.tipDetail:
              return ListTile(
                title: Text(context.l10n.tip),
                trailing: Text(
                  widget.currentOrder?.formattedTipMoneyAmount(
                        widget.merchant?.currencyCode,
                      ) ??
                      "",
                ),
              );
            case CurrentOrderPaymentListViewItem.totalDetail:
              return ListTile(
                title: Text(context.l10n.total),
                trailing: Text(
                  widget.currentOrder?.formattedTotalMoneyPlusTipAmount(
                        widget.merchant?.currencyCode,
                      ) ??
                      "",
                ),
              );
          }
        }
        return null;
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox.shrink();
      },
    );
  }
}
