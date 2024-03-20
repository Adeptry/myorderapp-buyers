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

class PatchAuthenticationMeForm extends StatefulWidget {
  final void Function({required String oldPassword, required String password})
      onPressedSubmit;

  const PatchAuthenticationMeForm({required this.onPressedSubmit, super.key});

  @override
  State<PatchAuthenticationMeForm> createState() =>
      _PatchAuthMePasswordFormState();
}

class _PatchAuthMePasswordFormState extends State<PatchAuthenticationMeForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _oldPasswordTextFieldController;
  late TextEditingController _passwordTextFieldController;

  @override
  initState() {
    super.initState();

    _oldPasswordTextFieldController = TextEditingController();
    _passwordTextFieldController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordTextFieldController.dispose();
    _passwordTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: l10n.patchAuthenticationMeOldPasswordFormField,
            ),
            obscureText: true,
            autofocus: true,
            controller: _oldPasswordTextFieldController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return context
                    .l10n.patchAuthenticationMeOldPasswordFormInvalidValue;
              }
              // Add any other validation logic here if needed
              return null;
            },
          ),
          const SizedBox(height: WidgetConstants.mediumPaddingDouble),
          TextFormField(
            decoration: InputDecoration(
              labelText: l10n.patchAuthenticationMeNewPasswordFormField,
            ),
            obscureText: true,
            controller: _passwordTextFieldController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return context
                    .l10n.patchAuthenticationMeNewPasswordFormInvalidValue;
              }
              // Add any other validation logic here if needed
              return null;
            },
          ),
          const SizedBox(height: WidgetConstants.largePaddingDouble),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  icon: const Icon(Icons.save),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      widget.onPressedSubmit(
                        oldPassword: _oldPasswordTextFieldController.text,
                        password: _passwordTextFieldController.text,
                      );
                    }
                  },
                  label: Text(l10n.save),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
