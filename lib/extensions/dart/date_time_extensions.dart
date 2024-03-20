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

extension DateTimeExtensions on DateTime {
  DateTime align(Duration alignment, [bool roundUp = true]) {
    assert(alignment >= Duration.zero);
    if (alignment == Duration.zero) return this;
    final correction = Duration(
      days: 0,
      hours: alignment.inDays > 0
          ? hour
          : alignment.inHours > 0
              ? hour % alignment.inHours
              : 0,
      minutes: alignment.inHours > 0
          ? minute
          : alignment.inMinutes > 0
              ? minute % alignment.inMinutes
              : 0,
      seconds: alignment.inMinutes > 0
          ? second
          : alignment.inSeconds > 0
              ? second % alignment.inSeconds
              : 0,
      milliseconds: alignment.inSeconds > 0
          ? millisecond
          : alignment.inMilliseconds > 0
              ? millisecond % alignment.inMilliseconds
              : 0,
      microseconds: alignment.inMilliseconds > 0 ? microsecond : 0,
    );
    if (correction == Duration.zero) return this;

    final corrected = subtract(correction);
    final result = roundUp ? corrected.add(alignment) : corrected;
    return result;
  }

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isTomorrow {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == (now.day + 1);
  }

  bool get isTodayOrTomorrow {
    return isToday || isTomorrow;
  }

  String get rfc3339String {
    return toUtc().toIso8601String();
  }
}
