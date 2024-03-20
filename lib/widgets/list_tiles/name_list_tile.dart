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

import '../../extensions/build_context_extensions.dart';

class NameListTile extends StatelessWidget {
  final String? fullName;
  final Function()? onTap;

  const NameListTile({super.key, this.onTap, required this.fullName});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(context.l10n.name),
      subtitle:
          fullName != null ? Text(fullName!) : Text(context.l10n.nameSubtitle),
      trailing: fullName != null
          ? const Icon(Icons.person)
          : const Icon(Icons.person_add),
      onTap: () => onTap?.call(),
    );
  }
}
