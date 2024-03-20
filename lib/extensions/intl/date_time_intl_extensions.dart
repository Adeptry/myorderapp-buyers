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

import 'package:intl/intl.dart';

extension DateTimeIntlExtensions on DateTime {
  String get formattedLocalTime {
    return DateFormat.jm().format(toLocal());
  }

  String get formattedShortLocalDate {
    return DateFormat.MMMd().format(toLocal());
  }

  String get formattedMediumLocalDate {
    return DateFormat("EEEE MMM d").format(toLocal());
  }

  String get formattedLongLocalDate {
    return DateFormat.yMMMMEEEEd().format(toLocal());
  }

  String get formattedShortLocalDateTime {
    return DateFormat.Md().add_jm().format(toLocal());
  }

  String get formattedMediumLocalDateTime {
    return DateFormat("EEEE MMM d").add_jm().format(toLocal());
  }

  String get formattedLongLocalDateTime {
    return DateFormat.yMMMMEEEEd().add_jm().format(toLocal());
  }
}
