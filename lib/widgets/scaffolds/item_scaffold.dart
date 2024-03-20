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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:universal_html/html.dart' as universal_html;

import '../../constants/widget_constants.dart';
import '../../extensions/build_context_extensions.dart';
import '../../extensions/material/scaffold_messenger_extensions.dart';
import '../../extensions/myorderapp_square/item_entity_extensions.dart';
import '../../providers/authentication_storage/provider.dart';
import '../../providers/current_order/provider.dart';
import '../../providers/item_scaffold/provider.dart';
import '../../providers/merchant/provider.dart';
import '../../providers/merchant_id_or_path/provider.dart';
import '../../providers/moa_firebase/provider.dart';
import '../../providers/moa_options/provider.dart';
import '../../utils/show_bottom_page.dart';
import '../../utils/show_exception_dialog.dart';
import '../buttons/quantity_picker.dart';
import '../menus/item_modifier_list_menu.dart';
import '../menus/variation_radio_menu.dart';
import 'authentication_scaffold.dart';
import 'catalog_scaffold.dart';

final itemPageScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class ItemScaffold extends ConsumerStatefulWidget {
  final String itemId;

  const ItemScaffold({
    required this.itemId,
    super.key,
  });

  @override
  ConsumerState<ItemScaffold> createState() => _ItemScaffoldState();
}

class _ItemScaffoldState extends ConsumerState<ItemScaffold> {
  double _modifiersOpacity = 0.0;
  bool _isCollapsed = false;

  final TextEditingController _noteTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    final state = ref.read(itemScaffoldProvider);

    _noteTextEditingController.text = state?.note ?? "";

    _noteTextEditingController.addListener(() {
      final notifier = ref.read(itemScaffoldProvider.notifier);
      notifier.setNote(note: _noteTextEditingController.text);
    });
  }

  @override
  void dispose() {
    _noteTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(itemScaffoldProvider);
    final notifier = ref.watch(itemScaffoldProvider.notifier);
    final merchantIdOrPath = ref.watch(merchantIdOrPathProvider);
    final merchantState = ref.watch(
      MerchantProvider(
        merchantIdOrPath: merchantIdOrPath,
        xCustomLang: context.locale.languageCode,
      ),
    );
    final merchant = merchantState.valueOrNull;

    if (state?.item == null) {
      notifier.getAndSetOrThrow(
        itemId: widget.itemId,
        xCustomLang: context.locale.languageCode,
      );
    }

    if (state?.itemModifierListsToSelectedModifiers?.keys.isNotEmpty ?? false) {
      setState(() {
        _modifiersOpacity = 1.0;
      });
    }

    final item = state?.item;
    final itemModifierListsToSelectedModifiers =
        state?.itemModifierListsToSelectedModifiers ?? {};

    double screenHeight = MediaQuery.of(context).size.height;
    final expandedHeight = screenHeight * 0.33;
    bool hasImage = (item?.images ?? []).isNotEmpty;

    final theme = context.theme;
    final l10n = context.l10n;

    return ScaffoldMessenger(
      key: itemPageScaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: theme.colorScheme.background,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _floatingActionButtonOnPressed(),
          icon: const Icon(Icons.add_shopping_cart),
          label: Text(
            '${l10n.addToOrder} ${state?.formattedPriceAmount(merchant?.currencyCode)}',
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: hasImage ? expandedHeight : null,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(_isCollapsed ? 0 : 2),
                child: Container(
                  height: _isCollapsed ? 0 : 2,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.background,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
              leading: hasImage
                  ? IconButton.filledTonal(
                      onPressed: () => context.navigator.pop(),
                      icon: const Icon(Icons.arrow_back),
                    )
                  : BackButton(
                      onPressed: () => context.navigator.pop(),
                    ),
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  final percentCollapsed =
                      (((constraints.biggest.height - kToolbarHeight) /
                                  (expandedHeight - kToolbarHeight) *
                                  100)
                              .roundToDouble()) /
                          100;

                  if (percentCollapsed <= 0.05 && !_isCollapsed) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _isCollapsed = true;
                      });
                    });
                  } else if (percentCollapsed >= 0.05 && _isCollapsed) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _isCollapsed = false;
                      });
                    });
                  }

                  Color? color;

                  if (!context.theme.useMaterial3 &&
                      context.theme.brightness == Brightness.light) {
                    color = Color.lerp(
                      theme.colorScheme.surface,
                      theme.colorScheme.onSurface,
                      percentCollapsed,
                    );
                  }

                  return FlexibleSpaceBar(
                    centerTitle: false,
                    title: Text(
                      item?.name ?? '',
                      style: context.titleLargeTextStyle?.copyWith(
                        color: color,
                      ),
                    ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: hasImage
                          ? [
                              CachedNetworkImage(
                                imageUrl: item?.images?.first.url ?? "",
                                fit: BoxFit.cover,
                              ),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      theme.colorScheme.background,
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ]
                          : [],
                    ),
                  );
                },
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                bottom: WidgetConstants.floatingActionButtonBottomPadding,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    ...item?.description != null
                        ? [
                            ListTile(
                              title: Text(
                                item?.description ?? "",
                                style: context.bodyLargeTextStyle,
                              ),
                            ),
                          ]
                        : [],
                    ListTile(
                      title: Text(
                        l10n.quantity,
                        style: context.headerTextStyle,
                      ),
                    ),
                    ListTile(
                      title: Align(
                        alignment: Alignment.centerLeft,
                        child: QuanityPicker(
                          initialQuantity: state?.quantity ?? 0,
                          onQuantityChanged: (quantity) {
                            notifier.setQuantity(
                              quantity: quantity,
                            );
                          },
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        l10n.selectAnOption,
                        style: context.headerTextStyle,
                      ),
                      trailing: Text(
                        l10n.required,
                        style: context.labelSmallTextStyle
                            ?.copyWith(color: theme.colorScheme.error),
                      ),
                    ),
                    VariationRadioMenu(
                      variations: item?.variations ?? [],
                      groupVariationValue: state?.selectedVariation,
                      currencyCode: merchant?.currencyCode ?? "USD",
                      onGroupVariationValueChanged: (value) {
                        notifier.setSelectedVariation(
                          selectedVariation: value,
                        );
                      },
                    ),
                    AnimatedOpacity(
                      duration: WidgetConstants.fastAnimationDuration,
                      opacity: _modifiersOpacity,
                      child: Column(
                        children: [
                          ...itemModifierListsToSelectedModifiers.keys.map(
                            (currentItemModifierList) => ItemModifierListMenu(
                              currencyCode: merchant?.currencyCode ?? 'USD',
                              itemModifierList: currentItemModifierList,
                              modifierToSelectedMap:
                                  itemModifierListsToSelectedModifiers[
                                          currentItemModifierList] ??
                                      {},
                              onModifierSelectedChanged: (modifier, selected) {
                                notifier.setSelectedModifierInItemModifierList(
                                  inItemModifierList: currentItemModifierList,
                                  modifier: modifier,
                                  selected: selected,
                                );
                              },
                            ),
                          ),
                          ListTile(
                            title: Text(
                              context.l10n.noteTitle,
                              style: context.headerTextStyle,
                            ),
                            subtitle: TextField(
                              controller: _noteTextEditingController,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                hintText: context.l10n.noteHintText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _floatingActionButtonOnPressed() async {
    final l10n = context.l10n;
    final authenticationStorage = ref.read(authenticationStorageProvider);
    final state = ref.read(itemScaffoldProvider);
    final merchantIdOrPath = ref.read(merchantIdOrPathProvider);
    final moaOptions = ref.read(moaOptionsProvider);

    final unsatisfiedMinimumItemModifierLists =
        state?.unsatisfiedMinimumItemModifierLists ?? [];
    if (unsatisfiedMinimumItemModifierLists.isNotEmpty) {
      final listString = unsatisfiedMinimumItemModifierLists
          .map((itemModifierList) => itemModifierList.modifierList?.name)
          .toList()
          .join(", ");
      final snackBar = SnackBar(
        content:
            Text(l10n.satisfyMinimumItemModifierListSelections(listString)),
      );
      itemPageScaffoldMessengerKey.currentState?.showSnackBar(snackBar);
    } else {
      if (authenticationStorage.isAuthenticated) {
        await _addItemToOrder();
      } else {
        final needsRefresh = await showFullHeightModalBottomSheet<bool>(
          context: context,
          child: const AuthenticationScaffold(),
        );

        final authentication = ref.read(authenticationStorageProvider);
        if (authentication.isAuthenticated && context.mounted) {
          await _addItemToOrder();
          if (needsRefresh != null && needsRefresh) {
            universal_html.window.location.href =
                '${moaOptions.appUrl}/$merchantIdOrPath';
          }
        }
      }
    }
  }

  Future<void> _addItemToOrder() async {
    final state = ref.read(itemScaffoldProvider);
    final merchantIdOrPath = ref.read(merchantIdOrPathProvider);
    final currentOrderNotifier = ref.read(
      CurrentOrderProvider(merchantIdOrPath: merchantIdOrPath).notifier,
    );
    final merchantState = ref.watch(
      MerchantProvider(
        merchantIdOrPath: merchantIdOrPath,
        xCustomLang: context.locale.languageCode,
      ),
    );

    context.loaderOverlay.show();
    try {
      final result = await currentOrderNotifier.postAndSetOrThrow(
        merchantIdOrPath: merchantIdOrPath,
        orderPostCurrentBody: state!.orderPostCurrentBody,
        xCustomLang: context.locale.languageCode,
      );

      final merchant = merchantState.valueOrNull;
      final item = state.item.analyticsEventItem();
      await MoaFirebase.analytics?.logAddToCart(
        value: (state.totalPriceAmount) / 100,
        currency: merchant?.currencyCode,
        items: [item],
      );

      if (context.mounted) {
        context.loaderOverlay.hide();
        context.navigator.pop();
        if (result && context.mounted) {
          categoriesScaffoldMessengerKey.currentState?.showSnackBarText(
            context.l10n.addedToOrder(state.item.name ?? context.l10n.item),
          );
        }
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
