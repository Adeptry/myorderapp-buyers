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
import 'package:myorderapp/providers/category_scaffold/provider.dart';

import '../../constants/widget_constants.dart';
import '../../extensions/build_context_extensions.dart';
import '../../providers/authentication_storage/provider.dart';
import '../../providers/location_list/provider.dart';
import '../../providers/merchant_id_or_path/provider.dart';
import '../../routes/catalog/catalog_locations_route_data.dart';
import '../../routes/root_route_data.dart';
import '../../utils/show_bottom_page.dart';
import '../buttons/preferred_location_button.dart';
import '../scaffolds/authentication_scaffold.dart';
import '../scaffolds/catalog_scaffold.dart';

class AdaptiveShellScafoldAppBar extends ConsumerWidget
    implements PreferredSizeWidget {
  final int selectedIndex;
  final bool automaticallyImplyLeading;
  final String title;

  const AdaptiveShellScafoldAppBar({
    required this.selectedIndex,
    required this.automaticallyImplyLeading,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final merchantIdOrPath = ref.watch(merchantIdOrPathProvider);
    final categoryScaffoldProvider = CategoryScaffoldProvider(
      context.locale.languageCode,
    );
    final categoryScaffoldState = ref.watch(categoryScaffoldProvider);
    final categoryScaffoldNotifier =
        ref.watch(categoryScaffoldProvider.notifier);

    final locationsListAsyncValue = ref.watch(
      LocationListProvider(
        merchantIdOrPath: merchantIdOrPath,
        page: 1,
        limit: 2,
        xCustomLang: context.locale.languageCode,
      ),
    );
    final locationsList = locationsListAsyncValue.valueOrNull ?? [];

    final showCategoryMenu = !automaticallyImplyLeading &&
        selectedIndex == 0 &&
        Breakpoints.small.isActive(context);

    return AppBar(
      title: Text(title),
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: showCategoryMenu
          ? IconButton(
              onPressed: () {
                (categoriesScaffoldKey.currentState?.isDrawerOpen ?? false)
                    ? categoriesScaffoldKey.currentState?.closeDrawer()
                    : categoriesScaffoldKey.currentState?.openDrawer();
              },
              icon: const Icon(Icons.list),
              tooltip: context.l10n.categories,
            )
          : null,
      actions: [
        if (selectedIndex == 0) ...[
          Padding(
            padding: const EdgeInsets.only(
              right: WidgetConstants.smallPaddingDouble,
            ),
            child: IconButton(
              onPressed: () {
                categoryScaffoldNotifier.toggleAllExpanded();
              },
              icon: categoryScaffoldState.anyExpanded()
                  ? const Icon(Icons.unfold_less)
                  : const Icon(Icons.unfold_more),
            ),
          ),
        ],
        if (selectedIndex == 0 && locationsList.length > 1) ...[
          Padding(
            padding: const EdgeInsets.only(
              right: WidgetConstants.smallPaddingDouble,
            ),
            child: SelectLocationButton(
              onPressed: () async {
                final authenticationState =
                    ref.read(authenticationStorageProvider);
                if (authenticationState.isAuthenticated) {
                  CatalogLocationsRouteData(
                    merchantIdOrPath: merchantIdOrPath,
                  ).go(context);
                } else {
                  final result = await showFullHeightModalBottomSheet<bool>(
                    context: context,
                    child: const AuthenticationScaffold(),
                  );
                  if (result != null && result && context.mounted) {
                    CatalogLocationsRouteData(
                      merchantIdOrPath: merchantIdOrPath,
                    ).go(context);
                  }
                }
              },
            ),
          ),
        ],
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
