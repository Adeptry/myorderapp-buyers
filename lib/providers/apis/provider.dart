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

import '../sessioned_client/provider.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
AppConfigsApi appConfigsApi(AppConfigsApiRef ref) {
  return ref.watch(sessionedClientProvider).getAppConfigsApi();
}

@Riverpod(keepAlive: true)
AuthenticationApi authenticationApi(AuthenticationApiRef ref) {
  return ref.watch(sessionedClientProvider).getAuthenticationApi();
}

@Riverpod(keepAlive: true)
CardsApi cardsApi(CardsApiRef ref) {
  return ref.watch(sessionedClientProvider).getCardsApi();
}

@Riverpod(keepAlive: true)
CatalogsApi catalogsApi(CatalogsApiRef ref) {
  return ref.watch(sessionedClientProvider).getCatalogsApi();
}

@Riverpod(keepAlive: true)
CustomersApi customersApi(CustomersApiRef ref) {
  return ref.watch(sessionedClientProvider).getCustomersApi();
}

@Riverpod(keepAlive: true)
LocationsApi locationsApi(LocationsApiRef ref) {
  return ref.watch(sessionedClientProvider).getLocationsApi();
}

@Riverpod(keepAlive: true)
MerchantsApi merchantsApi(MerchantsApiRef ref) {
  return ref.watch(sessionedClientProvider).getMerchantsApi();
}

@Riverpod(keepAlive: true)
OrdersApi ordersApi(OrdersApiRef ref) {
  return ref.watch(sessionedClientProvider).getOrdersApi();
}

@Riverpod(keepAlive: true)
UsersApi usersApi(UsersApiRef ref) {
  return ref.watch(sessionedClientProvider).getUsersApi();
}
