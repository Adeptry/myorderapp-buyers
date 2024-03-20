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

import '../../extensions/build_context_extensions.dart';

enum PatchCustomerNotificationType {
  mailNotifications,
  messageNotifications,
  pushNotifications,
}

class PatchCustomerMeNotificationsForm extends StatefulWidget {
  final bool mailNotifications;
  final Function(bool value) onChangedMailNotifications;
  final bool messageNotifications;
  final Function(bool value) onChangedMessageNotifications;
  final bool pushNotifications;
  final Function(bool value) onChangedPushNotifications;

  const PatchCustomerMeNotificationsForm({
    required this.mailNotifications,
    required this.pushNotifications,
    required this.messageNotifications,
    required this.onChangedMailNotifications,
    required this.onChangedMessageNotifications,
    required this.onChangedPushNotifications,
    super.key,
  });

  @override
  State<PatchCustomerMeNotificationsForm> createState() =>
      _PatchCustomerMeNotificationsFormState();
}

class _PatchCustomerMeNotificationsFormState
    extends State<PatchCustomerMeNotificationsForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SwitchListTile(
            title: Text(context.l10n.email),
            value: widget.mailNotifications,
            onChanged: (value) {
              widget.onChangedMailNotifications(
                value,
              );
            },
          ),
          SwitchListTile(
            title: Text(context.l10n.sms),
            value: widget.messageNotifications,
            onChanged: (value) {
              widget.onChangedMessageNotifications(
                value,
              );
            },
          ),
          SwitchListTile(
            title: Text(context.l10n.push),
            value: widget.pushNotifications,
            onChanged: (value) {
              widget.onChangedPushNotifications(
                value,
              );
            },
          ),
        ],
      ),
    );
  }
}
