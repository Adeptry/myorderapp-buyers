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

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:myorderapp_square/myorderapp_square.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../constants/widget_constants.dart';
import '../../extensions/build_context_extensions.dart';
import '../../extensions/widget_ref_extensions.dart';
import '../../providers/authentication_storage/provider.dart';
import '../../providers/authentication_storage/state.dart';
import '../../providers/customer/provider.dart';
import '../../providers/google_authentication/provider.dart';
import '../../providers/merchant_id_or_path/provider.dart';
import '../../providers/moa_firebase/provider.dart';
import '../../providers/moa_options/provider.dart';
import '../../providers/moa_options/state.dart';
import '../../utils/moa_launch_url.dart';
import '../../utils/show_exception_dialog.dart';
import '../../utils/show_text_dialog.dart';
import '../buttons/universal_google_sign_in_button/mobile.dart'
    if (dart.library.html) '../buttons/universal_google_sign_in_button/web.dart';
import '../forms/post_authentication_form.dart';

enum AuthenticationPageType {
  register,
  login,
}

class AuthenticationScaffold extends ConsumerStatefulWidget {
  const AuthenticationScaffold({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AuthenticationScaffoldState();
}

class _AuthenticationScaffoldState
    extends ConsumerState<AuthenticationScaffold> {
  AuthenticationPageType _type = AuthenticationPageType.register;
  bool get _isRegister => _type == AuthenticationPageType.register;

  _handleGoogleAuthenticationUpdate(
    GoogleSignIn googleSignIn,
    AuthenticationStorageState authenticationState,
  ) {
    if (UniversalPlatform.isWeb &&
        authenticationState.isAuthenticated &&
        googleSignIn.currentUser != null) {
      context.navigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final googleSignIn = ref.watch(googleAuthenticationProvider);
    final authenticationState = ref.watch(authenticationStorageProvider);

    googleSignIn.onCurrentUserChanged.listen(
      (GoogleSignInAccount? account) async {
        _handleGoogleAuthenticationUpdate(googleSignIn, authenticationState);
      },
    );

    ref.listen(authenticationStorageProvider, (_, next) async {
      _handleGoogleAuthenticationUpdate(googleSignIn, next);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(_isRegister ? context.l10n.register : context.l10n.logIn),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(WidgetConstants.defaultPaddingDouble),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = min(
                constraints.biggest.width,
                WidgetConstants.constrainedCenteredColumnWidth,
              ).toDouble();
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: width,
                  ),
                  child: Column(
                    children: [
                      PostAuthenticationForm(
                        isRegister: _isRegister,
                        onPressedSubmit: ({email, password}) async {
                          await _onPressedSubmit(email, password);
                        },
                        toggleAuthenticationType: () {
                          setState(
                            () {
                              _type = _isRegister
                                  ? AuthenticationPageType.login
                                  : AuthenticationPageType.register;
                            },
                          );
                        },
                      ),
                      if (UniversalPlatform.isWeb ||
                          UniversalPlatform.isIOS) ...[
                        const SizedBox(
                          height: WidgetConstants.defaultPaddingDouble,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: width),
                          child: SignInWithAppleButton(
                            text: context.l10n.continueWithApple,
                            height: 40,
                            onPressed: () async {
                              await _onPressedAppleSignIn(context, ref);
                            },
                          ),
                        ),
                      ],
                      const SizedBox(
                        height: WidgetConstants.defaultPaddingDouble,
                      ),
                      UniversalGoogleSignInButton(
                        text: context.l10n.continueWithGoogle,
                        onPressed: () => _onPressedGoogleSignIn(context, ref),
                        minimumSize: Size(width, 44),
                      ),
                      const SizedBox(
                        height: WidgetConstants.defaultPaddingDouble,
                      ),
                      Text(
                        context.l10n.consent,
                        textAlign: TextAlign.center,
                        style: context.captionTextStyle,
                      ),
                      const SizedBox(
                        height: WidgetConstants.mediumPaddingDouble,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              child: Text(context.l10n.terms),
                              onPressed: () async {
                                await moaLaunchUrl(
                                  context,
                                  MoaOptionsState.termsUrl,
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              child: Text(context.l10n.privacy),
                              onPressed: () async {
                                await moaLaunchUrl(
                                  context,
                                  MoaOptionsState.privacyUrl,
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              child: Text(context.l10n.about),
                              onPressed: () => showAboutDialog(
                                context: context,
                                applicationVersion: MoaOptionsState.version,
                                applicationLegalese: MoaOptionsState.legalese,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onPressedAppleSignIn(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final authenticationStateNotifier =
        ref.read(authenticationStorageProvider.notifier);
    final moaOptions = ref.read(moaOptionsProvider);
    try {
      context.loaderOverlay.show();
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: moaOptions.appleClientId,
          redirectUri: Uri.parse(
            moaOptions.appleRedirectUrl,
          ),
        ),
      );

      if (credential.identityToken == null && context.mounted) {
        context.loaderOverlay.hide();
        await showTextDialog(
          context: context,
          title: "No identity token found",
          content: "No identity token found",
          button: "Ok",
        );
        return;
      }

      await authenticationStateNotifier.postLoginAppleAndSetOrThrow(
        body: AuthAppleLoginDto(
          idToken: credential.identityToken!,
          firstName: credential.givenName,
          lastName: credential.familyName,
        ),
      );

      await MoaFirebase.analytics?.logLogin(loginMethod: "apple");

      if (context.mounted) {
        context.loaderOverlay.hide();
        context.navigator.pop(kIsWeb); // needsRefresh
      }
    } catch (error) {
      ref.logger.e("", error: error);
      if (context.mounted) {
        context.loaderOverlay.hide();
        if (error is Exception) {
          await showExceptionDialog(context: context, exception: error);
        } else {
          await showExceptionDialog(
            context: context,
            exception: Exception(error.toString()),
          );
        }
      }
    }
  }

  Future<void> _onPressedGoogleSignIn(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final googleAuthentication = ref.read(googleAuthenticationProvider);
    final googleAuthenticationNotifier =
        ref.read(googleAuthenticationProvider.notifier);

    try {
      // On web, this is handled by onCurrentUserChanged in provider.
      final account = await googleAuthentication.signIn();
      await googleAuthenticationNotifier.handleOnCurrentUserChanged(account);

      if (context.mounted && account != null) {
        await MoaFirebase.analytics?.logLogin(loginMethod: "google");

        if (context.mounted) {
          context.navigator.pop();
        }
      }
    } catch (error) {
      ref.logger.e("", error: error);
      if (context.mounted) {
        if (error is Exception) {
          await showExceptionDialog(context: context, exception: error);
        } else {
          await showExceptionDialog(
            context: context,
            exception: Exception(error.toString()),
          );
        }
      }
    }
  }

  Future<void> _onPressedSubmit(
    String? email,
    String? password,
  ) async {
    final authenticationStateNotifier =
        ref.read(authenticationStorageProvider.notifier);
    final languageCode = context.locale.languageCode;
    final merchantIdOrPath = ref.read(merchantIdOrPathProvider);

    context.loaderOverlay.show();
    try {
      if (_isRegister) {
        await authenticationStateNotifier.postEmailRegisterAndSetOrThrow(
          email: email!,
          password: password!,
          xCustomLang: languageCode,
        );
      } else {
        await authenticationStateNotifier.postEmailLoginAndSetOrThrow(
          email: email!,
          password: password!,
          xCustomLang: languageCode,
        );
      }

      final customerStateNotifier = ref.read(
        CustomerProvider(
          merchantIdOrPath: merchantIdOrPath,
        ).notifier,
      );

      try {
        await customerStateNotifier.postAndSetOrThrow(
          merchantIdOrPath: merchantIdOrPath,
          xCustomLang: languageCode,
        );
        // ignore: empty_catches
      } catch (error) {} // this post is kept just in case the customer is not created yet

      if (context.mounted) {
        context.loaderOverlay.hide();

        context.navigator.pop();

        if (_isRegister) {
          await MoaFirebase.analytics?.logSignUp(signUpMethod: "email");
        } else {
          await MoaFirebase.analytics?.logLogin(loginMethod: "email");
        }
      }
    } catch (error) {
      if (context.mounted) {
        context.loaderOverlay.hide();
        if (error is Exception) {
          await showExceptionDialog(context: context, exception: error);
        } else {
          await showExceptionDialog(
            context: context,
            exception: Exception(error.toString()),
          );
        }
      }
    }
  }
}
