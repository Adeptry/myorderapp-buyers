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

class PostPasswordForgotForm extends StatefulWidget {
  final void Function(String?) onPressedSubmit;
  const PostPasswordForgotForm({
    super.key,
    required this.onPressedSubmit,
  });

  @override
  State<PostPasswordForgotForm> createState() => _PostPasswordForgotFormState();
}

class _PostPasswordForgotFormState extends State<PostPasswordForgotForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _email;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            autofocus: true,
            decoration: InputDecoration(labelText: l10n.email),
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.isRequired(l10n.email);
              }
              return null;
            },
            onSaved: (value) {
              _email = value;
            },
          ),
          const SizedBox(height: WidgetConstants.largePaddingDouble),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  icon: const Icon(Icons.password),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      widget.onPressedSubmit(_email);
                    }
                  },
                  label: Text(l10n.resetPassword),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
