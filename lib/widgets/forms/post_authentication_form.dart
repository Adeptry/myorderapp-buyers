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
import '../../extensions/dart/string_extension.dart';
import '../../utils/show_bottom_page.dart';
import '../scaffolds/password_forgot_scaffold.dart';

class PostAuthenticationForm extends StatefulWidget {
  final bool isRegister;
  final Function() toggleAuthenticationType;
  final void Function({String? email, String? password}) onPressedSubmit;

  const PostAuthenticationForm({
    required this.isRegister,
    required this.toggleAuthenticationType,
    required this.onPressedSubmit,
    super.key,
  });

  @override
  State<PostAuthenticationForm> createState() => _PostAuthenticationFormState();
}

class _PostAuthenticationFormState extends State<PostAuthenticationForm> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  FormState? get _formState => _formStateKey.currentState;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Form(
      key: _formStateKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: l10n.email),
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
            autocorrect: false,
            validator: (value) {
              if (value == null || value.isEmpty || !value.isValidEmail()) {
                return context.l10n.postAuthenticationFormInvalidEmail;
              }
              return null;
            },
            onSaved: (value) {
              _email = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: l10n.password),
            obscureText: true,
            textCapitalization: TextCapitalization.none,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return context.l10n.postAuthenticationFormInvalidPassword;
              }
              return null;
            },
            onSaved: (value) {
              _password = value;
            },
          ),
          const SizedBox(height: WidgetConstants.largePaddingDouble),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  icon: const Icon(Icons.login),
                  onPressed: () async {
                    if (_formState != null) {
                      if (_formState!.validate()) {
                        _formState!.save();
                        widget.onPressedSubmit(
                          email: _email,
                          password: _password,
                        );
                      }
                    }
                  },
                  label: Text(widget.isRegister ? l10n.register : l10n.logIn),
                ),
              ),
            ],
          ),
          const SizedBox(height: WidgetConstants.defaultPaddingDouble),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  child: Text(l10n.passwordForgot),
                  onPressed: () {
                    showFullHeightModalBottomSheet(
                      context: context,
                      child: const PasswordForgotScaffold(),
                    );
                  },
                ),
              ),
              Expanded(
                child: TextButton(
                  child: Text(widget.isRegister ? l10n.logIn : l10n.register),
                  onPressed: () => widget.toggleAuthenticationType(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
