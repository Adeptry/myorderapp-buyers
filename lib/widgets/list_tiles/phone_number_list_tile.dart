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
import 'package:phone_form_field/phone_form_field.dart';

import '../../extensions/build_context_extensions.dart';

class PhoneNumberListTile extends StatelessWidget {
  final bool isLoading;
  final String? phoneNumber;
  final String countryCode;
  final Function()? onTap;

  const PhoneNumberListTile({
    required this.phoneNumber,
    required this.countryCode,
    required this.isLoading,
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final phoneNumberParsed = PhoneNumber.parse(
      phoneNumber ?? "",
      destinationCountry: IsoCode.fromJson(countryCode),
    );
    final phoneNumberParsedInternational =
        phoneNumberParsed.international.length > 2
            ? phoneNumberParsed.international
            : null;
    return ListTile(
      title: Text(context.l10n.phone),
      subtitle: phoneNumberParsedInternational != null
          ? Text(
              phoneNumberParsedInternational,
            )
          : Text(isLoading ? "" : context.l10n.phoneSubtitle),
      trailing: const Icon(Icons.phone),
      onTap: () => onTap?.call(),
    );
  }
}
