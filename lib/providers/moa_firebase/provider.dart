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

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../firebase_options.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class MoaFirebase extends _$MoaFirebase {
  @override
  Future<FirebaseApp?> build() async {
    if (UniversalPlatform.isAndroid ||
        UniversalPlatform.isIOS ||
        UniversalPlatform.isWeb) {
      final app = (await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ));

      return app;
    }
    return null;
  }

  static requestPermissionIfNecessary() async {
    try {
      final notificationSettings = await messaging?.getNotificationSettings();

      if ((UniversalPlatform.isAndroid || UniversalPlatform.isIOS) &&
          notificationSettings?.authorizationStatus ==
              AuthorizationStatus.notDetermined) {
        final settings = await messaging?.requestPermission(
          alert: true,
        );

        if (settings?.authorizationStatus != AuthorizationStatus.authorized) {
          return false;
        }

        if (UniversalPlatform.isIOS) {
          await messaging?.getAPNSToken();
          return true;
        }

        return true;
      }
    } catch (error) {
      return false;
    }
  }

  static FirebaseAnalytics? get analytics {
    try {
      return FirebaseAnalytics.instance;
    } catch (error) {
      return null;
    }
  }

  static FirebaseMessaging? get messaging {
    try {
      return FirebaseMessaging.instance;
    } catch (error) {
      return null;
    }
  }

  static FirebaseInstallations? get installations {
    try {
      return FirebaseInstallations.instance;
    } catch (error) {
      return null;
    }
  }
}
