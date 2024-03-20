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
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../logger/provider.dart';
import 'provider.dart';

part 'stream_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<ConnectivityResult?> connectivityStream(
  ConnectivityStreamRef ref,
) async* {
  final provider = ref.read(connectivityProvider);

  try {
    yield await provider.checkConnectivity();
  } on PlatformException catch (e) {
    ref.read(loggerProvider).e('Couldn\'t check connectivity status', error: e);
    yield null;
  }

  await for (final ConnectivityResult result
      in provider.onConnectivityChanged) {
    yield result;
  }
}
