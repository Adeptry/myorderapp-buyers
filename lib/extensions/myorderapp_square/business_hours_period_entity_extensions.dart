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
import 'package:myorderapp_square/myorderapp_square.dart';

import '../build_context_extensions.dart';
import '../dart/string_extension.dart';
import '../intl/int_extensions.dart';
import '../material/string_extensions.dart';
import '../material/time_of_day_extensions.dart';
import '../material/time_of_day_optional_extensions.dart';

extension BusinessHoursPeriodEntityExtensions on BusinessHoursPeriodEntity {
  bool isWithin(TimeOfDay timeOfDay) {
    return timeOfDay >= parsedStartLocalTimeOfDay.orLast &&
        timeOfDay <= parsedEndLocalTimeOfDay.orFirst;
  }

  String? formattedSummary(BuildContext context) {
    final startTime = formattedStartLocalTimeOfDay(context);
    final endTime = formattedEndLocalTimeOfDay(context);
    final dayOfWeek = formattedUnixDayOfWeek;
    if (startTime == null || endTime == null || dayOfWeek == null) {
      return null;
    }
    return context.l10n.businessHoursSummary(dayOfWeek, endTime, startTime);
  }

  TimeOfDay? get parsedStartLocalTimeOfDay {
    return startLocalTime?.parsedTimeOfDay;
  }

  String? formattedStartLocalTimeOfDay(BuildContext context) {
    return parsedStartLocalTimeOfDay?.format(context);
  }

  TimeOfDay? get parsedEndLocalTimeOfDay {
    return endLocalTime?.parsedTimeOfDay;
  }

  String? formattedEndLocalTimeOfDay(BuildContext context) {
    return parsedEndLocalTimeOfDay?.format(context);
  }

  int? get parsedDayOfWeek {
    return dayOfWeek?.parsedDayOfWeek;
  }

  int? get parsedUnixDayOfWeek {
    return dayOfWeek?.parsedUnixDayOfWeek;
  }

  String? get formattedUnixDayOfWeek {
    return parsedUnixDayOfWeek?.formattedUnixDayOfWeek;
  }
}
