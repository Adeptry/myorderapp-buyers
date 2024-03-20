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

import '../extensions/app_localization_extensions.dart';
import '../extensions/build_context_extensions.dart';
import 'show_text_dialog.dart';

Future<T?> showErrorDialog<T>({
  required BuildContext context,
  Error? error,
}) {
  return showTextDialog(
    context: context,
    title: context.l10n.errorTitleFor(null),
    content: error.toString(),
    button: context.l10n.okay,
  );
}
