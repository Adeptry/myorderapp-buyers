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
import '../../providers/customer/provider.dart';
import '../../providers/merchant_id_or_path/provider.dart';
import '../../providers/moa_firebase/provider.dart';
import '../../providers/moa_options/provider.dart';
import '../../providers/square_cards_delta/post_provider.dart';
import '../../utils/show_exception_dialog.dart';
import '../../utils/square/start_card_entry_flow_plugin.dart'
    if (dart.library.html) '../../utils/square/start_card_entry_flow_web.dart';
import '../paged_list_views/square_cards_paged_list_view.dart';

class SquareCardsScaffold extends ConsumerWidget {
  const SquareCardsScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.paymentMethods),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_card),
            onPressed: () {
              _onPressedAddCardIconButton(context, ref);
            },
          ),
        ],
      ),
      body: SquareCardsPagedListView(
        onTapSquareCardListTile: (squareCard) {
          _onTapSquareCardListTile(squareCard!, context, ref);
        },
      ),
    );
  }

  _onPressedAddCardIconButton(BuildContext context, WidgetRef ref) async {
    final moaOptions = ref.read(moaOptionsProvider);

    await squareStartCardEntryFlow(
      applicationId: moaOptions.squareApplicationId,
      context: context,
      onResult: ({sourceId, verificationToken}) async {
        if (sourceId != null) {
          final merchantIdOrPath = ref.read(merchantIdOrPathProvider);
          final squarePostCardsNotifier =
              ref.read(squarePostCardsProvider.notifier);
          context.loaderOverlay.show();
          try {
            await squarePostCardsNotifier.postOrThrow(
              merchantIdOrPath: merchantIdOrPath,
              cardsPostBody: CardsPostBody(
                sourceId: sourceId,
                verificationToken: verificationToken,
              ),
              xCustomLang: context.locale.languageCode,
            );
            await MoaFirebase.analytics?.logAddPaymentInfo();
            if (context.mounted) {
              context.loaderOverlay.hide();
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
      },
    );
  }

  _onTapSquareCardListTile(
    SquareCard squareCard,
    BuildContext context,
    WidgetRef ref,
  ) async {
    final merchantIdOrPath = ref.read(merchantIdOrPathProvider);
    final customerNotifier = ref.read(
      CustomerProvider(merchantIdOrPath: merchantIdOrPath).notifier,
    );

    final languageCode = context.locale.languageCode;
    context.loaderOverlay.show();
    try {
      await customerNotifier.patchOrThrow(
        customerPatchBody:
            CustomerPatchBody(preferredSquareCardId: squareCard.id),
        merchantIdOrPath: merchantIdOrPath,
        xCustomLang: languageCode,
      );
      if (context.mounted) {
        context.loaderOverlay.hide();
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
