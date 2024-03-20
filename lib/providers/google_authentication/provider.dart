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

import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:universal_platform/universal_platform.dart';

import '../authentication_storage/provider.dart';
import '../customer/provider.dart';
import '../logger/provider.dart';
import '../merchant_id_or_path/provider.dart';
import '../moa_options/provider.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class GoogleAuthentication extends _$GoogleAuthentication {
  @override
  GoogleSignIn build() {
    final moaOptions = ref.watch(moaOptionsProvider);
    String? clientId;
    if (UniversalPlatform.isWeb) {
      clientId = moaOptions.googleServerClientId;
    } else if (UniversalPlatform.isIOS) {
      clientId = moaOptions.googleIosClientId;
    }
    final googleSignIn = GoogleSignIn(
      clientId: clientId,
      serverClientId:
          UniversalPlatform.isWeb ? null : moaOptions.googleServerClientId,
      forceCodeForRefreshToken: true,
      scopes: [
        'email',
        'profile',
        'openid',
      ],
    );

    googleSignIn.onCurrentUserChanged.listen(
      (GoogleSignInAccount? account) async {
        await handleOnCurrentUserChanged(account);
      },
    );

    return googleSignIn;
  }

  Future<void> handleOnCurrentUserChanged(GoogleSignInAccount? account) async {
    ref.read(loggerProvider).d("GoogleSignIn.onCurrentUserChanged");
    ref.read(loggerProvider).d(account);
    final merchantIdOrPath = ref.read(merchantIdOrPathProvider);
    final logger = ref.read(loggerProvider);
    final authenticationStorageNotifier =
        ref.read(authenticationStorageProvider.notifier);
    if (account != null) {
      try {
        final GoogleSignInAuthentication authentication =
            await account.authentication;
        final idToken = authentication.idToken;
        logger.d("idToken: $idToken");
        if (idToken == null) {
          logger.e("GoogleSignInAuthentication.idToken was null");
          throw Exception("GoogleSignInAuthentication.idToken was null");
        }

        await authenticationStorageNotifier.postLoginGoogleAndSetOrThrow(
          idToken: idToken,
        );

        final customerStateNotifier = ref.read(
          CustomerProvider(
            merchantIdOrPath: merchantIdOrPath,
          ).notifier,
        );

        try {
          await customerStateNotifier.postAndSetOrThrow(
            merchantIdOrPath: merchantIdOrPath,
          );
          // ignore: empty_catches
        } catch (error) {} // this post is kept just in case the customer is not created yet

        return;
      } catch (error) {
        logger.e("", error: error);
      }
    } else {
      await authenticationStorageNotifier.logout();
      logger.d("Account was null");
    }
  }
}
