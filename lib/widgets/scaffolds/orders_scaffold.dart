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

import '../../providers/merchant_id_or_path/provider.dart';
import '../../routes/orders/order_route_data.dart';
import '../../routes/root_route_data.dart';
import '../paged_list_views/orders_paged_list_view.dart';

class OrdersScaffold extends ConsumerWidget {
  const OrdersScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final merchantIdOrPath = ref.watch(merchantIdOrPathProvider);

    return Scaffold(
      body: OrdersPagedListView(
        onTap: (order) {
          OrderRouteData(merchantIdOrPath: merchantIdOrPath, orderId: order.id!)
              .go(context);
        },
      ),
    );
  }
}
