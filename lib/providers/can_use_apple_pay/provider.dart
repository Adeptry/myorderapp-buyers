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

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:universal_platform/universal_platform.dart';

import '../moa_options/provider.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class CanUseApplePay extends _$CanUseApplePay {
  @override
  Future<bool> build() async {
    final moaOptions = ref.watch(moaOptionsProvider);
    var canUseApplePay = false;
    if (UniversalPlatform.isIOS && moaOptions.applePayMerchantId != null) {
      await InAppPayments.initializeApplePay(
        moaOptions.applePayMerchantId!,
      );
      canUseApplePay = await InAppPayments.canUseApplePay;
    }
    return canUseApplePay;
  }
}
