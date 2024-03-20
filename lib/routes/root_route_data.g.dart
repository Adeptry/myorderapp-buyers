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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'root_route_data.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $rootRouteData,
    ];

RouteBase get $rootRouteData => GoRouteData.$route(
      path: '/',
      factory: $RootRouteDataExtension._fromState,
      routes: [
        ShellRouteData.$route(
          navigatorKey: AdaptiveShellRouteData.$navigatorKey,
          factory: $AdaptiveShellRouteDataExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: ':merchantIdOrPath',
              factory: $CatalogRouteDataExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'locations',
                  parentNavigatorKey:
                      CatalogLocationsRouteData.$parentNavigatorKey,
                  factory: $CatalogLocationsRouteDataExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'order/current',
                  parentNavigatorKey: CurrentOrderRouteData.$parentNavigatorKey,
                  factory: $CurrentOrderRouteDataExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'locations',
                      parentNavigatorKey:
                          CurrentOrderLocationsRouteData.$parentNavigatorKey,
                      factory:
                          $CurrentOrderLocationsRouteDataExtension._fromState,
                    ),
                    GoRouteData.$route(
                      path: 'pay',
                      parentNavigatorKey:
                          CurrentOrderPaymentRouteData.$parentNavigatorKey,
                      factory:
                          $CurrentOrderPaymentRouteDataExtension._fromState,
                    ),
                  ],
                ),
                GoRouteData.$route(
                  path: 'items/:itemId',
                  parentNavigatorKey: CatalogItemRouteData.$parentNavigatorKey,
                  factory: $CatalogItemRouteDataExtension._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: ':merchantIdOrPath/orders',
              factory: $OrdersRouteDataExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: ':orderId',
                  parentNavigatorKey: OrderRouteData.$parentNavigatorKey,
                  factory: $OrderRouteDataExtension._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: ':merchantIdOrPath/account',
              factory: $AccountRouteDataExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'notifications',
                  parentNavigatorKey:
                      AccountNotificationsRouteData.$parentNavigatorKey,
                  factory: $AccountNotificationsRouteDataExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'name',
                  parentNavigatorKey: AccountNameRouteData.$parentNavigatorKey,
                  factory: $AccountNameRouteDataExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'email',
                  parentNavigatorKey: AccountEmailRouteData.$parentNavigatorKey,
                  factory: $AccountEmailRouteDataExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'password',
                  parentNavigatorKey:
                      AccountPasswordRouteData.$parentNavigatorKey,
                  factory: $AccountPasswordRouteDataExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'phone',
                  parentNavigatorKey: AccountPhoneRouteData.$parentNavigatorKey,
                  factory: $AccountPhoneRouteDataExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'payment-methods',
                  parentNavigatorKey:
                      PaymentsMethodsRouteData.$parentNavigatorKey,
                  factory: $PaymentsMethodsRouteDataExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'add',
                      parentNavigatorKey:
                          PaymentMethodsAddRouteData.$parentNavigatorKey,
                      factory: $PaymentMethodsAddRouteDataExtension._fromState,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );

extension $RootRouteDataExtension on RootRouteData {
  static RootRouteData _fromState(GoRouterState state) => RootRouteData();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AdaptiveShellRouteDataExtension on AdaptiveShellRouteData {
  static AdaptiveShellRouteData _fromState(GoRouterState state) =>
      const AdaptiveShellRouteData();
}

extension $CatalogRouteDataExtension on CatalogRouteData {
  static CatalogRouteData _fromState(GoRouterState state) => CatalogRouteData(
        merchantIdOrPath: state.pathParameters['merchantIdOrPath']!,
      );

  String get location => GoRouteData.$location(
        '/${Uri.encodeComponent(merchantIdOrPath)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CatalogLocationsRouteDataExtension on CatalogLocationsRouteData {
  static CatalogLocationsRouteData _fromState(GoRouterState state) =>
      CatalogLocationsRouteData(
        merchantIdOrPath: state.pathParameters['merchantIdOrPath']!,
      );

  String get location => GoRouteData.$location(
        '/${Uri.encodeComponent(merchantIdOrPath)}/locations',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CurrentOrderRouteDataExtension on CurrentOrderRouteData {
  static CurrentOrderRouteData _fromState(GoRouterState state) =>
      CurrentOrderRouteData(
        merchantIdOrPath: state.pathParameters['merchantIdOrPath']!,
      );

  String get location => GoRouteData.$location(
        '/${Uri.encodeComponent(merchantIdOrPath)}/order/current',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CurrentOrderLocationsRouteDataExtension
    on CurrentOrderLocationsRouteData {
  static CurrentOrderLocationsRouteData _fromState(GoRouterState state) =>
      CurrentOrderLocationsRouteData(
        merchantIdOrPath: state.pathParameters['merchantIdOrPath']!,
      );

  String get location => GoRouteData.$location(
        '/${Uri.encodeComponent(merchantIdOrPath)}/order/current/locations',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CurrentOrderPaymentRouteDataExtension
    on CurrentOrderPaymentRouteData {
  static CurrentOrderPaymentRouteData _fromState(GoRouterState state) =>
      CurrentOrderPaymentRouteData(
        merchantIdOrPath: state.pathParameters['merchantIdOrPath']!,
      );

  String get location => GoRouteData.$location(
        '/${Uri.encodeComponent(merchantIdOrPath)}/order/current/pay',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CatalogItemRouteDataExtension on CatalogItemRouteData {
  static CatalogItemRouteData _fromState(GoRouterState state) =>
      CatalogItemRouteData(
        merchantIdOrPath: state.pathParameters['merchantIdOrPath']!,
        itemId: state.pathParameters['itemId']!,
      );

  String get location => GoRouteData.$location(
        '/${Uri.encodeComponent(merchantIdOrPath)}/items/${Uri.encodeComponent(itemId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $OrdersRouteDataExtension on OrdersRouteData {
  static OrdersRouteData _fromState(GoRouterState state) => OrdersRouteData(
        merchantIdOrPath: state.pathParameters['merchantIdOrPath']!,
      );

  String get location => GoRouteData.$location(
        '/${Uri.encodeComponent(merchantIdOrPath)}/orders',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $OrderRouteDataExtension on OrderRouteData {
  static OrderRouteData _fromState(GoRouterState state) => OrderRouteData(
        merchantIdOrPath: state.pathParameters['merchantIdOrPath']!,
        orderId: state.pathParameters['orderId']!,
      );

  String get location => GoRouteData.$location(
        '/${Uri.encodeComponent(merchantIdOrPath)}/orders/${Uri.encodeComponent(orderId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AccountRouteDataExtension on AccountRouteData {
  static AccountRouteData _fromState(GoRouterState state) => AccountRouteData(
        merchantIdOrPath: state.pathParameters['merchantIdOrPath']!,
      );

  String get location => GoRouteData.$location(
        '/${Uri.encodeComponent(merchantIdOrPath)}/account',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AccountNotificationsRouteDataExtension
    on AccountNotificationsRouteData {
  static AccountNotificationsRouteData _fromState(GoRouterState state) =>
      AccountNotificationsRouteData(
        merchantIdOrPath: state.pathParameters['merchantIdOrPath']!,
      );

  String get location => GoRouteData.$location(
        '/${Uri.encodeComponent(merchantIdOrPath)}/account/notifications',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AccountNameRouteDataExtension on AccountNameRouteData {
  static AccountNameRouteData _fromState(GoRouterState state) =>
      AccountNameRouteData(
        merchantIdOrPath: state.pathParameters['merchantIdOrPath']!,
      );

  String get location => GoRouteData.$location(
        '/${Uri.encodeComponent(merchantIdOrPath)}/account/name',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AccountEmailRouteDataExtension on AccountEmailRouteData {
  static AccountEmailRouteData _fromState(GoRouterState state) =>
      AccountEmailRouteData(
        merchantIdOrPath: state.pathParameters['merchantIdOrPath']!,
      );

  String get location => GoRouteData.$location(
        '/${Uri.encodeComponent(merchantIdOrPath)}/account/email',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AccountPasswordRouteDataExtension on AccountPasswordRouteData {
  static AccountPasswordRouteData _fromState(GoRouterState state) =>
      AccountPasswordRouteData(
        merchantIdOrPath: state.pathParameters['merchantIdOrPath']!,
      );

  String get location => GoRouteData.$location(
        '/${Uri.encodeComponent(merchantIdOrPath)}/account/password',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AccountPhoneRouteDataExtension on AccountPhoneRouteData {
  static AccountPhoneRouteData _fromState(GoRouterState state) =>
      AccountPhoneRouteData(
        merchantIdOrPath: state.pathParameters['merchantIdOrPath']!,
      );

  String get location => GoRouteData.$location(
        '/${Uri.encodeComponent(merchantIdOrPath)}/account/phone',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PaymentsMethodsRouteDataExtension on PaymentsMethodsRouteData {
  static PaymentsMethodsRouteData _fromState(GoRouterState state) =>
      PaymentsMethodsRouteData(
        merchantIdOrPath: state.pathParameters['merchantIdOrPath']!,
      );

  String get location => GoRouteData.$location(
        '/${Uri.encodeComponent(merchantIdOrPath)}/account/payment-methods',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PaymentMethodsAddRouteDataExtension on PaymentMethodsAddRouteData {
  static PaymentMethodsAddRouteData _fromState(GoRouterState state) =>
      PaymentMethodsAddRouteData(
        merchantIdOrPath: state.pathParameters['merchantIdOrPath']!,
      );

  String get location => GoRouteData.$location(
        '/${Uri.encodeComponent(merchantIdOrPath)}/account/payment-methods/add',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
