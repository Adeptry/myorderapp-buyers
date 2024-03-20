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
import '../moa_firebase/installations_id_change.dart';
import '../moa_firebase/messaging_token_refresh.dart';
import '../moa_firebase/provider.dart';
import '../square_cards_delta/delete_provider.dart';
import '../square_cards_delta/post_provider.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class Customer extends _$Customer {
  @override
  Future<CustomerEntity?> build({
    required String merchantIdOrPath,
  }) async {
    final api = ref.watch(customersApiProvider);
    final logger = ref.read(loggerProvider);
    // for preferred card
    ref.listen(
      squarePostCardsProvider,
      (_, next) async {
        state = AsyncValue.data(
          (await api.getCustomerMe(
            merchantIdOrPath: merchantIdOrPath,
            preferredLocation: true,
            preferredSquareCard: true,
          ))
              .data,
        );
      },
    );

    ref.listen(
      squareDeleteCardsProvider,
      (_, next) async {
        state = AsyncValue.data(
          (await api.getCustomerMe(
            merchantIdOrPath: merchantIdOrPath,
            preferredLocation: true,
            preferredSquareCard: true,
          ))
              .data,
        );
      },
    );

    ref.listen(
      authenticationStorageProvider,
      (_, next) async {
        if (next.isAuthenticated) {
          try {
            final customer = (await api.getCustomerMe(
              merchantIdOrPath: merchantIdOrPath,
              preferredLocation: true,
              preferredSquareCard: true,
            ))
                .data;
            state = AsyncValue.data(
              customer,
            );
          } catch (error) {
            logger.e("", error: error);
          }

          try {
            final installationId = await MoaFirebase.installations?.getId();
            final cloudMessagingToken = await MoaFirebase.messaging?.getToken();
            await updateAppInstallOrThrow(
              firebaseCloudMessagingToken: cloudMessagingToken,
              firebaseInstallationId: installationId,
            );
          } catch (error) {
            logger.e("", error: error);
          }
        } else {
          state = const AsyncValue.data(null);
        }
      },
    );

    ref.listen(
      installationsIdChangeProvider,
      (previous, next) async {
        final token = next.valueOrNull;
        if (token != null) {
          try {
            await updateAppInstallOrThrow(
              firebaseInstallationId: token,
            );
          } catch (error) {
            logger.e("", error: error);
          }
        }
      },
    );

    ref.listen(
      messagingTokenRefreshProvider,
      (previous, next) async {
        final token = next.valueOrNull;
        if (token != null) {
          try {
            await updateAppInstallOrThrow(
              firebaseCloudMessagingToken: token,
            );
          } catch (error) {
            logger.e("", error: error);
          }
        }
      },
    );

    try {
      final response = await api.getCustomerMe(
        merchantIdOrPath: merchantIdOrPath,
        preferredLocation: true,
        preferredSquareCard: true,
      );
      return response.data;
    } catch (error) {
      ref.read(loggerProvider).e("", error: error);
      rethrow;
    }
  }

  Future<void> postAndSetOrThrow({
    required String merchantIdOrPath,
    String? xCustomLang,
  }) async {
    final api = ref.read(customersApiProvider);
    final authenticationStorageState = ref.read(authenticationStorageProvider);
    if (!authenticationStorageState.isAuthenticated) {
      state = const AsyncValue.data(null);
      return;
    }

    final response = await api.postCustomerMe(
      merchantIdOrPath: merchantIdOrPath,
      preferredLocation: true,
      xCustomLang: xCustomLang,
    );

    state = AsyncValue.data(response.data);
  }

  Future<bool> patchOrThrow({
    required String merchantIdOrPath,
    required CustomerPatchBody customerPatchBody,
    String? xCustomLang,
  }) async {
    final api = ref.read(customersApiProvider);
    try {
      final response = await api.patchCustomerMe(
        merchantIdOrPath: merchantIdOrPath,
        customerPatchBody: customerPatchBody,
        preferredLocation: true,
        preferredSquareCard: true,
        xCustomLang: xCustomLang,
      );

      state = AsyncValue.data(response.data);
      return true;
    } catch (e) {
      ref.read(loggerProvider).e("", error: e);
      rethrow;
    }
  }

  Future<bool> deleteOrThrow({
    required String merchantIdOrPath,
    String? xCustomLang,
  }) async {
    final api = ref.read(customersApiProvider);
    try {
      final response = await api.deleteCustomerMe(
        merchantIdOrPath: merchantIdOrPath,
        xCustomLang: xCustomLang,
      );

      state = AsyncData(response.data);
      return true;
    } catch (e) {
      ref.read(loggerProvider).e("", error: e);
      rethrow;
    }
  }

  Future<bool> updateAppInstallOrThrow({
    String? firebaseCloudMessagingToken,
    String? firebaseInstallationId,
  }) async {
    final api = ref.read(customersApiProvider);
    try {
      await api.updateAppInstallMe(
        appInstallPostBody: AppInstallPostBody(
          firebaseCloudMessagingToken: firebaseCloudMessagingToken,
          firebaseInstallationId: firebaseInstallationId,
        ),
        merchantIdOrPath: merchantIdOrPath,
      );

      return true;
    } catch (e) {
      ref.read(loggerProvider).e("", error: e);
      rethrow;
    }
  }
}
