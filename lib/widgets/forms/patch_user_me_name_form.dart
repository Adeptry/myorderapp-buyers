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

class PatchUserMeNameForm extends StatefulWidget {
  final UserEntity? user;
  final void Function({String? firstName, String? lastName}) onPressedSubmit;

  const PatchUserMeNameForm({
    super.key,
    required this.user,
    required this.onPressedSubmit,
  });

  @override
  State<PatchUserMeNameForm> createState() => _PatchUserMeNameFormState();
}

class _PatchUserMeNameFormState extends State<PatchUserMeNameForm> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  late TextEditingController _firstNameTextFieldController;
  late TextEditingController _lastNameTextFieldController;

  @override
  initState() {
    super.initState();

    _firstNameTextFieldController =
        TextEditingController(text: widget.user?.firstName ?? "");
    _lastNameTextFieldController =
        TextEditingController(text: widget.user?.lastName ?? "");
  }

  @override
  void dispose() {
    _firstNameTextFieldController.dispose();
    _lastNameTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formStateKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: context.l10n.firstName,
            ),
            controller: _firstNameTextFieldController,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return context.l10n.patchUserMeFirstNameFormInvalidValue;
              }
              return null;
            },
          ),
          const SizedBox(height: WidgetConstants.mediumPaddingDouble),
          TextFormField(
            decoration: InputDecoration(
              labelText: context.l10n.lastName,
            ),
            controller: _lastNameTextFieldController,
            textCapitalization: TextCapitalization.words,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return context.l10n.patchUserMeLastNameFormInvalidValue;
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
                    if (_formStateKey.currentState?.validate() ?? false) {
                      _formStateKey.currentState?.save();
                      widget.onPressedSubmit(
                        firstName: _firstNameTextFieldController.text,
                        lastName: _lastNameTextFieldController.text,
                      );
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
