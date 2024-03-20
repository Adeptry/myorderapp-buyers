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
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart' as web;
import 'package:google_sign_in_web/google_sign_in_web.dart';

class UniversalGoogleSignInButton extends StatelessWidget {
  final void Function() onPressed;
  final Size? minimumSize;
  final String? text;

  const UniversalGoogleSignInButton({
    super.key,
    required this.onPressed,
    this.minimumSize,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return (GoogleSignInPlatform.instance as web.GoogleSignInPlugin)
        .renderButton(
      configuration: GSIButtonConfiguration(
        minimumWidth: minimumSize?.width,
        text: GSIButtonText.continueWith,
      ),
    );
  }
}
