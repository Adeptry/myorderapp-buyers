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
import 'package:square_in_app_payments/google_pay_constants.dart';

import 'moa_constants.dart';
import 'providers/moa_options/state.dart';

class DefaultMoaOptions {
  static MoaOptionsState get current {
    return local;
  }

  static const local = MoaOptionsState(
    appUrl: "http://localhost:5000",
    appleClientId: MoaConstants.developmentAppleClientId,
    backendApiKey: "1",
    backendUrl: "http://localhost:4000",
    fontFamily: "Roboto",
    googlePayEnvironment: environmentTest,
    googleServerClientId: MoaConstants.developmentGoogleServerClientId,
    initialPath: '/',
    merchantsFrontendUrl: MoaConstants.developmentMerchantUrl,
    name: "",
    seedColor: "#000000",
    squareApplicationId: MoaConstants.developmentSquareApplicationId,
    themeMode: ThemeModeEnum.system,
    useMaterial3: true,
  );

  /*
   * Web
   */

  static const development = MoaOptionsState(
    appUrl: MoaConstants.developmentAppUrl,
    appleClientId: MoaConstants.developmentAppleClientId,
    backendApiKey: MoaConstants.developmentBackendApiKey,
    backendUrl: MoaConstants.developmentBackendUrl,
    fontFamily: "Roboto",
    googlePayEnvironment: environmentTest,
    googleServerClientId: MoaConstants.developmentGoogleServerClientId,
    initialPath: '/',
    merchantsFrontendUrl: MoaConstants.developmentMerchantUrl,
    name: "",
    seedColor: "#000000",
    squareApplicationId: MoaConstants.developmentSquareApplicationId,
    themeMode: ThemeModeEnum.system,
    useMaterial3: true,
  );

  static const production = MoaOptionsState(
    appUrl: MoaConstants.productionAppUrl,
    appleClientId: MoaConstants.productionAppleClientId,
    backendApiKey: MoaConstants.productionBackendApiKey,
    backendUrl: MoaConstants.productionBackendUrl,
    fontFamily: "Roboto",
    googlePayEnvironment: environmentProduction,
    googleServerClientId: MoaConstants.productionGoogleServerClientId,
    initialPath: '/',
    merchantsFrontendUrl: MoaConstants.productionMerchantUrl,
    name: "",
    seedColor: "#000000",
    squareApplicationId: MoaConstants.productionSquareApplicationId,
    themeMode: ThemeModeEnum.system,
    useMaterial3: true,
  );

  /*
   * Native
   */

  static const demo = MoaOptionsState(
    appUrl: MoaConstants.developmentAppUrl,
    appleClientId: MoaConstants.developmentAppleClientId,
    applePayMerchantId: 'merchant.dev.myorderapp.demo',
    backendApiKey: MoaConstants.developmentBackendApiKey,
    backendUrl: MoaConstants.developmentBackendUrl,
    fontFamily: "Roboto",
    googlePayEnvironment: environmentTest,
    googleServerClientId: MoaConstants.developmentGoogleServerClientId,
    initialPath: '/${MoaOptionsState.demoMerchantId}',
    merchantsFrontendUrl: MoaConstants.developmentMerchantUrl,
    name: "MyOrderApp Demo",
    seedColor: "#1976d2",
    squareApplicationId: MoaConstants.developmentSquareApplicationId,
    themeMode: ThemeModeEnum.system,
    useMaterial3: true,
  );
}
