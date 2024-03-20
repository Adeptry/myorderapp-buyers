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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../providers/moa_options/state.dart';
import 'account/account_email_route_data.dart';
import 'account/account_name_route_data.dart';
import 'account/account_notifications_route_data.dart';
import 'account/account_password_route_data.dart';
import 'account/account_phone_route_data.dart';
import 'account/index_route_data.dart';
import 'account/payment_methods_route_data/add_payment_method_route_data.dart';
import 'account/payment_methods_route_data/index.dart';
import 'adaptive_shell_route_data.dart';
import 'catalog/catalog_item_route_data.dart';
import 'catalog/catalog_locations_route_data.dart';
import 'catalog/current_order_route_data/current_order_locations_route_data.dart';
import 'catalog/current_order_route_data/current_order_payment_route_data.dart';
import 'catalog/current_order_route_data/index.dart';
import 'catalog/index_route_data.dart';
import 'orders/index_route_data.dart';
import 'orders/order_route_data.dart';

part 'root_route_data.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

@TypedGoRoute<RootRouteData>(
  path: "/",
  routes: [
    TypedShellRoute<AdaptiveShellRouteData>(
      routes: [
        TypedGoRoute<CatalogRouteData>(
          path: ":merchantIdOrPath${CatalogRouteData.path}",
          routes: [
            TypedGoRoute<CatalogLocationsRouteData>(
              path: CatalogLocationsRouteData.path,
            ),
            TypedGoRoute<CurrentOrderRouteData>(
              path: CurrentOrderRouteData.path,
              routes: [
                TypedGoRoute<CurrentOrderLocationsRouteData>(
                  path: CurrentOrderLocationsRouteData.path,
                ),
                TypedGoRoute<CurrentOrderPaymentRouteData>(
                  path: CurrentOrderPaymentRouteData.path,
                ),
              ],
            ),
            TypedGoRoute<CatalogItemRouteData>(path: CatalogItemRouteData.path),
          ],
        ),
        TypedGoRoute<OrdersRouteData>(
          path: ":merchantIdOrPath/${OrdersRouteData.path}",
          routes: [
            TypedGoRoute<OrderRouteData>(path: OrderRouteData.path),
          ],
        ),
        TypedGoRoute<AccountRouteData>(
          path: ":merchantIdOrPath/${AccountRouteData.path}",
          routes: [
            TypedGoRoute<AccountNotificationsRouteData>(
              path: AccountNotificationsRouteData.path,
            ),
            TypedGoRoute<AccountNameRouteData>(path: AccountNameRouteData.path),
            TypedGoRoute<AccountEmailRouteData>(
              path: AccountEmailRouteData.path,
            ),
            TypedGoRoute<AccountPasswordRouteData>(
              path: AccountPasswordRouteData.path,
            ),
            TypedGoRoute<AccountPhoneRouteData>(
              path: AccountPhoneRouteData.path,
            ),
            TypedGoRoute<PaymentsMethodsRouteData>(
              path: PaymentsMethodsRouteData.path,
              routes: [
                TypedGoRoute<PaymentMethodsAddRouteData>(
                  path: PaymentMethodsAddRouteData.path,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
)
class RootRouteData extends GoRouteData {
  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    if (state.pathParameters.containsKey("merchantIdOrPath")) {
      return super.redirect(context, state);
    } else {
      await launchUrlString(
        MoaOptionsState.rootRedirectUrl,
        webOnlyWindowName: "_self",
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
