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
import 'package:maps_launcher/maps_launcher.dart';

import '../../extensions/build_context_extensions.dart';
import '../../extensions/myorderapp_square/address_entity_extensions.dart';
import '../../providers/merchant/provider.dart';
import '../../providers/merchant_id_or_path/provider.dart';
import '../../providers/moa_firebase/provider.dart';
import '../../providers/order/order_provider.dart';
import '../list_views/order_list_view.dart';

class OrderScaffold extends ConsumerStatefulWidget {
  final String orderId;

  const OrderScaffold({required this.orderId, super.key});

  @override
  ConsumerState<OrderScaffold> createState() => _OrderScaffoldState();
}

class _OrderScaffoldState extends ConsumerState<OrderScaffold> {
  @override
  void initState() {
    super.initState();

    MoaFirebase.requestPermissionIfNecessary();
  }

  @override
  Widget build(BuildContext context) {
    final merchantIdOrPath = ref.watch(merchantIdOrPathProvider);
    final merchantState = ref.watch(
      MerchantProvider(
        merchantIdOrPath: merchantIdOrPath,
        xCustomLang: context.locale.languageCode,
      ),
    );
    final merchant = merchantState.valueOrNull;
    final languageCode = context.locale.languageCode;

    final order = ref.watch(
      orderProvider(
        merchantIdOrPath: merchantIdOrPath,
        orderId: widget.orderId,
        xCustomLang: languageCode,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.orderReference(
            order.valueOrNull?.displayId ?? "",
          ),
        ),
      ),
      body: order.when(
        data: (order) => OrderListView(
          order,
          currencyCode: merchant?.currencyCode ?? 'USD',
          onTapLaunchMaps: (location) {
            final query = location.address?.formattedSummary;
            if (query != null) {
              MapsLauncher.launchQuery(query);
            }
          },
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) =>
            const Text('Oops, something unexpected happened'),
      ),
    );
  }
}
