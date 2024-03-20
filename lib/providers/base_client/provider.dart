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

import '../../utils/error_response_exception.dart';
import '../dio_base_options/provider.dart';
import '../logger/provider.dart';
import '../moa_options/provider.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
MyorderappSquare baseClient(BaseClientRef ref) {
  final dioBaseOptions = ref.watch(dioBaseOptionsProvider);
  final logger = ref.read(loggerProvider);
  final dio = Dio(dioBaseOptions);
  final moaOptions = ref.watch(moaOptionsProvider);

  return MyorderappSquare(
    dio: dio,
    basePathOverride: moaOptions.backendUrl,
    interceptors: [
      RetryInterceptor(dio: dio),
      InterceptorsWrapper(
        onError: (e, handler) {
          final responseData = e.response?.data;

          if (responseData is Map<String, dynamic>) {
            try {
              final errorResponse = ErrorResponse.fromJson(responseData);
              handler.reject(
                ErrorResponseException(
                  errorResponse: errorResponse,
                  requestOptions: e.requestOptions,
                ),
              );
              return;
            } catch (e2) {
              logger.e("Error parsing error response", error: e2);
              handler.next(e);
            }
          }
          handler.next(e);
        },
      ),
    ],
  );
}
