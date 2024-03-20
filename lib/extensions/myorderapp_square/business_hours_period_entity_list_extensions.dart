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

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:myorderapp_square/myorderapp_square.dart';

import '../dart/date_time_extensions.dart';
import 'business_hours_period_entity_extensions.dart';

extension BusinessHoursPeriodEntityListExtensions
    on List<BusinessHoursPeriodEntity> {
  bool? nowIsWithinBusinessHoursToday() {
    return businessHoursToday()?.isWithin(TimeOfDay.now());
  }

  bool isWithin(DateTime dateTime) {
    final dateTimesBusinessHours = businessHoursOnDayOfWeek(dateTime.weekday);
    if (dateTimesBusinessHours != null) {
      return dateTimesBusinessHours.isWithin(TimeOfDay.fromDateTime(dateTime));
    }

    return false;
  }

  BusinessHoursPeriodEntity? businessHoursToday() {
    return businessHoursOnDayOfWeek(DateTime.now().weekday);
  }

  BusinessHoursPeriodEntity? nextBusinessHours() {
    return businessHoursToday() ?? businessHoursOnFirstBusinessDayAfterToday();
  }

  bool hasBusinessHoursOn({required int dayOfWeek}) {
    return businessHoursOnDayOfWeek(dayOfWeek) != null;
  }

  BusinessHoursPeriodEntity? businessHoursOnDayOfWeek(int? dayOfWeek) {
    if (dayOfWeek == null) {
      return null;
    }
    return firstWhereOrNull(
      (period) => period.parsedDayOfWeek == dayOfWeek,
    );
  }

  int? firstBusinessDayOfWeekAfter(int weekday) {
    for (var i = 0; i < 7; i++) {
      final dayOfWeek = (weekday + i - 1) % 7 + 1;
      final businessHours = businessHoursOnDayOfWeek(dayOfWeek);

      if (businessHours != null && dayOfWeek != weekday) {
        if (i == 0) {
          return dayOfWeek;
        } else if (i != 0) {
          return dayOfWeek;
        }
      }
    }

    return null;
  }

  int? firstBusinessDayOfWeekAfterToday() {
    return firstBusinessDayOfWeekAfter(DateTime.now().weekday);
  }

  BusinessHoursPeriodEntity? businessHoursOnFirstBusinessDayAfterToday() {
    return businessHoursOnDayOfWeek(firstBusinessDayOfWeekAfterToday());
  }

  DateTime? firstPickupDateTimeWithin({required int minutes}) {
    final now = DateTime.now();

    final dateTimeAfterDuration =
        now.add(Duration(minutes: minutes)).align(const Duration(minutes: 5));
    if (businessHoursToday()
            ?.isWithin(TimeOfDay.fromDateTime(dateTimeAfterDuration)) ??
        false) {
      return dateTimeAfterDuration;
    }

    final businessHoursAfterToday = businessHoursOnFirstBusinessDayAfterToday();
    TimeOfDay? nextBusinessHoursLocalTimeOfDay =
        businessHoursAfterToday?.parsedStartLocalTimeOfDay;

    if (nextBusinessHoursLocalTimeOfDay != null) {
      int daysUntilNextBusinessDay =
          (businessHoursAfterToday!.parsedDayOfWeek! - now.weekday + 7) % 7;
      DateTime nextBusinessDateTime =
          now.add(Duration(days: daysUntilNextBusinessDay));
      final nextBusinessHoursLocalDateTime = DateTime(
        nextBusinessDateTime.year,
        nextBusinessDateTime.month,
        nextBusinessDateTime.day,
        nextBusinessHoursLocalTimeOfDay.hour,
        nextBusinessHoursLocalTimeOfDay.minute,
      ).add(
        Duration(minutes: minutes),
      );

      return nextBusinessHoursLocalDateTime;
    }

    return null; // No known next pickup time
  }
}
