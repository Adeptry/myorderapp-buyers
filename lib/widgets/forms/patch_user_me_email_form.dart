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
import 'package:myorderapp_square/myorderapp_square.dart';

import '../../constants/widget_constants.dart';
import '../../extensions/build_context_extensions.dart';
import '../../extensions/dart/string_extension.dart';

class PatchUserMeEmailForm extends StatefulWidget {
  final UserEntity? user;
  final Function(String) onPressedSubmit;

  const PatchUserMeEmailForm({
    super.key,
    required this.onPressedSubmit,
    required this.user,
  });

  @override
  State<PatchUserMeEmailForm> createState() => _PatchUserMeEmailFormState();
}

class _PatchUserMeEmailFormState extends State<PatchUserMeEmailForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _textFieldController;

  @override
  initState() {
    super.initState();
    _textFieldController =
        TextEditingController(text: widget.user?.email ?? "");
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: context.l10n.email,
            ),
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
            controller: _textFieldController,
            autofocus: true,
            validator: (value) {
              if (value == null || value.isEmpty || !value.isValidEmail()) {
                return context.l10n.patchUserMeEmailFormInvalidValue;
              }
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
                      widget.onPressedSubmit(_textFieldController.text);
                    }
                  },
                  label: Text(context.l10n.save),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
