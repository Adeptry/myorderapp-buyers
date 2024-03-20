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

import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:universal_html/html.dart' as universal_html;
import 'package:universal_platform/universal_platform.dart';

import '../../constants/widget_constants.dart';
import '../../extensions/build_context_extensions.dart';
import '../../providers/app_config/provider.dart';
import '../../providers/authentication_storage/provider.dart';
import '../../providers/merchant_id_or_path/provider.dart';
import '../../providers/moa_firebase/remote_message.dart';
import '../../routes/account/index_route_data.dart';
import '../../routes/catalog/index_route_data.dart';
import '../../routes/orders/index_route_data.dart';
import '../../routes/root_route_data.dart';
import '../../utils/show_bottom_page.dart';
import '../app_bars/adaptive_shell_scaffold_app_bar.dart';
import 'authentication_scaffold.dart';

class AdaptiveShellScaffold extends ConsumerWidget {
  final Widget body;
  final GoRouterState routerState;

  static final List<String> _destinations = [
    CatalogRouteData.path,
    OrdersRouteData.path,
    AccountRouteData.path,
  ];

  const AdaptiveShellScaffold({
    super.key,
    required this.body,
    required this.routerState,
  });

  int get _selectedIndex {
    if (routerState.uri.pathSegments.length > 1) {
      final destinationIndexOfFirstPathSegment =
          _destinations.indexOf(routerState.uri.pathSegments[1]);
      if (destinationIndexOfFirstPathSegment >= 0) {
        return destinationIndexOfFirstPathSegment;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final merchantIdOrPath = ref.watch(merchantIdOrPathProvider);

    final appConfigState = ref.watch(
      AppConfigProvider(
        merchantIdOrPath: merchantIdOrPath,
      ),
    );

    ref.listen(moaRemoteMessageProvider, (previous, next) {
      final body = next.valueOrNull?.notification?.body;
      if (body != null) {
        showSimpleNotification(
          Text(body),
          duration: WidgetConstants.notificationDuration,
        );
      }
    });

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallDesktop = Breakpoints.smallDesktop.isActive(context);
        final isMediumOrUp = Breakpoints.mediumAndUp.isActive(context);
        final appConfigAllowsAdaptiveScaffold =
            (appConfigState.valueOrNull?.useAdaptiveScaffold ?? true);
        final useAdaptiveScaffold =
            (UniversalPlatform.isWeb || isSmallDesktop || isMediumOrUp) &&
                appConfigAllowsAdaptiveScaffold;
        return appConfigState.when(
          loading: () => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, stackTrace) => const Scaffold(
            body: Center(
              child: Text("Error"),
            ),
          ),
          data: (value) {
            final appBar = AdaptiveShellScafoldAppBar(
              selectedIndex: _selectedIndex,
              automaticallyImplyLeading:
                  isSmallDesktop && appConfigAllowsAdaptiveScaffold,
              title: value.name ?? '',
            );

            final destinations = [
              NavigationDestination(
                icon: const Icon(Icons.menu_book_outlined),
                selectedIcon: const Icon(Icons.menu_book),
                label: context.l10n.catalog,
              ),
              NavigationDestination(
                icon: const Icon(Icons.list_alt_outlined),
                selectedIcon: const Icon(Icons.list_alt),
                label: context.l10n.orders,
              ),
              NavigationDestination(
                icon: const Icon(Icons.account_circle_outlined),
                selectedIcon: const Icon(Icons.account_circle),
                label: context.l10n.account,
              ),
            ];

            if (useAdaptiveScaffold) {
              return AdaptiveScaffold(
                internalAnimations: false,
                appBarBreakpoint: Breakpoints.smallAndUp,
                appBar: appBar,
                selectedIndex: _selectedIndex,
                onSelectedIndexChange: (index) async {
                  if (isSmallDesktop) {
                    context.navigator.pop();
                  }
                  await _onSelectedIndexChange(context, ref, index);
                },
                destinations: destinations,
                body: (BuildContext context) {
                  return body;
                },
              );
            } else {
              return Scaffold(
                appBar: appBar,
                body: body,
                bottomNavigationBar:
                    AdaptiveScaffold.standardBottomNavigationBar(
                  currentIndex: _selectedIndex,
                  destinations: destinations,
                  onDestinationSelected: (index) =>
                      _onSelectedIndexChange(context, ref, index),
                ),
              );
            }
          },
        );
      },
    );
  }

  Future<void> _onSelectedIndexChange(
    BuildContext context,
    WidgetRef ref,
    int index,
  ) async {
    final merchantIdOrPath = ref.read(merchantIdOrPathProvider);
    final authenticationState = ref.read(authenticationStorageProvider);

    switch (_destinations[index]) {
      case CatalogRouteData.path:
        CatalogRouteData(merchantIdOrPath: merchantIdOrPath).go(context);
        break;
      case OrdersRouteData.path:
        final route = OrdersRouteData(merchantIdOrPath: merchantIdOrPath);

        if (authenticationState.isAuthenticated) {
          route.go(context);
        } else {
          final needsRefresh = await showFullHeightModalBottomSheet<bool>(
            context: context,
            child: const AuthenticationScaffold(),
          );

          final authentication = ref.read(authenticationStorageProvider);
          if (authentication.isAuthenticated && context.mounted) {
            route.go(context);
            if (needsRefresh != null && needsRefresh) {
              universal_html.window.location.href = route.location;
            }
          }
        }

        break;
      case AccountRouteData.path:
        final route = AccountRouteData(merchantIdOrPath: merchantIdOrPath);

        if (!context.mounted) {
          return;
        }

        if (authenticationState.isAuthenticated) {
          route.go(context);
        } else {
          final needsRefresh = await showFullHeightModalBottomSheet<bool>(
            context: context,
            child: const AuthenticationScaffold(),
          );

          final authentication = ref.read(authenticationStorageProvider);
          if (authentication.isAuthenticated && context.mounted) {
            route.go(context);
            if (needsRefresh != null && needsRefresh) {
              universal_html.window.location.href = route.location;
            }
          }
        }

        break;
      default:
        break;
    }
  }
}
