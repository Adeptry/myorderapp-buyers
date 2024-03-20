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

import '../../../../widgets/misc/square_create_card_element/square_create_card_element_stub.dart'
    if (dart.library.html) '../../../../widgets/misc/square_create_card_element/square_create_card_element_web.dart'
    show SquareCreateCardElement;
import '../../../extensions/build_context_extensions.dart';
import '../../../providers/app_config/provider.dart';
import '../../../providers/merchant_id_or_path/provider.dart';
import '../../../providers/platform_messaging_service/provider.dart';
import '../../../providers/platform_messaging_service/stream_provider.dart';
import '../../providers/customer/provider.dart';
import '../../providers/moa_options/provider.dart';

class SquareCardCreateScaffold extends ConsumerWidget {
  const SquareCardCreateScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      platformMessagingProvider,
      (previous, next) async {
        final data = next.value;

        if (data is Map<dynamic, dynamic>) {
          if (data['type'] == 'square_create_card_form_outgoing' &&
              data["payload"] != null) {
            final dynamic payload = data["payload"];

            if (payload == "update") {
              _handleUpdatePlatformMessage(context, ref);
            } else if (payload["sourceId"] != null) {
              _handleAddSquareCardPlatformMessage(
                context,
                ref,
                payload["sourceId"]!,
                payload["verificationToken"],
              );
            }
          }
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.addPayment),
        leading: BackButton(
          onPressed: () => context.navigator.pop(null),
        ),
      ),
      body: const SquareCreateCardElement(),
    );
  }

  _handleUpdatePlatformMessage(BuildContext context, WidgetRef ref) {
    final merchantIdOrPath = ref.read(merchantIdOrPathProvider);
    final moaOptions = ref.read(moaOptionsProvider);
    final customer =
        ref.read(CustomerProvider(merchantIdOrPath: merchantIdOrPath));

    final appConfig = ref.read(
      AppConfigProvider(
        merchantIdOrPath: merchantIdOrPath,
      ),
    );
    ref.read(platformMessagingServiceProvider).postIframeMessage(
      {
        "type": "square_create_card_form_incoming",
        "payload": {
          "buttonText": context.l10n.addPayment,
          "fontFamily": appConfig.valueOrNull?.fontFamily,
          "prefersDark":
              context.theme.brightness == Brightness.dark ? "true" : "false",
          "themeColor": appConfig.valueOrNull?.seedColor,
          "squareApplicationId": moaOptions.squareApplicationId,
          "squareLocationId": customer.value?.preferredLocation?.squareId,
          "consentText": context.l10n.squareCardConsentText,
        },
      },
      moaOptions.appUrl,
    );
  }

  _handleAddSquareCardPlatformMessage(
    BuildContext context,
    WidgetRef ref,
    String sourceId,
    String? verificationToken,
  ) async {
    context.navigator
        .pop((sourceId: sourceId, verificationToken: verificationToken));
  }
}
