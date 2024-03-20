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

import 'package:firebase_core/firebase_core.dart';
import 'package:universal_platform/universal_platform.dart';

extension FirebaseOptionsExtensions on FirebaseOptions {
  String? get currentPlatformClientId {
    if (UniversalPlatform.isAndroid) {
      return androidClientId;
    } else if (UniversalPlatform.isIOS) {
      return iosClientId;
    } else if (UniversalPlatform.isWeb) {
      return null;
    } else {
      throw Exception("Unsupported platform");
    }
  }
}
