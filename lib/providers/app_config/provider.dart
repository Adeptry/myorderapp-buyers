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

import '../../extensions/myorderapp_square/app_config_entity_extensions.dart';
import '../../utils/random_app_config.dart';
import '../apis/provider.dart';
import '../moa_options/provider.dart';
import '../platform_messaging_service/stream_provider.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class AppConfig extends _$AppConfig {
  @override
  Future<AppConfigEntity> build({
    required String merchantIdOrPath,
    String? xCustomLang,
  }) async {
    final moaOptions = ref.watch(moaOptionsProvider);
    ref.listen(
      platformMessagingProvider,
      (previous, next) {
        final appConfigFromMessage =
            AppConfigEntityExtensions.fromMessage(next.value);
        if (appConfigFromMessage != null &&
            appConfigFromMessage != state.value) {
          state = AsyncValue.data(appConfigFromMessage);
        }
      },
      fireImmediately: true,
    );

    try {
      final api = ref.read(appConfigsApiProvider);
      final response = await api.getAppConfig(
        merchantIdOrPath: merchantIdOrPath,
        xCustomLang: xCustomLang,
      );
      final apiData = response.data;
      final existingState = state.valueOrNull;
      if (apiData != null && existingState != null) {
        return AppConfigEntity(
          name: apiData.name ?? existingState.name,
          themeMode: apiData.themeMode ?? existingState.themeMode,
          seedColor: apiData.seedColor ?? existingState.seedColor,
          useMaterial3: apiData.useMaterial3 ?? existingState.useMaterial3,
          fontFamily: apiData.fontFamily ?? existingState.fontFamily,
          useAdaptiveScaffold: existingState.useAdaptiveScaffold,
          categoryCollapseThreshold: apiData.categoryCollapseThreshold ??
              existingState.categoryCollapseThreshold,
        );
      } else if (apiData != null) {
        return apiData;
      }
    } catch (error) {
      if (state.valueOrNull != null) {
        return state.valueOrNull!;
      }
    }

    return AppConfigEntity(
      name: moaOptions.name,
      themeMode: moaOptions.themeMode,
      seedColor: moaOptions.seedColor,
      useMaterial3: moaOptions.useMaterial3,
      fontFamily: moaOptions.fontFamily,
    );
  }

  AppConfigEntity randomizeAndSet() {
    final appConfig = randomAppConfig();
    state = AsyncValue.data(appConfig);
    return appConfig;
  }
}
