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

import 'package:myorderapp_square/myorderapp_square.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../extensions/dart/num_extensions.dart';
import '../../../../extensions/dart/string_extension.dart';
import '../base_client/provider.dart';
import '../flutter_secure_storage/provider.dart';
import '../google_authentication/provider.dart';
import '../logger/provider.dart';
import '../platform_messaging_service/stream_provider.dart';
import 'state.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class AuthenticationStorage extends _$AuthenticationStorage {
  static const String accessTokenKey = "MOA_ACCESS_TOKEN";
  static const String refreshTokenKey = "MOA_REFRESH_TOKEN";
  static const String expiresAtTokenKey = "MOA_EXPIRES_AT";

  String? accessTokenState() => state.accessToken;
  String? refreshTokenState() => state.refreshToken;
  DateTime? expiresAtState() => state.expiresAt;

  @override
  AuthenticationStorageState build() {
    _read();

    ref.listen(
      platformMessagingProvider,
      (previous, next) {
        handlePlatformMessage(next.value);
      },
    );

    return const AuthenticationStorageState();
  }

  Future<void> postEmailLoginAndSetOrThrow({
    required String email,
    required String password,
    String? xCustomLang,
  }) async {
    final api = ref.read(baseClientProvider).getAuthenticationApi();
    try {
      final response = await api.postEmailLogin(
        authenticationEmailLoginRequestBody:
            AuthenticationEmailLoginRequestBody(
          email: email,
          password: password,
        ),
      );
      if (response.data != null) {
        await write(loginResponse: response.data!);
      }
    } catch (error) {
      ref.read(loggerProvider).e("", error: error);
      rethrow;
    }
  }

  Future<void> patchAuthenticationMeOrThrow({
    required String oldPassword,
    required String password,
    String? xCustomLang,
  }) async {
    final api = ref.read(baseClientProvider).getAuthenticationApi();
    try {
      await api.patchAuthMe(
        authenticationUpdateRequestBody: AuthenticationUpdateRequestBody(
          oldPassword: oldPassword,
          password: password,
        ),
      );
    } catch (error) {
      ref.read(loggerProvider).e("", error: error);
      rethrow;
    }
  }

  Future<void> postEmailRegisterAndSetOrThrow({
    required String email,
    required String password,
    String? xCustomLang,
  }) async {
    final api = ref.read(baseClientProvider).getAuthenticationApi();
    try {
      final response = await api.postEmailRegister(
        authenticationEmailRegisterRequestBody:
            AuthenticationEmailRegisterRequestBody(
          email: email,
          password: password,
        ),
        xCustomLang: xCustomLang,
      );
      if (response.data != null) {
        await write(loginResponse: response.data!);
      }
    } catch (error) {
      ref.read(loggerProvider).e("", error: error);
      rethrow;
    }
  }

  Future<void> postLoginGoogleAndSetOrThrow({
    required String idToken,
    String? xCustomLang,
  }) async {
    final logger = ref.read(loggerProvider);
    final api = ref.read(baseClientProvider).getAuthenticationApi();
    try {
      logger.d("postLoginGoogleAndSetOrThrow");
      final response = await api.postLoginGoogle(
        authGoogleLoginDto: AuthGoogleLoginDto(
          idToken: idToken,
        ),
        xCustomLang: xCustomLang,
      );
      logger.d("response");
      if (response.data != null) {
        await write(loginResponse: response.data!);
      }
    } catch (error) {
      logger.e("", error: error);
      rethrow;
    }
  }

  Future<void> postLoginAppleAndSetOrThrow({
    required AuthAppleLoginDto body,
    String? xCustomLang,
  }) async {
    final api = ref.read(baseClientProvider).getAuthenticationApi();
    try {
      final response = await api.postLoginApple(
        authAppleLoginDto: body,
        xCustomLang: xCustomLang,
      );
      if (response.data != null) {
        await write(loginResponse: response.data!);
      }
    } catch (error) {
      ref.read(loggerProvider).e("", error: error);
      rethrow;
    }
  }

  Future<void> postPasswordForgotOrThrow({
    required String email,
    String? xCustomLang,
  }) async {
    final api = ref.read(baseClientProvider).getAuthenticationApi();
    try {
      await api.postPasswordForgot(
        authenticationPasswordForgotRequestBody:
            AuthenticationPasswordForgotRequestBody(
          email: email,
        ),
        xCustomLang: xCustomLang,
      );
    } catch (error) {
      ref.read(loggerProvider).e("", error: error);
      rethrow;
    }
  }

  void handlePlatformMessage(Object? message) {
    if (message is Map<dynamic, dynamic> && message['type'] == 'state') {
      final payload = message['payload'];
      if (payload is Map<dynamic, dynamic>) {
        final dynamic authentication = payload["authentication"];
        final fromMessage = AuthenticationResponse.fromJson(
          Map<String, dynamic>.from(authentication),
        );
        write(
          loginResponse: AuthenticationResponse(
            refreshToken: fromMessage.refreshToken,
            token: fromMessage.token,
            tokenExpires: fromMessage.tokenExpires,
          ),
        );
      }
    }
  }

  Future<void> _read() async {
    final storage = ref.read(flutterSecureStorageProvider);
    state = AuthenticationStorageState(
      accessToken: await storage.read(key: accessTokenKey),
      refreshToken: await storage.read(key: refreshTokenKey),
      expiresAt: (await storage.read(key: expiresAtTokenKey))?.parsedTimestamp,
    );
  }

  Future<void> write({required AuthenticationResponse loginResponse}) async {
    final storage = ref.read(flutterSecureStorageProvider);
    await storage.write(key: accessTokenKey, value: loginResponse.token);
    await storage.write(
      key: refreshTokenKey,
      value: loginResponse.refreshToken,
    );
    await storage.write(
      key: expiresAtTokenKey,
      value: loginResponse.tokenExpires.toString(),
    );

    state = AuthenticationStorageState(
      accessToken: loginResponse.token,
      refreshToken: loginResponse.refreshToken,
      expiresAt: loginResponse.tokenExpires.dateTimeFromMillisecondsSinceEpoch,
    );
  }

  Future<void> logout() async {
    final storage = ref.read(flutterSecureStorageProvider);
    await storage.delete(key: accessTokenKey);
    await storage.delete(key: refreshTokenKey);
    await storage.delete(
      key: expiresAtTokenKey,
    );

    final googleAuthentication = ref.read(googleAuthenticationProvider);
    await googleAuthentication.signOut();

    state = const AuthenticationStorageState(
      accessToken: null,
      refreshToken: null,
      expiresAt: null,
    );
  }
}
