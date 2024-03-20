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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../extensions/build_context_extensions.dart';
import '../../providers/authentication_storage/provider.dart';
import '../../providers/customer/provider.dart';
import '../../providers/merchant/provider.dart';
import '../../providers/merchant_id_or_path/provider.dart';
import '../../providers/moa_options/state.dart';
import '../../providers/user/provider.dart';
import '../../routes/account/account_email_route_data.dart';
import '../../routes/account/account_name_route_data.dart';
import '../../routes/account/account_notifications_route_data.dart';
import '../../routes/account/account_password_route_data.dart';
import '../../routes/account/account_phone_route_data.dart';
import '../../routes/account/payment_methods_route_data/index.dart';
import '../../routes/catalog/index_route_data.dart';
import '../../routes/root_route_data.dart';
import '../../utils/moa_launch_url.dart';
import '../../utils/show_confirm_dialog.dart';
import '../../utils/show_confirm_if_matches_dialog.dart';
import '../../utils/show_exception_dialog.dart';
import '../list_views/account_list_view.dart';

final accountScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class AccountScaffold extends ConsumerWidget {
  const AccountScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final merchantIdOrPath = ref.watch(merchantIdOrPathProvider);
    final merchant = ref.watch(
      MerchantProvider(merchantIdOrPath: merchantIdOrPath),
    );
    final userState = ref.watch(UserProvider());
    return ScaffoldMessenger(
      key: accountScaffoldMessengerKey,
      child: Scaffold(
        body: AccountListView(
          userState: userState.valueOrNull,
          countryCode: merchant.value?.countryCode ?? "US",
          onTapItem: (item) => _onTapItem(item, context, ref),
        ),
      ),
    );
  }

  _onTapItem(
    AccountListViewItem item,
    BuildContext context,
    WidgetRef ref,
  ) async {
    final merchantIdOrPath = ref.read(merchantIdOrPathProvider);
    final userState = ref.read(UserProvider());
    final authenticationStateNotifier =
        ref.read(authenticationStorageProvider.notifier);
    switch (item) {
      case AccountListViewItem.name:
        AccountNameRouteData(merchantIdOrPath: merchantIdOrPath).go(context);
        break;
      case AccountListViewItem.email:
        AccountEmailRouteData(merchantIdOrPath: merchantIdOrPath).go(context);
        break;
      case AccountListViewItem.phoneNumber:
        AccountPhoneRouteData(merchantIdOrPath: merchantIdOrPath).go(context);
        break;
      case AccountListViewItem.passwordChange:
        AccountPasswordRouteData(merchantIdOrPath: merchantIdOrPath)
            .go(context);
        break;
      case AccountListViewItem.passwordForgot:
        if (userState.value?.email != null) {
          context.loaderOverlay.show();
          try {
            await authenticationStateNotifier.postPasswordForgotOrThrow(
              email: userState.value!.email!,
            );

            if (context.mounted) {
              context.loaderOverlay.hide();
              context.showSnackBarText(context.l10n.passwordForgotSuccess);
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
        break;
      case AccountListViewItem.paymentMethods:
        if (context.mounted) {
          PaymentsMethodsRouteData(merchantIdOrPath: merchantIdOrPath)
              .go(context);
        }

        break;
      case AccountListViewItem.notifications:
        if (context.mounted) {
          AccountNotificationsRouteData(merchantIdOrPath: merchantIdOrPath)
              .go(context);
        }
        break;
      case AccountListViewItem.signOut:
        if (context.mounted) {
          await showConfirmDialog(
            context: context,
            title: context.l10n.signOutDialogTitle,
            content: context.l10n.signOutDialogContent,
            cancelText: context.l10n.signOutDialogCancel,
            confirmText: context.l10n.signOutDialogConfirm,
            onPressedConfirm: () async {
              final authenticationNotifier =
                  ref.read(authenticationStorageProvider.notifier);
              await authenticationNotifier.logout();
              if (context.mounted) {
                CatalogRouteData(merchantIdOrPath: merchantIdOrPath)
                    .go(context);
              }
            },
          );
        }

        break;
      case AccountListViewItem.delete:
        if (context.mounted) {
          await showConfirmIfInputMatchesDialog(
            context: context,
            title: context.l10n.deleteCustomerMeConfirmDialogTitle,
            content: context.l10n.deleteCustomerMeConfirmDialogContent,
            cancelText: context.l10n.deleteCustomerMeConfirmDialogCancel,
            confirmText: context.l10n.deleteCustomerMeConfirmDialogConfirm,
            inputText: userState.value?.email ?? "",
            labelText: context.l10n.deleteCustomerMeSuccessDialogLabel,
            onPressedConfirm: () async {
              final customerStateNotifier = ref.read(
                CustomerProvider(merchantIdOrPath: merchantIdOrPath).notifier,
              );
              final authenticationNotifier =
                  ref.read(authenticationStorageProvider.notifier);
              context.loaderOverlay.show();
              try {
                await customerStateNotifier.deleteOrThrow(
                  merchantIdOrPath: merchantIdOrPath,
                );
                await authenticationNotifier.logout();
                if (context.mounted) {
                  context.loaderOverlay.hide();
                  CatalogRouteData(merchantIdOrPath: merchantIdOrPath)
                      .go(context);
                }
              } catch (error) {
                if (context.mounted) {
                  context.loaderOverlay.hide();
                  if (error is Exception) {
                    await showExceptionDialog(
                      context: context,
                      exception: error,
                    );
                  } else {
                    await showExceptionDialog(
                      context: context,
                      exception: Exception(error.toString()),
                    );
                  }
                }
              }
            },
          );
        }
        break;
      case AccountListViewItem.about:
        if (context.mounted) {
          showAboutDialog(
            context: context,
            applicationVersion: MoaOptionsState.version,
            applicationLegalese: MoaOptionsState.legalese,
          );
        }
        break;
      case AccountListViewItem.terms:
        if (context.mounted) {
          await moaLaunchUrl(
            context,
            MoaOptionsState.termsUrl,
          );
        }

        break;
      case AccountListViewItem.privacy:
        if (context.mounted) {
          await moaLaunchUrl(
            context,
            MoaOptionsState.privacyUrl,
          );
        }

        break;
    }
  }
}
