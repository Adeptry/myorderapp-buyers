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
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:myorderapp_square/myorderapp_square.dart';

import '../../extensions/build_context_extensions.dart';
import '../../extensions/material/date_time_extensions.dart';
import '../../extensions/material/time_of_day_extensions.dart';
import '../../extensions/myorderapp_square/business_hours_period_entity_extensions.dart';
import '../../extensions/myorderapp_square/business_hours_period_entity_list_extensions.dart';
import '../../extensions/myorderapp_square/line_item_entity_extensions.dart';
import '../../providers/current_order/provider.dart';
import '../../providers/merchant/provider.dart';
import '../../providers/merchant_id_or_path/provider.dart';
import '../../providers/moa_firebase/provider.dart';
import '../../routes/catalog/current_order_route_data/current_order_locations_route_data.dart';
import '../../routes/catalog/current_order_route_data/current_order_payment_route_data.dart';
import '../../routes/root_route_data.dart';
import '../../utils/show_exception_dialog.dart';
import '../../utils/show_text_dialog.dart';
import '../bottom_sheets/current_order_review_bottom_sheet.dart';
import '../list_views/current_order_review_list_view.dart';

final currentOrderScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class CurrentOrderReviewScaffold extends ConsumerWidget {
  const CurrentOrderReviewScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final merchantIdOrPath = ref.watch(merchantIdOrPathProvider);
    final currentOrderProvider =
        CurrentOrderProvider(merchantIdOrPath: merchantIdOrPath);
    final currentOrderState = ref.watch(currentOrderProvider);
    final notifier = ref.watch(currentOrderProvider.notifier);

    final merchantState = ref.watch(
      MerchantProvider(
        merchantIdOrPath: merchantIdOrPath,
        xCustomLang: context.locale.languageCode,
      ),
    );
    final merchant = merchantState.valueOrNull;

    return ScaffoldMessenger(
      key: currentOrderScaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.reviewOrder)),
        bottomSheet: CurrentOrderReviewBottomSheet(
          onCheckoutPressed: () {
            _onCheckoutPressed(context, ref);
          },
          state: currentOrderState.value,
          currencyCode: merchant?.currencyCode ?? 'USD',
          setTipMoney: ({
            int? tipMoneyAbsoluteAmount,
            int? tipMoneyPercentage,
          }) {
            notifier.setTipMoney(
              tipMoneyAbsoluteAmount: tipMoneyAbsoluteAmount,
              tipMoneyPercentage: tipMoneyPercentage,
            );
          },
        ),
        body: CurrentOrderReviewListView(
          onTapToSelectLocation: () {
            CurrentOrderLocationsRouteData(
              merchantIdOrPath: merchantIdOrPath,
            ).go(context);
          },
          deleteLineItemOnPress: (lineItem) =>
              _onDeleteMenuItemButtonOnPress(lineItem, context, ref),
          merchant: merchant,
          currentOrder: currentOrderState.valueOrNull,
          onTapDate: () {
            _showDatePicker(context, ref);
          },
          onTapTime: () {
            _showTimePicker(context, ref);
          },
        ),
      ),
    );
  }

  _onCheckoutPressed(BuildContext context, WidgetRef ref) {
    final merchantIdOrPath = ref.read(merchantIdOrPathProvider);
    final currentOrderProvider =
        CurrentOrderProvider(merchantIdOrPath: merchantIdOrPath);
    final currentOrder = ref.read(currentOrderProvider);
    final merchantState = ref.read(
      MerchantProvider(
        merchantIdOrPath: merchantIdOrPath,
        xCustomLang: context.locale.languageCode,
      ),
    );
    final merchant = merchantState.valueOrNull;

    CurrentOrderPaymentRouteData(merchantIdOrPath: merchantIdOrPath)
        .go(context);
    FirebaseAnalytics.instance.logBeginCheckout(
      value: (currentOrder.value?.totalPlusTipMoneyAmount ?? 0) / 100,
      currency: merchant?.currencyCode,
      items: currentOrder.value?.order?.lineItems
          ?.map((e) => e.analyticsEventItem())
          .toList(),
    );
  }

  _onDeleteMenuItemButtonOnPress(
    LineItemEntity lineItem,
    BuildContext context,
    WidgetRef ref,
  ) async {
    final merchantIdOrPath = ref.read(merchantIdOrPathProvider);
    final currentOrderProvider =
        CurrentOrderProvider(merchantIdOrPath: merchantIdOrPath);
    final currentOrderState = ref.read(currentOrderProvider);
    final currentOrderNotifier = ref.read(currentOrderProvider.notifier);
    final merchantState = ref.read(
      MerchantProvider(
        merchantIdOrPath: merchantIdOrPath,
        xCustomLang: context.locale.languageCode,
      ),
    );
    final merchant = merchantState.valueOrNull;
    final order = currentOrderState.valueOrNull?.order;

    final shouldPopAferRemoval = (order?.lineItems?.length ?? 0) == 1;

    context.loaderOverlay.show();
    try {
      await currentOrderNotifier.deleteLineItemOrThrow(
        lineItemId: lineItem.id!,
        merchantIdOrPath: merchantIdOrPath,
      );
      final item = lineItem.analyticsEventItem();
      await MoaFirebase.analytics?.logRemoveFromCart(
        value: (lineItem.totalMoneyAmount ?? 0) / 100,
        currency: merchant?.currencyCode,
        items: [item],
      );
      if (context.mounted) {
        context.loaderOverlay.hide();

        if (shouldPopAferRemoval) {
          context.navigator.pop();
        }
      }
    } catch (error) {
      if (context.mounted) {
        context.loaderOverlay.hide();
        if (error is Exception) {
          await showExceptionDialog(context: context, exception: error);
        } else {
          await showExceptionDialog(
            context: context,
            exception: Exception(error.toString()),
          );
        }
      }
    }
  }

  Future<DateTime?> _showDatePicker(BuildContext context, WidgetRef ref) async {
    final merchantIdOrPath = ref.read(merchantIdOrPathProvider);
    final currentOrderProvider =
        CurrentOrderProvider(merchantIdOrPath: merchantIdOrPath);
    final currentOrderState = ref.read(currentOrderProvider);
    final currentOrderStateNotifier = ref.read(currentOrderProvider.notifier);

    final merchantState = ref.read(
      MerchantProvider(
        merchantIdOrPath: merchantIdOrPath,
        xCustomLang: context.locale.languageCode,
      ),
    );
    final merchant = merchantState.valueOrNull;

    final order = currentOrderState.value?.order;
    final location = order?.location;
    final businessHours = location?.businessHours;
    final nextAvailablePickupDateTime =
        businessHours?.firstPickupDateTimeWithin(
              minutes: merchant?.pickupLeadDurationMinutes?.toInt() ?? 15,
            ) ??
            DateTime.now();

    final pickupDateTime =
        currentOrderState.value?.pickupDateTime ?? nextAvailablePickupDateTime;
    final pickupTimeOfDay = TimeOfDay.fromDateTime(pickupDateTime);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: pickupDateTime,
      firstDate: nextAvailablePickupDateTime,
      selectableDayPredicate: (day) =>
          location?.businessHours?.hasBusinessHoursOn(dayOfWeek: day.weekday) ??
          false,
      lastDate: pickupDateTime.add(
        const Duration(days: 7),
      ),
    );
    if (pickedDate != null) {
      final businessHoursOnPickedDate =
          location?.businessHours?.businessHoursOnDayOfWeek(pickedDate.weekday);
      final currentPickupTimeWithinBusinessHours =
          (businessHoursOnPickedDate?.isWithin(pickupTimeOfDay) ?? false);

      final newTimeOfDay = currentPickupTimeWithinBusinessHours
          ? pickupTimeOfDay
          : businessHoursOnPickedDate?.parsedStartLocalTimeOfDay;

      currentOrderStateNotifier.pickupDateTime =
          pickedDate.copyWith(timeOfDay: newTimeOfDay ?? pickupTimeOfDay);
      return pickedDate;
    }

    return null;
  }

  Future<DateTime?> _showTimePicker(BuildContext context, WidgetRef ref) async {
    final merchantIdOrPath = ref.read(merchantIdOrPathProvider);
    final currentOrderProvider =
        CurrentOrderProvider(merchantIdOrPath: merchantIdOrPath);
    final checkoutState = ref.read(currentOrderProvider);
    final checkoutStateNotifier = ref.read(currentOrderProvider.notifier);

    final merchantState = ref.read(
      MerchantProvider(
        merchantIdOrPath: merchantIdOrPath,
        xCustomLang: context.locale.languageCode,
      ),
    );
    final merchant = merchantState.valueOrNull;

    final order = checkoutState.value?.order;
    final location = order?.location;
    final businessHours = location?.businessHours;

    final pickupAsapOrNowDateTime = checkoutState.value?.pickupOrAsapDateTime(
          leadDurationMinutes: merchant?.pickupLeadDurationMinutes,
        ) ??
        DateTime.now();
    final pickupTimeOfDay = TimeOfDay.fromDateTime(pickupAsapOrNowDateTime);

    final pickedTimeOfDay = await showTimePicker(
      context: context,
      initialTime: pickupTimeOfDay,
    );
    if (pickedTimeOfDay != null) {
      final pickedDateTime =
          pickedTimeOfDay.copyInto(dateTime: pickupAsapOrNowDateTime);
      final businessHoursOnPickedDateTime =
          businessHours?.businessHoursOnDayOfWeek(pickedDateTime.weekday);

      if (businessHours?.isWithin(pickedDateTime) ?? false) {
        checkoutStateNotifier.pickupDateTime =
            pickedTimeOfDay.copyInto(dateTime: pickupAsapOrNowDateTime);
        return pickedDateTime;
      } else if (context.mounted) {
        await showTextDialog(
          context: context,
          title: context.l10n.errorPickupOutsideBusinessHoursTitle,
          content: context.l10n.errorPickupOutsideBusinessHoursContent(
            businessHoursOnPickedDateTime
                    ?.formattedEndLocalTimeOfDay(context) ??
                "",
            businessHoursOnPickedDateTime
                    ?.formattedStartLocalTimeOfDay(context) ??
                "",
          ),
          button: context.l10n.okay,
        );
      }
    }

    return null;
  }
}
