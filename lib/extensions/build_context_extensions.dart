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
import 'package:go_router/go_router.dart';
import 'package:myorderapp_square/myorderapp_square.dart';

import 'material/text_style_extensions.dart';

extension BuildContextExtensions on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
  ThemeData get theme => Theme.of(this);
  NavigatorState get navigator => Navigator.of(this);
  GoRouter get router => GoRouter.of(this);
  GoRouterState get routerState => GoRouterState.of(this);
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
  Locale get locale => Localizations.localeOf(this);

  TextStyle? get titleLargeTextStyle {
    return theme.textTheme.titleLarge;
  }

  TextStyle? get headerTextStyle {
    return theme.textTheme.titleMedium?.bolded;
  }

  TextStyle? get bodyLargeTextStyle {
    return null; //theme.textTheme.bodyLarge;
  }

  TextStyle? get subtitleTextStyle {
    return theme.textTheme.bodyMedium
        ?.copyWith(color: theme.colorScheme.secondary);
  }

  TextStyle? get captionTextStyle {
    return theme.textTheme.bodySmall;
    // ?.copyWith(color: theme.colorScheme.onSurface);
  }

  TextStyle? get labelSmallTextStyle {
    return theme.textTheme.labelSmall;
    //?.copyWith(color: theme.colorScheme.onSurface);
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBarText(
    String contentTextData,
  ) {
    return scaffoldMessenger
        .showSnackBar(SnackBar(content: Text(contentTextData)));
  }

  Color? getColorForFulfilmentStatus(FulfillmentStatusEnum? status) {
    switch (status) {
      case FulfillmentStatusEnum.PROPOSED:
        return theme.colorScheme.secondary;
      case FulfillmentStatusEnum.RESERVED:
        return theme.colorScheme.secondary;
      case FulfillmentStatusEnum.PREPARED:
        return theme.colorScheme.primary;
      case FulfillmentStatusEnum.COMPLETED:
        return theme.colorScheme.primary;
      case FulfillmentStatusEnum.CANCELED:
        return theme.colorScheme.error;
      case FulfillmentStatusEnum.FAILED:
        return theme.colorScheme.error;
      case FulfillmentStatusEnum.unknownDefaultOpenApi:
        return theme.colorScheme.outline;
      default:
        return theme.colorScheme.surface; // Fallback value
    }
  }

  String getL10nForFulfilmentStatus(FulfillmentStatusEnum status) {
    switch (status) {
      case FulfillmentStatusEnum.PROPOSED:
        return l10n.fulfillmentProposed;
      case FulfillmentStatusEnum.RESERVED:
        return l10n.fulfillmentReserved;
      case FulfillmentStatusEnum.PREPARED:
        return l10n.fulfillmentPrepared;
      case FulfillmentStatusEnum.COMPLETED:
        return l10n.fulfillmentCompleted;
      case FulfillmentStatusEnum.CANCELED:
        return l10n.fulfillmentCanceled;
      case FulfillmentStatusEnum.FAILED:
        return l10n.fulfillmentProposed;
      case FulfillmentStatusEnum.unknownDefaultOpenApi:
        return "";
      default:
        return ""; // Fallback value
    }
  }
}
