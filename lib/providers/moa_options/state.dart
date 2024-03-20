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

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myorderapp_square/myorderapp_square.dart';

import '../../moa_constants.dart';

part 'state.freezed.dart';

@freezed
class MoaOptionsState with _$MoaOptionsState {
  const MoaOptionsState._();

  const factory MoaOptionsState({
    required String initialPath,
    required String appleClientId,
    String? applePayMerchantId,
    required String googleServerClientId,
    String? googleIosClientId,
    required String appUrl,
    required String merchantsFrontendUrl,
    required String backendUrl,
    required String backendApiKey,
    required String squareApplicationId,
    required int googlePayEnvironment,
    required String name,
    required ThemeModeEnum themeMode,
    required String seedColor,
    required bool useMaterial3,
    required String fontFamily,
  }) = _MoaOptionsState;

  String get appleRedirectUrl => "$appUrl/api/auth/callback/apple";

  bool get isSquareDevelopmentApplication =>
      MoaConstants.developmentSquareApplicationId == squareApplicationId;

  static const String rootRedirectUrl = "https://get.myorderapp.com";
  static const String privacyUrl = "https://get.myorderapp.com/privacy";
  static const String termsUrl = "https://get.myorderapp.com/terms";

  static const String version = "2.5.19+53";
  static const String legalese = "© 2023 MyOrderApp";

  static const String demoMerchantId = "7gsuScuwHxccK3waeDD8n";
  static const String demoPath = "myorderapp-demo";
}
