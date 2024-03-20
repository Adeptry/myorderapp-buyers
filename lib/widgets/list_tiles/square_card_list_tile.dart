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
import 'package:myorderapp_square/myorderapp_square.dart';

import '../../extensions/build_context_extensions.dart';
import '../../extensions/dart/optional_bool_extensions.dart';
import '../../extensions/myorderapp_square/square_card_extensions.dart';

class SquareCardListTile extends StatelessWidget {
  final SquareCard? squareCard;
  final bool? selected;
  final Widget? trailing;
  final bool? isLoading;
  final Function(SquareCard?)? onTap;
  final Function(SquareCard)? onPressedDelete;

  const SquareCardListTile({
    super.key,
    required this.squareCard,
    this.isLoading,
    this.onPressedDelete,
    this.onTap,
    this.selected,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final selectedOrFalse = selected ?? false;
    final showMenu = squareCard != null;

    return ListTile(
      onTap: () {
        onTap?.call(squareCard);
      },
      selected: selectedOrFalse,
      trailing: trailing ?? (selectedOrFalse ? const Icon(Icons.check) : null),
      title: Text(
        squareCard?.formattedTitle ??
            (isLoading.orFalse
                ? ""
                : context.l10n.squareCardListTileEmptyTitle),
        style: context.bodyLargeTextStyle,
      ),
      subtitle: Text(
        squareCard?.formattedSubtitle ??
            (isLoading.orFalse
                ? ""
                : context.l10n.squareCardListTileEmptySubtitle),
      ),
      leading: showMenu
          ? MenuAnchor(
              menuChildren: [
                MenuItemButton(
                  onPressed: () {
                    onPressedDelete?.call(squareCard!);
                  },
                  leadingIcon: const Icon(Icons.delete),
                  child: Text(context.l10n.delete),
                ),
              ],
              builder: (
                BuildContext context,
                MenuController controller,
                Widget? child,
              ) {
                return IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                );
              },
            )
          : null,
    );
  }
}
