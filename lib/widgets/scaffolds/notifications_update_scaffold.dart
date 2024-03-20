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
import 'package:myorderapp_square/myorderapp_square.dart';

import '../../extensions/build_context_extensions.dart';
import '../../providers/customer/provider.dart';
import '../../providers/merchant_id_or_path/provider.dart';
import '../../utils/show_exception_dialog.dart';
import '../forms/patch_customer_me_notifications_form.dart';
import '../layouts/constrained_centered_column.dart';

class NotificationsUpdateScaffold extends ConsumerWidget {
  const NotificationsUpdateScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final merchantIdOrPath = ref.watch(merchantIdOrPathProvider);
    final customerProvider = CustomerProvider(
      merchantIdOrPath: merchantIdOrPath,
    );
    final customerNotifier = ref.watch(
      customerProvider.notifier,
    );
    final customerState = ref.watch(
      customerProvider,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.patchCustomerMeNotificationsScaffoldTitle),
      ),
      body: customerState.when(
        data: (data) => SingleChildScrollView(
          child: ConstrainedCenteredColumn(
            children: [
              PatchCustomerMeNotificationsForm(
                mailNotifications: data?.mailNotifications ?? false,
                messageNotifications: data?.messageNotifications ?? false,
                pushNotifications: data?.pushNotifications ?? false,
                onChangedMailNotifications: (value) async {
                  try {
                    await customerNotifier.patchOrThrow(
                      merchantIdOrPath: merchantIdOrPath,
                      customerPatchBody: CustomerPatchBody(
                        mailNotifications: value,
                      ),
                    );
                  } catch (error) {
                    if (context.mounted) {
                      _catchError(context, error);
                    }
                  }
                },
                onChangedMessageNotifications: (value) async {
                  try {
                    await customerNotifier.patchOrThrow(
                      merchantIdOrPath: merchantIdOrPath,
                      customerPatchBody: CustomerPatchBody(
                        messageNotifications: value,
                      ),
                    );
                  } catch (error) {
                    if (context.mounted) {
                      _catchError(context, error);
                    }
                  }
                },
                onChangedPushNotifications: (value) async {
                  try {
                    await customerNotifier.patchOrThrow(
                      merchantIdOrPath: merchantIdOrPath,
                      customerPatchBody: CustomerPatchBody(
                        pushNotifications: value,
                      ),
                    );
                  } catch (error) {
                    if (context.mounted) {
                      _catchError(context, error);
                    }
                  }
                },
              ),
            ],
          ),
        ),
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  _catchError(BuildContext context, Object error) {
    if (error is Exception) {
      showExceptionDialog(context: context, exception: error);
    } else {
      showExceptionDialog(
        context: context,
        exception: Exception(error.toString()),
      );
    }
  }
}
