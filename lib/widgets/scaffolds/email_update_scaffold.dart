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
import 'package:myorderapp_square/myorderapp_square.dart';

import '../../constants/widget_constants.dart';
import '../../extensions/build_context_extensions.dart';
import '../../extensions/material/scaffold_messenger_extensions.dart';
import '../../providers/user/provider.dart';
import '../../utils/show_exception_dialog.dart';
import '../forms/patch_user_me_email_form.dart';
import '../layouts/constrained_centered_column.dart';
import 'account_scaffold.dart';

class EmailUpdateScaffold extends ConsumerWidget {
  const EmailUpdateScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProvider = UserProvider();
    final user = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.patchUserMeEmailScaffoldTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(WidgetConstants.defaultPaddingDouble),
          child: ConstrainedCenteredColumn(
            children: [
              PatchUserMeEmailForm(
                user: user.value,
                onPressedSubmit: (email) async {
                  final userStateNotifier = ref.read(userProvider.notifier);

                  context.loaderOverlay.show();
                  try {
                    await userStateNotifier.patchAndSetOrThrow(
                      body: UserPatchBody(email: email),
                    );
                    if (context.mounted) {
                      context.loaderOverlay.hide();
                      context.pop();
                      accountScaffoldMessengerKey.currentState
                          ?.showSnackBarText(
                        context
                            .l10n.patchUserMeEmailFormOnSubmitResponseSnackbar,
                      );
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
