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
import 'package:url_launcher/url_launcher.dart';

import 'show_exception_dialog.dart';

Future<void> moaLaunchUrl(BuildContext context, String url) async {
  try {
    await launchUrl(
      Uri.parse(url),
    );
  } catch (error) {
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
