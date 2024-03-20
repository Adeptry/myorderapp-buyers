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

import 'dart:convert';

import 'package:myorderapp_square/myorderapp_square.dart';

import 'category_entity_extensions.dart';

extension CategoryEntityListExtensions on List<CategoryEntity> {
  List<CategoryEntity> get whereMoaEnabled {
    return where((category) => category.isMoaEnabled)
        .map((category) => category.whereMoaEnabled)
        .where(
          (category) => category.items?.isNotEmpty ?? false,
        )
        .toList();
  }

  static List<CategoryEntity>? fromMessage(Object? data) {
    if (data is Map<dynamic, dynamic>) {
      final dynamic payload = data["payload"];
      if (payload is Map<dynamic, dynamic>) {
        final dynamic categories = payload["categories"];

        if (categories is List<dynamic>) {
          return categories
              .map(
                (category) =>
                    CategoryEntity.fromJson(jsonDecode(jsonEncode(category))),
              )
              .toList();
        }
      }
    }
    return null;
  }
}
