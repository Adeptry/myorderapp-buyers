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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../extensions/build_context_extensions.dart';

class ApplePayListTile extends StatelessWidget {
  final bool? selected;
  final Function? onTap;

  const ApplePayListTile({
    super.key,
    this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selectedOrFalse = selected ?? false;

    return ListTile(
      onTap: () {
        onTap?.call();
      },
      selected: selectedOrFalse,
      trailing: const FaIcon(
        FontAwesomeIcons.applePay,
      ),
      title: Text(
        context.l10n.applePayListTileTitle,
      ),
    );
  }
}
