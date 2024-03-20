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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:myorderapp_square/myorderapp_square.dart';
import 'package:square_in_app_payments/google_pay_constants.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';

import '../../extensions/app_localization_extensions.dart';
import '../../extensions/build_context_extensions.dart';
import '../../extensions/myorderapp_square/line_item_entity_extensions.dart';
import '../../providers/can_use_apple_pay/provider.dart';
import '../../providers/can_use_google_pay/provider.dart';
import '../../providers/current_order/provider.dart';
import '../../providers/customer/provider.dart';
import '../../providers/logger/provider.dart';
import '../../providers/merchant/provider.dart';
import '../../providers/merchant_id_or_path/provider.dart';
import '../../providers/moa_firebase/provider.dart';
import '../../providers/moa_options/provider.dart';
import '../../providers/square_cards_delta/delete_provider.dart';
import '../../providers/square_cards_delta/post_provider.dart';
import '../../providers/user/provider.dart';
import '../../routes/orders/order_route_data.dart';
import '../../routes/root_route_data.dart';
import '../../utils/show_bottom_page.dart';
import '../../utils/show_error_dialog.dart';
import '../../utils/show_exception_dialog.dart';
import '../../utils/show_text_dialog.dart';
import '../../utils/square/start_card_entry_flow_plugin.dart'
    if (dart.library.html) '../../utils/square/start_card_entry_flow_web.dart';
import '../bottom_sheets/current_order_payment_bottom_sheet.dart';
import '../list_views/current_order_payment_list_view.dart';
import 'name_update_scaffold.dart';
import 'phone_number_update_scaffold.dart';
import 'square_cards_scaffold.dart';

enum CurrentOrderSelectedPaymentMethod {
  squareCard,
  googlePay,
  applePay,
  none,
}

class CurrentOrderPaymentScaffold extends ConsumerStatefulWidget {
  const CurrentOrderPaymentScaffold({super.key});

  @override
  ConsumerState<CurrentOrderPaymentScaffold> createState() =>
      _CurrentOrderPaymentScaffoldState();
}

class _CurrentOrderPaymentScaffoldState
    extends ConsumerState<CurrentOrderPaymentScaffold> {
  CurrentOrderSelectedPaymentMethod selectedPaymentMethod =
      CurrentOrderSelectedPaymentMethod.none;
  bool processingPayment = false;

  @override
  Widget build(BuildContext context) {
    final logger = ref.watch(loggerProvider);
    final merchantIdOrPath = ref.watch(merchantIdOrPathProvider);
    final customerState = ref.watch(
      CustomerProvider(
        merchantIdOrPath: merchantIdOrPath,
      ),
    );
    final merchantState = ref.watch(
      MerchantProvider(
        merchantIdOrPath: merchantIdOrPath,
        xCustomLang: context.locale.languageCode,
      ),
    );
    final userState = ref.watch(UserProvider());

    final squareCardsPosted = ref.watch(squarePostCardsProvider);
    if (customerState.valueOrNull?.preferredSquareCard != null) {
      squareCardsPosted.add(customerState.valueOrNull!.preferredSquareCard!);
    }

    final squareDeleteCardsNotifier =
        ref.read(squareDeleteCardsProvider.notifier);
    final squareDeleteCardsState = ref.watch(squareDeleteCardsProvider);
    final preferredSquareCard = squareCardsPosted
        .where((postedCard) {
          return !squareDeleteCardsState
              .any((deletedCard) => deletedCard.id == postedCard.id);
        })
        .toList()
        .lastOrNull;

    final currentOrderProvider =
        CurrentOrderProvider(merchantIdOrPath: merchantIdOrPath);
    final currentOrderState = ref.watch(currentOrderProvider);
    final currentOrderNotifier = ref.watch(currentOrderProvider.notifier);
    final currentOrderValueOrNull = currentOrderState.valueOrNull;

    final canUseGooglePayState = ref.watch(
      CanUseGooglePayProvider(
        currentOrderValueOrNull?.order?.location?.squareId,
      ),
    );
    final canUseGooglePay = canUseGooglePayState.valueOrNull;

    final canUseApplePayState = ref.watch(
      canUseApplePayProvider,
    );
    final canUseApplePay = canUseApplePayState.valueOrNull;

    if (!customerState.isLoading) {
      if (selectedPaymentMethod == CurrentOrderSelectedPaymentMethod.none) {
        setState(() {
          if (preferredSquareCard != null) {
            selectedPaymentMethod =
                CurrentOrderSelectedPaymentMethod.squareCard;
          } else if (canUseApplePay ?? false) {
            selectedPaymentMethod = CurrentOrderSelectedPaymentMethod.applePay;
          } else if (canUseGooglePay ?? false) {
            selectedPaymentMethod = CurrentOrderSelectedPaymentMethod.googlePay;
          }
        });
      } else if (selectedPaymentMethod ==
              CurrentOrderSelectedPaymentMethod.squareCard &&
          preferredSquareCard == null) {
        setState(() {
          if (canUseApplePay ?? false) {
            selectedPaymentMethod = CurrentOrderSelectedPaymentMethod.applePay;
          } else if (canUseGooglePay ?? false) {
            selectedPaymentMethod = CurrentOrderSelectedPaymentMethod.googlePay;
          } else {
            selectedPaymentMethod =
                CurrentOrderSelectedPaymentMethod.none; //likely deletion
          }
        });
      }
    }

    final currencyCode = merchantState.value?.currencyCode ?? "USD";
    final countryCode = merchantState.value?.countryCode ?? "US";

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.checkout)),
      body: CurrentOrderPaymentListView(
        isLoading: customerState.isLoading,
        user: userState.valueOrNull,
        customer: customerState.valueOrNull,
        squareCard: preferredSquareCard,
        merchant: merchantState.valueOrNull,
        currentOrder: currentOrderValueOrNull,
        canUseApplePay: canUseApplePay,
        canUseGooglePay: canUseGooglePay,
        selectedPaymentMethod: selectedPaymentMethod,
        onPressedDeleteSquareCard: (squareCard) {
          squareDeleteCardsNotifier.deleteOrThrow(
            merchantIdOrPath: merchantIdOrPath,
            squareCard: squareCard,
          );
        },
        onTapItem: (item) => _onTapItem(item, preferredSquareCard),
        onNoteChanged: (note) => currentOrderNotifier.setNote(note),
      ),
      bottomSheet: CurrentOrderPaymentBottomSheet(
        isLoading: customerState.isLoading || processingPayment,
        preferredSquareCard: preferredSquareCard,
        selectedPaymentMethod: selectedPaymentMethod,
        onPressedPay: () async {
          logger.i("onPressedPay start");
          if (processingPayment == true) {
            logger.e(
              "ON PRESSED PAY MULTIPLE INVOCATIONS WHILE PROCESSING PAYMENT",
            );
            return;
          }
          setState(() {
            processingPayment = true;
          });
          switch (selectedPaymentMethod) {
            case CurrentOrderSelectedPaymentMethod.googlePay:
              await _onPressedGooglePay(
                price: currentOrderValueOrNull!
                    .totalPlusTipMoneyAmountToStringAsFixedInCurrency(
                  currencyCode,
                )!,
                currencyCode: currencyCode,
              );
              break;
            case CurrentOrderSelectedPaymentMethod.applePay:
              await _onPressedApplePay(
                price: currentOrderValueOrNull!
                    .totalPlusTipMoneyAmountToStringAsFixedInCurrency(
                  currencyCode,
                )!,
                currencyCode: currencyCode,
                countryCode: countryCode,
                summaryLabel:
                    'Order from ${merchantState.value?.squareBusinessName}',
              );
              break;
            case CurrentOrderSelectedPaymentMethod.squareCard:
              await _postPayment(preferredSquareCard!.id!);
            case CurrentOrderSelectedPaymentMethod.none:
              break;
          }
          setState(() {
            processingPayment = false;
          });
          logger.i("onPressedPay end");
        },
        onPressedCreateSquareCard: () => _onTapCreateSquareCard(),
      ),
    );
  }

  Future<void> _onPressedApplePay({
    required String price,
    required String summaryLabel,
    required String currencyCode,
    required String countryCode,
  }) async {
    final moaOptions = ref.read(moaOptionsProvider);
    final logger = ref.read(loggerProvider);
    final completer = Completer<void>();

    await InAppPayments.setSquareApplicationId(
      moaOptions.squareApplicationId,
    );
    await InAppPayments.requestApplePayNonce(
      price: price,
      summaryLabel: summaryLabel,
      countryCode: countryCode,
      currencyCode: currencyCode,
      paymentType: ApplePayPaymentType.finalPayment,
      onApplePayNonceRequestSuccess: (cardDetails) async {
        try {
          await _postPayment(cardDetails.nonce);
          await InAppPayments.completeApplePayAuthorization(isSuccess: true);
          completer.complete();
        } on Exception catch (error) {
          await InAppPayments.completeApplePayAuthorization(
            isSuccess: false,
            errorMessage: error.toString(),
          );
          completer.completeError(error);
        }
      },
      onApplePayNonceRequestFailure: (error) async {
        await InAppPayments.completeApplePayAuthorization(
          isSuccess: false,
          errorMessage: error.message,
        );
        completer.completeError(error);
      },
      onApplePayComplete: () {},
    );

    try {
      await completer.future;
    } on Exception catch (exception) {
      logger.e("", error: exception);
      if (context.mounted) {
        await showExceptionDialog(context: context, exception: exception);
      }
    } on Error catch (error) {
      logger.e("", error: error);
      if (context.mounted) {
        await showErrorDialog(context: context, error: error);
      }
    }
  }

  Future<void> _onPressedGooglePay({
    required String price,
    required String currencyCode,
  }) async {
    final logger = ref.read(loggerProvider);
    final completer = Completer<void>();
    try {
      final moaOptions = ref.read(moaOptionsProvider);
      await InAppPayments.setSquareApplicationId(
        moaOptions.squareApplicationId,
      );

      await InAppPayments.requestGooglePayNonce(
        price: price,
        priceStatus: totalPriceStatusFinal,
        currencyCode: currencyCode,
        onGooglePayNonceRequestSuccess: (cardDetails) async {
          try {
            await _postPayment(cardDetails.nonce);
            completer.complete();
          } catch (error) {
            completer.completeError(error);
          }
        },
        onGooglePayNonceRequestFailure: (error) async {
          completer.completeError(error);
        },
        onGooglePayCanceled: () {
          completer.complete();
        },
      );
    } catch (error) {
      completer.completeError(error);
    }

    try {
      await completer.future;
    } on Exception catch (exception) {
      logger.e("", error: exception);
      if (context.mounted) {
        await showExceptionDialog(context: context, exception: exception);
      }
    } on Error catch (error) {
      logger.e("", error: error);
      if (context.mounted) {
        await showErrorDialog(context: context, error: error);
      }
    } on ErrorInfo catch (errorInfo) {
      logger.e("", error: errorInfo);
      if (context.mounted) {
        await showTextDialog(
          context: context,
          title: context.l10n.errorTitleFor(null),
          content: errorInfo.message,
          button: context.l10n.okay,
        );
      }
    }
  }

  Future<void> _postPayment(
    String paymentSquareId,
  ) async {
    final merchantIdOrPath = ref.read(merchantIdOrPathProvider);

    final merchantState = ref.read(
      MerchantProvider(
        merchantIdOrPath: merchantIdOrPath,
        xCustomLang: context.locale.languageCode,
      ),
    );
    final currencyCode = merchantState.value?.currencyCode;
    final currentOrderProvider =
        CurrentOrderProvider(merchantIdOrPath: merchantIdOrPath);
    final currentOrderState = ref.read(currentOrderProvider);
    final currentOrderNotifier = ref.read(currentOrderProvider.notifier);
    final currentOrder = currentOrderState.value;

    if (currencyCode == null || currentOrder == null) {
      await showExceptionDialog(
        context: context,
        exception: Exception(
          context.l10n.exceptionOrderNull,
        ),
      );
      return;
    }

    context.loaderOverlay.show();
    try {
      final result = await currentOrderNotifier.postPaymentAndSetOrThrow(
        merchantIdOrPath: merchantIdOrPath,
        paymentSquareId: paymentSquareId,
        xCustomLang: context.locale.languageCode,
      );

      await MoaFirebase.analytics?.logPurchase(
        currency: currencyCode,
        value: currentOrder
            .totalPlusTipMoneyAmountToDoubleInCurrency(currencyCode),
        items: currentOrder.order?.lineItems
            ?.map((e) => e.analyticsEventItem())
            .toList(),
        tax: (currentOrderState.value?.order?.totalTaxMoneyAmount ?? 0) / 100,
      );

      if (context.mounted && result.id != null) {
        context.loaderOverlay.hide();

        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.navigator.pop();
          context.navigator.pop();
          final orderRoute = OrderRouteData(
            merchantIdOrPath: merchantIdOrPath,
            orderId: result.id!,
          );
          orderRoute.go(context);
        });
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

  _onTapCreateSquareCard() async {
    final moaOptions = ref.read(moaOptionsProvider);

    await squareStartCardEntryFlow(
      applicationId: moaOptions.squareApplicationId,
      context: context,
      onResult: ({sourceId, verificationToken}) async {
        if (sourceId != null) {
          final merchantIdOrPath = ref.read(merchantIdOrPathProvider);
          final squarePostCardsNotifier =
              ref.read(squarePostCardsProvider.notifier);

          context.loaderOverlay.show();
          try {
            await squarePostCardsNotifier.postOrThrow(
              merchantIdOrPath: merchantIdOrPath,
              cardsPostBody: CardsPostBody(
                sourceId: sourceId,
                verificationToken: verificationToken,
              ),
              xCustomLang: context.locale.languageCode,
            );
            await MoaFirebase.analytics?.logAddPaymentInfo();
            if (context.mounted) {
              context.loaderOverlay.hide();
            }
            setState(() {
              selectedPaymentMethod =
                  CurrentOrderSelectedPaymentMethod.squareCard;
            });
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
      },
    );
  }

  _onTapItem(
    CurrentOrderPaymentListViewItem item,
    SquareCard? preferredSquareCard,
  ) {
    switch (item) {
      case CurrentOrderPaymentListViewItem.paymentDetail:
        if (preferredSquareCard == null) {
          _onTapCreateSquareCard();
        } else if (selectedPaymentMethod !=
            CurrentOrderSelectedPaymentMethod.squareCard) {
          setState(() {
            selectedPaymentMethod =
                CurrentOrderSelectedPaymentMethod.squareCard;
          });
        } else {
          showFullHeightModalBottomSheet(
            context: context,
            child: const SquareCardsScaffold(),
          );
        }
        break;
      case CurrentOrderPaymentListViewItem.recipientNameDetail:
        showFullHeightModalBottomSheet(
          context: context,
          child: const NameUpdateScaffold(),
        );
        break;
      case CurrentOrderPaymentListViewItem.recipientPhoneDetail:
        showFullHeightModalBottomSheet(
          context: context,
          child: const PhoneNumberUpdateScaffold(),
        );
      case CurrentOrderPaymentListViewItem.applePayDetail:
        setState(() {
          selectedPaymentMethod = CurrentOrderSelectedPaymentMethod.applePay;
        });
        break;
      case CurrentOrderPaymentListViewItem.googlePayDetail:
        setState(() {
          selectedPaymentMethod = CurrentOrderSelectedPaymentMethod.googlePay;
        });
        break;
      default:
        break;
    }
  }
}
