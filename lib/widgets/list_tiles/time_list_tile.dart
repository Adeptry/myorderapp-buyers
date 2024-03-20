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
import '../../extensions/dart/optional_bool_extensions.dart';
import '../../extensions/dart/optional_date_time_extensions.dart';
import '../../extensions/intl/date_time_intl_extensions.dart';

class TimeListTile extends StatelessWidget {
  final DateTime? time;
  final bool? isAsap;
  final Function()? onTap;

  const TimeListTile(this.time, {this.onTap, this.isAsap, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Icon(onTap != null ? Icons.edit : Icons.schedule),
      title: Text(
        isAsap.orFalse ? context.l10n.asap : time.orNow.formattedLocalTime,
        style: context.bodyLargeTextStyle,
      ),
      subtitle: isAsap.orFalse
          ? Text(
              time.orNow.formattedLocalTime,
              style: context.subtitleTextStyle,
            )
          : null,
      onTap: onTap,
    );
  }
}
