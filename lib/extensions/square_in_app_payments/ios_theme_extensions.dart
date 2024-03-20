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
import 'package:square_in_app_payments/models.dart';

import '../build_context_extensions.dart';
import 'rgba_color_builder_extensions.dart';

extension IOSThemesExtensions on IOSTheme {
  static IOSTheme fromContext(BuildContext context) {
    TextTheme textTheme = context.theme.textTheme;

    return IOSTheme(
      (b) => b
        ..backgroundColor = RGBAColorBuilderExtensions.fromColor(
          context.theme.colorScheme.background,
        )
        ..foregroundColor =
            RGBAColorBuilderExtensions.fromColor(context.theme.canvasColor)
        ..textColor =
            RGBAColorBuilderExtensions.fromColor(textTheme.bodyMedium?.color)
        ..placeholderTextColor =
            RGBAColorBuilderExtensions.fromColor(textTheme.labelSmall?.color)
        ..tintColor =
            RGBAColorBuilderExtensions.fromColor(context.theme.primaryColor)
        ..messageColor =
            RGBAColorBuilderExtensions.fromColor(textTheme.labelMedium?.color)
        ..errorColor = RGBAColorBuilderExtensions.fromColor(
          context.theme.colorScheme.error,
        )
        ..saveButtonTitle = context.l10n.addPayment
        ..saveButtonTextColor =
            RGBAColorBuilderExtensions.fromColor(textTheme.labelMedium?.color)
        ..keyboardAppearance = context.theme.brightness == Brightness.light
            ? KeyboardAppearance.light
            : KeyboardAppearance.dark,
    );
  }
}
