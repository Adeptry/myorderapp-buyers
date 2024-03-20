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
import 'package:universal_platform/universal_platform.dart';
import 'package:uuid/uuid.dart';

import '../apis/provider.dart';
import '../authentication_storage/provider.dart';
import '../logger/provider.dart';
import 'state.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentOrder extends _$CurrentOrder {
  final Uuid _uuid = const Uuid();

  @override
  Future<CurrentOrderState?> build({
    required String merchantIdOrPath,
    String? xCustomLang,
  }) async {
    final authenticationStorage = ref.read(authenticationStorageProvider);
    final api = ref.read(ordersApiProvider);

    ref.listen(
      authenticationStorageProvider,
      (_, next) async {
        try {
          final response = await api.getOrderCurrent(
            merchantIdOrPath: merchantIdOrPath,
            lineItems: true,
            location: true,
            xCustomLang: xCustomLang,
          );
          state = AsyncValue.data(
            CurrentOrderState(
              order: response.data,
              idempotencyKey: _uuid.v4(),
            ),
          );
        } catch (error) {
          state = AsyncValue.data(
            CurrentOrderState(
              idempotencyKey: _uuid.v4(),
            ),
          );
        }
      },
      fireImmediately: true,
    );

    if (authenticationStorage.isAuthenticated) {
      try {
        final response = await api.getOrderCurrent(
          merchantIdOrPath: merchantIdOrPath,
          lineItems: true,
          location: true,
          xCustomLang: xCustomLang,
        );
        return CurrentOrderState(
          order: response.data,
          idempotencyKey: _uuid.v4(),
        );
      } catch (error) {
        return CurrentOrderState(idempotencyKey: _uuid.v4());
      }
    } else {
      return CurrentOrderState(idempotencyKey: _uuid.v4());
    }
  }

  set pickupDateTime(DateTime dateTime) {
    state = AsyncValue.data(
      state.valueOrNull?.copyWith(pickupDateTime: dateTime),
    );
  }

  String? note() {
    return state.valueOrNull?.note;
  }

  setNote(String? note) {
    state = AsyncValue.data(state.valueOrNull?.copyWith(note: note));
  }

  String? idempotencyKey() {
    return state.valueOrNull?.idempotencyKey;
  }

  setTipMoney({int? tipMoneyPercentage, int? tipMoneyAbsoluteAmount}) {
    state = AsyncValue.data(
      state.valueOrNull?.copyWith(
        tipMoneyPercentage: tipMoneyPercentage ?? 0,
        tipMoneyAbsoluteAmount: tipMoneyAbsoluteAmount ?? 0,
      ),
    );
  }

  Future<bool> deleteLineItemOrThrow({
    required String merchantIdOrPath,
    required String lineItemId,
    String? xCustomLang,
  }) async {
    final api = ref.read(ordersApiProvider);
    try {
      final response = await api.deleteLineItemCurrent(
        id: lineItemId,
        merchantIdOrPath: merchantIdOrPath,
        lineItems: true,
        location: true,
        xCustomLang: xCustomLang,
      );
      if (response.data?.lineItems?.isNotEmpty ?? false) {
        state = AsyncValue.data(
          state.value?.copyWith(order: response.data),
        );
      } else {
        await api.deleteOrderCurrent(merchantIdOrPath: merchantIdOrPath);
        state = AsyncValue.data(
          CurrentOrderState(
            idempotencyKey: _uuid.v4(),
          ),
        );
      }

      return true;
    } catch (error) {
      ref.read(loggerProvider).e("", error: error);
      rethrow;
    }
  }

  Future<bool> postAndSetOrThrow({
    required String merchantIdOrPath,
    required OrderPostCurrentBody orderPostCurrentBody,
    String? xCustomLang,
  }) async {
    final api = ref.read(ordersApiProvider);
    try {
      final response = await api.postOrderCurrent(
        merchantIdOrPath: merchantIdOrPath,
        orderPostCurrentBody: orderPostCurrentBody,
        lineItems: true,
        location: true,
        xCustomLang: xCustomLang,
      );

      state = AsyncValue.data(state.value?.copyWith(order: response.data));

      return true;
    } catch (error) {
      ref.read(loggerProvider).e("", error: error);
      rethrow;
    }
  }

  Future<bool> patchAndSetOrThrow({
    required String merchantIdOrPath,
    required OrderPatchBody orderPatchDto,
    String? xCustomLang,
  }) async {
    final api = ref.read(ordersApiProvider);
    try {
      final response = await api.patchOrderCurrent(
        merchantIdOrPath: merchantIdOrPath,
        orderPatchBody: orderPatchDto,
        lineItems: true,
        location: true,
        xCustomLang: xCustomLang,
      );

      state = AsyncValue.data(state.value?.copyWith(order: response.data));

      return true;
    } catch (error) {
      ref.read(loggerProvider).e("", error: error);
      rethrow;
    }
  }

  Future<OrderEntity> postPaymentAndSetOrThrow({
    required String merchantIdOrPath,
    required String paymentSquareId,
    String? xCustomLang,
  }) async {
    final api = ref.read(ordersApiProvider);
    try {
      final response = await api.postSquarePaymentOrderCurrent(
        merchantIdOrPath: merchantIdOrPath,
        ordersPostPaymentBody: OrdersPostPaymentBody(
          tipMoneyAmount: state.value?.tipMoneyAmount ?? 0,
          note: state.value?.note,
          paymentSquareId: paymentSquareId,
          pickupDateString:
              state.value?.pickupDateTime?.toUtc().toIso8601String(),
          idempotencyKey: state.value!.idempotencyKey!,
          platformIsAndroid: UniversalPlatform.isAndroid,
          platformIsIos: UniversalPlatform.isIOS,
          platformIsWeb: UniversalPlatform.isWeb,
        ),
        location: true,
        lineItems: true,
        xCustomLang: xCustomLang,
      );
      state = AsyncValue.data(CurrentOrderState(idempotencyKey: _uuid.v4()));

      if (response.data == null) {
        throw Exception(
          "Error paying for order ${state.value?.idempotencyKey}",
        );
      }

      return response.data!;
    } catch (e) {
      ref
          .read(loggerProvider)
          .e("Error paying for order ${state.value?.idempotencyKey}", error: e);
      rethrow;
    }
  }
}
