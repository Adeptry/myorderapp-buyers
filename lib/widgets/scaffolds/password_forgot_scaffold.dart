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
import '../../providers/apis/provider.dart';
import '../../utils/show_exception_dialog.dart';
import '../forms/post_password_forgot_form.dart';
import '../layouts/constrained_centered_column.dart';

class PasswordForgotScaffold extends ConsumerWidget {
  const PasswordForgotScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.passwordForgot),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(WidgetConstants.defaultPaddingDouble),
          child: ConstrainedCenteredColumn(
            children: [
              PostPasswordForgotForm(
                onPressedSubmit: (email) async {
                  context.loaderOverlay.show();
                  if (email != null) {
                    try {
                      await ref
                          .read(authenticationApiProvider)
                          .postPasswordForgot(
                            authenticationPasswordForgotRequestBody:
                                AuthenticationPasswordForgotRequestBody(
                              email: email,
                            ),
                          );
                      if (context.mounted) {
                        context.loaderOverlay.hide();
                        await context
                            .showSnackBarText(
                              context.l10n.passwordForgotSuccess,
                            )
                            .closed
                            .then(
                              (value) => {
                                context.pop(),
                              },
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
