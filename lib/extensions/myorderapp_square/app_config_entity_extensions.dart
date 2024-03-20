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
import 'package:myorderapp_square/myorderapp_square.dart';

import '../build_context_extensions.dart';
import '../dart/optional_bool_extensions.dart';
import 'theme_mode_enum_extensions.dart';

extension AppConfigEntityExtensions on AppConfigEntity {
  String formattedSummary(BuildContext context) {
    return '${context.l10n.font}: $fontFamily / ${context.l10n.color}: $seedColor / ${context.l10n.mode}: ${themeMode?.formattedSummary()} / ${context.l10n.appearance}: ${useMaterial3.orFalse ? context.l10n.contemporary : context.l10n.classic} ';
  }

  String multilineSummary(BuildContext context) {
    return '${context.l10n.font}: $fontFamily\n${context.l10n.color}: $seedColor\n${context.l10n.mode}: ${themeMode?.formattedSummary()}\n${context.l10n.appearance}: ${useMaterial3.orFalse ? context.l10n.contemporary : context.l10n.classic} ';
  }

  static AppConfigEntity? fromMessage(Object? data) {
    if (data is Map<dynamic, dynamic> && data['type'] == 'state') {
      final dynamic payload = data["payload"];
      if (payload is Map<dynamic, dynamic>) {
        final dynamic appConfigPayload = payload["appConfig"];
        if (appConfigPayload is Map<dynamic, dynamic>) {
          return AppConfigEntity.fromJson(
            Map<String, dynamic>.from(appConfigPayload),
          );
        }
      }
    }
    return null;
  }
}
