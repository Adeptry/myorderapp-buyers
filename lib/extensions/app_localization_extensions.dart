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

import 'dart:io';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppLocalizationExtensions on AppLocalizations {
  String errorTitleFor(int? statusCode) {
    switch (statusCode) {
      case HttpStatus.badRequest:
        return errorBadRequestTitle;
      case HttpStatus.unauthorized:
        return errorUnauthorizedTitle;
      case HttpStatus.notFound:
        return errorNotFoundTitle;
      case HttpStatus.internalServerError:
        return errorInternalServerErrorTitle;
      case HttpStatus.conflict:
        return errorConflictContent;
      case HttpStatus.unprocessableEntity:
        return errorUnprocessableEntityTitle;
      default:
        return errorTitle;
    }
  }

  String errorContentFor(int? statusCode) {
    switch (statusCode) {
      case HttpStatus.badRequest:
        return errorBadRequestContent;
      case HttpStatus.unauthorized:
        return errorUnauthorizedContent;
      case HttpStatus.notFound:
        return errorNotFoundContent;
      case HttpStatus.internalServerError:
        return errorInternalServerErrorContent;
      case HttpStatus.conflict:
        return errorConflictContent;
      case HttpStatus.unprocessableEntity:
        return errorUnprocessableEntityContent;
      default:
        return errorContent;
    }
  }
}
