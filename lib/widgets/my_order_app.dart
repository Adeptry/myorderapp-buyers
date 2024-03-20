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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../extensions/dart/color.dart';
import '../extensions/myorderapp_square/theme_mode_enum_extensions.dart';
import '../providers/app_config/provider.dart';
import '../providers/customer/provider.dart';
import '../providers/moa_firebase/provider.dart';
import '../providers/moa_options/provider.dart';
import '../providers/moa_options/state.dart';
import '../providers/router/router_provider.dart';

class MyOrderApp extends ConsumerWidget {
  const MyOrderApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final merchantIdOrPath = ref
        .watch(routerProvider)
        .routeInformationProvider
        .value
        .uri
        .pathSegments
        .firstOrNull;

    if (merchantIdOrPath == null) {
      launchUrlString(
        MoaOptionsState.rootRedirectUrl,
        webOnlyWindowName: "_self",
      );
      return const SizedBox.shrink();
    }

    ref.watch(moaFirebaseProvider);
    ref.watch(CustomerProvider(merchantIdOrPath: merchantIdOrPath));

    final router = ref.watch(routerProvider);
    final appConfigState = ref.watch(
      AppConfigProvider(
        merchantIdOrPath: merchantIdOrPath,
      ),
    );
    final moaOptions = ref.watch(moaOptionsProvider);

    final appConfig = appConfigState.valueOrNull;

    final seedColor = ColorExtensions.fromHex(
      appConfig?.seedColor ?? moaOptions.seedColor,
    );
    final fontFamily = appConfig?.fontFamily ?? moaOptions.fontFamily;
    final useMaterial3 = appConfig?.useMaterial3 ?? moaOptions.useMaterial3;

    return OverlaySupport.global(
      child: GlobalLoaderOverlay(
        overlayColor: Colors.black54,
        useDefaultLoading: false,
        overlayWidgetBuilder: (progress) {
          return Center(
            child: CircularProgressIndicator(
              value: progress,
            ),
          );
        },
        child: MaterialApp.router(
          routerConfig: router,
          title: appConfig?.name ?? "",
          themeMode: appConfig?.themeMode?.toThemeMode(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorSchemeSeed: seedColor,
            useMaterial3: useMaterial3,
            brightness: Brightness.light,
            textTheme: GoogleFonts.getTextTheme(
              fontFamily,
            ),
          ),
          darkTheme: ThemeData(
            colorSchemeSeed: seedColor,
            useMaterial3: useMaterial3,
            brightness: Brightness.dark,
            textTheme: GoogleFonts.getTextTheme(
              fontFamily,
            ).apply(
              displayColor: Colors.white,
              bodyColor: Colors.white,
            ),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  }
}
