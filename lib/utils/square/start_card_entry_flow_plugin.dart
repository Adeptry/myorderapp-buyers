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
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../extensions/square_in_app_payments/ios_theme_extensions.dart';

Future<void> squareStartCardEntryFlow({
  required BuildContext context,
  required String applicationId,
  required Function({
    String? sourceId,
    String? verificationToken,
  }) onResult,
}) async {
  await InAppPayments.setSquareApplicationId(applicationId);
  if (UniversalPlatform.isIOS && context.mounted) {
    await _setIOSCardEntryTheme(context);
  }
  await InAppPayments.startCardEntryFlow(
    onCardNonceRequestSuccess: (cardDetails) {
      InAppPayments.completeCardEntry(
        onCardEntryComplete: () {
          onResult(sourceId: cardDetails.nonce, verificationToken: null);
        },
      );
    },
    onCardEntryCancel: () => onResult(),
  );
}

Future _setIOSCardEntryTheme(BuildContext context) async {
  await InAppPayments.setIOSCardEntryTheme(
    IOSThemesExtensions.fromContext(context),
  );
}
