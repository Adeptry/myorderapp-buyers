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
import 'package:phone_form_field/phone_form_field.dart';

import '../../constants/widget_constants.dart';
import '../../extensions/build_context_extensions.dart';

class PatchUserMePhoneNumberForm extends StatefulWidget {
  final UserEntity? userState;
  final Function(String?) onPressedSubmit;
  final String countryCode;

  const PatchUserMePhoneNumberForm({
    super.key,
    required this.onPressedSubmit,
    required this.userState,
    required this.countryCode,
  });

  @override
  State<PatchUserMePhoneNumberForm> createState() =>
      _PatchCustomerMePhoneNumberFormState();
}

class _PatchCustomerMePhoneNumberFormState
    extends State<PatchUserMePhoneNumberForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late PhoneController _phoneController;
  final _phoneKey = GlobalKey<FormFieldState<PhoneNumber>>();

  @override
  initState() {
    super.initState();

    _phoneController = PhoneController(null);
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phoneNumber = PhoneNumber.parse(
      widget.userState?.phoneNumber ?? "",
      destinationCountry: IsoCode.fromJson(widget.countryCode),
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (widget.userState != null) ...[
            PhoneFormField(
              enableInteractiveSelection: true,
              showFlagInInput: false,
              autofocus: true,
              initialValue: phoneNumber,
              key: _phoneKey,
              onChanged: (value) {
                _phoneController.value = value;
              },
            ),
          ],
          const SizedBox(height: WidgetConstants.largePaddingDouble),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  icon: const Icon(Icons.save),
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();

                      final phoneNumber =
                          _phoneKey.currentState?.value?.international;
                      widget.onPressedSubmit(phoneNumber);
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
