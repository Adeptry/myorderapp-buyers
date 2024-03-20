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

import 'package:myorderapp_square/myorderapp_square.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../apis/provider.dart';
import '../authentication_storage/provider.dart';
import '../logger/provider.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class User extends _$User {
  @override
  Future<UserEntity?> build({
    String? xCustomLang,
  }) async {
    final api = ref.watch(usersApiProvider);
    final authenticationStorage = ref.watch(authenticationStorageProvider);
    if (!authenticationStorage.isAuthenticated) {
      return null;
    }

    ref.listen(
      authenticationStorageProvider,
      (_, next) async {
        if (!next.isAuthenticated) {
          state = const AsyncValue.data(null);
        } else {
          final response = await api.getUserMe(
            merchants: true,
            customers: true,
            xCustomLang: xCustomLang,
          );
          state = AsyncValue.data(response.data);
        }
      },
      fireImmediately: true,
    );

    final response = await api.getUserMe(
      merchants: true,
      customers: true,
      xCustomLang: xCustomLang,
    );

    return response.data;
  }

  Future<void> patchAndSetOrThrow({
    required UserPatchBody body,
    String? xCustomLang,
  }) async {
    final api = ref.read(usersApiProvider);
    try {
      final response =
          await api.patchUserMe(userPatchBody: body, xCustomLang: xCustomLang);

      state = AsyncValue.data(response.data);
    } catch (e) {
      ref.read(loggerProvider).e("", error: e);
      rethrow;
    }
  }
}
