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

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../logger/provider.dart';
import 'provider.dart';

part 'messaging_token_refresh.g.dart';

@Riverpod(keepAlive: true)
class MessagingTokenRefresh extends _$MessagingTokenRefresh {
  @override
  Stream<String?> build() async* {
    final logger = ref.read(loggerProvider);
    if (MoaFirebase.messaging != null) {
      try {
        await for (final token in MoaFirebase.messaging!.onTokenRefresh) {
          yield token;
        }
      } catch (error) {
        logger.e("", error: error);
      }
    } else {
      yield null;
    }
  }
}
