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
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../constants/widget_constants.dart';
import '../../extensions/build_context_extensions.dart';
import '../../extensions/material/scaffold_messenger_extensions.dart';
import '../../providers/authentication_storage/provider.dart';
import '../../utils/show_exception_dialog.dart';
import '../forms/patch_authentication_me_form.dart';
import '../layouts/constrained_centered_column.dart';
import 'account_scaffold.dart';

class PasswordUpdateScaffold extends ConsumerStatefulWidget {
  const PasswordUpdateScaffold({super.key});

  @override
  ConsumerState<PasswordUpdateScaffold> createState() =>
      _PasswordUpdateScaffoldState();
}

class _PasswordUpdateScaffoldState
    extends ConsumerState<PasswordUpdateScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.patchAuthenticationMeScaffoldTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(WidgetConstants.defaultPaddingDouble),
          child: ConstrainedCenteredColumn(
            children: [
              PatchAuthenticationMeForm(
                onPressedSubmit: ({
                  required String oldPassword,
                  required String password,
                }) {
                  _onPressedSubmit(context, ref, oldPassword, password);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onPressedSubmit(
    BuildContext context,
    WidgetRef ref,
    String oldPassword,
    String password,
  ) async {
    final authenticationStateNotifier =
        ref.read(authenticationStorageProvider.notifier);
    context.loaderOverlay.show();
    try {
      await authenticationStateNotifier.patchAuthenticationMeOrThrow(
        oldPassword: oldPassword,
        password: password,
      );
      if (context.mounted) {
        context.loaderOverlay.hide();
        context.pop();
        accountScaffoldMessengerKey.currentState?.showSnackBarText(
          context.l10n.patchAuthenticationMeOnSubmitResponseSnackbar,
        );
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
}
