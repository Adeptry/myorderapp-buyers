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

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:myorderapp_square/myorderapp_square.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../authentication_storage/provider.dart';
import '../base_client/provider.dart';
import '../dio_base_options/provider.dart';
import '../logger/provider.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
MyorderappSquare sessionedClient(SessionedClientRef ref) {
  final logger = ref.read(loggerProvider);
  final dioBaseOptions = ref.watch(dioBaseOptionsProvider);
  final baseCustomersClient = ref.watch(baseClientProvider);

  final authenticationStorageStateNotifier =
      ref.watch(authenticationStorageProvider.notifier);

  final refreshDio = Dio(dioBaseOptions);
  refreshDio.interceptors.add(
    RetryInterceptor(dio: refreshDio),
  );

  final refreshAuthApi = AuthenticationApi(refreshDio);
  baseCustomersClient.dio.interceptors.add(
    QueuedInterceptorsWrapper(
      onRequest: (options, handler) async {
        if (authenticationStorageStateNotifier.expiresAtState() != null) {
          if (authenticationStorageStateNotifier
              .expiresAtState()!
              .isBefore(DateTime.timestamp())) {
            try {
              logger.d("Refreshing token because expires ");
              final response = await refreshAuthApi.postRefresh(
                headers: {
                  'Authorization':
                      'Bearer ${authenticationStorageStateNotifier.refreshTokenState()}',
                },
              );
              final loginResponse = response.data;
              if (loginResponse != null) {
                logger.d("Refresh token success");
                await authenticationStorageStateNotifier.write(
                  loginResponse: loginResponse,
                );
                options.headers['Authorization'] =
                    'Bearer ${authenticationStorageStateNotifier.accessTokenState()}';
              }
            } catch (e) {
              logger.e("Error refreshing token", error: e);
              await authenticationStorageStateNotifier.logout();
              options.headers.remove("Authorization");
            }
          } else {
            options.headers['Authorization'] =
                'Bearer ${authenticationStorageStateNotifier.accessTokenState()}';
          }
        }
        handler.next(options);
      },
      onError: (dioException, handler) async {
        final options = dioException.response!.requestOptions;

        if (dioException.response?.statusCode == 401 &&
            authenticationStorageStateNotifier.accessTokenState() != null) {
          logger.d("Received 401 with access token, attempting refresh...");
          try {
            final response = await refreshAuthApi.postRefresh(
              headers: {
                'Authorization':
                    'Bearer ${authenticationStorageStateNotifier.refreshTokenState()}',
              },
            );
            final loginResponse = response.data;
            if (loginResponse != null) {
              logger.d("Refresh token success");
              await authenticationStorageStateNotifier.write(
                loginResponse: loginResponse,
              );
              options.headers['Authorization'] =
                  'Bearer ${authenticationStorageStateNotifier.accessTokenState()}';

              handler.resolve(
                await baseCustomersClient.dio.request(
                  options.path,
                  data: options.data,
                  queryParameters: options.queryParameters,
                  cancelToken: options.cancelToken,
                  onSendProgress: options.onSendProgress,
                  onReceiveProgress: options.onReceiveProgress,
                ),
              );
              return;
            }
          } catch (e) {
            logger.e("Error refreshing token", error: e);
            await authenticationStorageStateNotifier.logout();
            options.headers.remove("Authorization");
          }
        }
        handler.next(dioException);
      },
    ),
  );

  return baseCustomersClient;
}
