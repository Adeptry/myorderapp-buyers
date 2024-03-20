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

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:universal_platform/universal_platform.dart';

import 'utils/ignore_bad_certificat_http_overrides.dart';
import 'widgets/misc/square_create_card_element/square_create_card_element_stub.dart'
    if (dart.library.html) 'widgets/misc/square_create_card_element/square_create_card_element_web.dart'
    show squareCreateCardElementRegisterViewFactory;
import 'widgets/my_order_app.dart';

void main() async {
  if (UniversalPlatform.isWeb) {
    squareCreateCardElementRegisterViewFactory();
  }

  if (kDebugMode) {
    HttpOverrides.global = IgnoreBadCertificationHttpOverrides();
  }

  usePathUrlStrategy();

  runZonedGuarded(() {
    runApp(
      const ProviderScope(
        child: MyOrderApp(),
      ),
    );
  }, (error, stackTrace) {
    // ignore: avoid_print
    print("Caught error: $error");
    // ignore: avoid_print
    print(stackTrace);
  });
}
