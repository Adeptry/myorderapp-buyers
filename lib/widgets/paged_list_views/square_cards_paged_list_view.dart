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
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:myorderapp_square/myorderapp_square.dart';

import '../../constants/widget_constants.dart';
import '../../extensions/build_context_extensions.dart';
import '../../providers/apis/provider.dart';
import '../../providers/customer/provider.dart';
import '../../providers/merchant_id_or_path/provider.dart';
import '../../providers/square_cards_delta/delete_provider.dart';
import '../../providers/square_cards_delta/post_provider.dart';
import '../list_tiles/square_card_list_tile.dart';

class SquareCardsPagedListView extends ConsumerStatefulWidget {
  final Function(SquareCard? squareCard)? onTapSquareCardListTile;

  const SquareCardsPagedListView({super.key, this.onTapSquareCardListTile});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SquareCardsPagedListViewState();
}

class _SquareCardsPagedListViewState
    extends ConsumerState<SquareCardsPagedListView> {
  final PagingController<String?, SquareCard> _pagingController =
      PagingController(firstPageKey: null);

  @override
  void initState() {
    final merchantIdOrPath = ref.read(merchantIdOrPathProvider);
    _pagingController.addPageRequestListener((pageKey) async {
      final api = ref.read(cardsApiProvider);
      try {
        final response = await api.getCardsMe(
          cursor: pageKey,
          merchantIdOrPath: merchantIdOrPath,
          xCustomLang: context.locale.languageCode,
        );

        final isLastPage = (response.data?.cursor) == null;
        if (isLastPage) {
          _pagingController.appendLastPage(response.data?.cards ?? []);
        } else {
          _pagingController.appendPage(
            response.data?.cards ?? [],
            response.data?.cursor,
          );
        }
      } catch (error) {
        _pagingController.error = error;
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final merchantIdOrPath = ref.watch(merchantIdOrPathProvider);
    final customer =
        ref.watch(CustomerProvider(merchantIdOrPath: merchantIdOrPath));
    final squareCardsDeltaNotifier =
        ref.watch(squareDeleteCardsProvider.notifier);

    ref.listen(
      squarePostCardsProvider,
      (_, next) {
        _pagingController.refresh();
      },
    );

    ref.listen(
      squareDeleteCardsProvider,
      (_, next) {
        _pagingController.refresh();
      },
    );

    return RefreshIndicator(
      onRefresh: () => Future.sync(
        () {
          _pagingController.refresh();
        },
      ),
      child: PagedListView<String?, SquareCard>.separated(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<SquareCard>(
          firstPageErrorIndicatorBuilder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.credit_card_off),
              const SizedBox(height: WidgetConstants.defaultPaddingDouble),
              Text(
                context.l10n.squareCardsPagedListViewNoItemsTitle,
                style: context.headerTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: WidgetConstants.extraSmallPaddingDouble),
              Text(
                context.l10n.squareCardsPagedListViewNoItemsSubtitle,
                style: context.bodyLargeTextStyle,
              ),
            ],
          ),
          noItemsFoundIndicatorBuilder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.credit_card_off),
              const SizedBox(height: WidgetConstants.defaultPaddingDouble),
              Text(
                context.l10n.squareCardsPagedListViewNoItemsTitle,
                style: context.headerTextStyle,
              ),
              const SizedBox(height: WidgetConstants.extraSmallPaddingDouble),
              Text(
                context.l10n.squareCardsPagedListViewNoItemsSubtitle,
                textAlign: TextAlign.center,
                style: context.bodyLargeTextStyle,
              ),
            ],
          ),
          itemBuilder: (context, squareCard, index) => SquareCardListTile(
            squareCard: squareCard,
            onTap: widget.onTapSquareCardListTile,
            selected: customer.value?.preferredSquareCard?.id == squareCard.id,
            onPressedDelete: (squareCard) {
              squareCardsDeltaNotifier.deleteOrThrow(
                merchantIdOrPath: merchantIdOrPath,
                squareCard: squareCard,
              );
            },
          ),
        ),
        separatorBuilder: (context, index) => const Divider(),
        physics: const AlwaysScrollableScrollPhysics(),
      ),
    );
  }
}
