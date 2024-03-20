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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:myorderapp_square/myorderapp_square.dart';

import '../../extensions/build_context_extensions.dart';
import '../../extensions/material/scaffold_messenger_extensions.dart';
import '../../extensions/widget_ref_extensions.dart';
import '../../providers/current_order/provider.dart';
import '../../providers/customer/provider.dart';
import '../../providers/merchant_id_or_path/provider.dart';
import '../../utils/show_exception_dialog.dart';
import '../paged_list_views/locations_paged_list_view.dart';
import 'catalog_scaffold.dart';

class LocationsScaffold extends ConsumerWidget {
  const LocationsScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.selectLocation),
      ),
      body: LocationsPagedListView(
        onTap: (location) {
          _onTap(location, context, ref);
        },
      ),
    );
  }

  _onTap(LocationEntity location, BuildContext context, WidgetRef ref) async {
    final merchantIdOrPath = ref.read(merchantIdOrPathProvider);
    final customerProviderNotifier = ref.read(
      CustomerProvider(merchantIdOrPath: merchantIdOrPath).notifier,
    );
    final currentOrderProviderNotifier = ref.read(
      CurrentOrderProvider(merchantIdOrPath: merchantIdOrPath).notifier,
    );

    context.loaderOverlay.show();

    try {
      await currentOrderProviderNotifier.patchAndSetOrThrow(
        merchantIdOrPath: merchantIdOrPath,
        orderPatchDto: OrderPatchBody(locationId: location.id),
      );
    } catch (error) {
      ref.logger.e("", error: error);
      // do nothing beucase is expected if user has no order
    }

    try {
      final result = await customerProviderNotifier.patchOrThrow(
        customerPatchBody: CustomerPatchBody(preferredLocationId: location.id),
        merchantIdOrPath: merchantIdOrPath,
      );

      if (context.mounted) {
        context.loaderOverlay.hide();
        context.navigator.pop();
        if (result && context.mounted) {
          categoriesScaffoldMessengerKey.currentState?.showSnackBarText(
            context.l10n
                .updatedLocation(location.name ?? context.l10n.location),
          );
        }
      }
    } catch (error) {
      if (context.mounted) {
        context.loaderOverlay.hide();
        if (error is Exception) {
          await showExceptionDialog(context: context, exception: error);
        } else {
          await showExceptionDialog(
            context: context,
            exception: Exception(error.toString()),
          );
        }
      }
    }
  }
}
