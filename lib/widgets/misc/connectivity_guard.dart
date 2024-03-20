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

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/connectivity/stream_provider.dart';
import '../columns/connectivity_result_column.dart';

class ConnectivityGuard extends ConsumerWidget {
  final Widget body;

  const ConnectivityGuard({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityResultValue = ref.watch(connectivityStreamProvider);
    return connectivityResultValue.when(
      data: (value) {
        if (value == ConnectivityResult.none) {
          return const ConnectivityResultNoneColumn();
        } else {
          return body;
        }
      },
      error: (error, stackTrace) => const Scaffold(
        body: Center(
          child: Text("Error"),
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
