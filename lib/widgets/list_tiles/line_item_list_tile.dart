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
import '../../extensions/dart/optional_string_extensions.dart';
import '../../extensions/myorderapp_square/line_item_entity_extensions.dart';

class LineItemListTile extends StatelessWidget {
  final LineItemEntity lineItem;
  final String currencyCode;
  final Function(LineItemEntity lineItem)? deleteOnPress;
  final Function(LineItemEntity lineItem)? editOnPress;

  const LineItemListTile({
    super.key,
    required this.lineItem,
    required this.currencyCode,
    this.deleteOnPress,
    this.editOnPress,
  });

  @override
  Widget build(BuildContext context) {
    final titleText = Text(
      lineItem.formattedSummary,
      style: context.theme.textTheme.bodyLarge,
    );

    final List<Widget> subtitleColumnChildren = [];

    final lineItemModifiersSummary =
        lineItem.formattedModfiersSummary(currencyCode);

    if (lineItemModifiersSummary.isNonNullAndNotEmpty == true) {
      subtitleColumnChildren.add(
        Text(
          lineItemModifiersSummary,
        ),
      );
    }

    if (lineItem.note.isNonNullAndNotEmpty == true) {
      final captionText = Text(
        lineItem.note ?? "",
        style: context.captionTextStyle,
      );
      subtitleColumnChildren.add(captionText);
    }

    final trailingText = Text(
      lineItem.formattedVariationAndModifiersTotalMoneyAmount(
        currencyCode,
      ),
      style: context.captionTextStyle,
    );

    return ListTile(
      leading: (editOnPress != null || deleteOnPress != null)
          ? MenuAnchor(
              menuChildren: [
                if (editOnPress != null) ...[
                  MenuItemButton(
                    onPressed: () => editOnPress?.call(lineItem),
                    leadingIcon: const Icon(Icons.edit),
                    child: Text(context.l10n.edit),
                  ),
                ],
                if (deleteOnPress != null) ...[
                  MenuItemButton(
                    onPressed: () => deleteOnPress?.call(lineItem),
                    leadingIcon: const Icon(Icons.delete),
                    child: Text(context.l10n.delete),
                  ),
                ],
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
      title: titleText,
      subtitle: subtitleColumnChildren.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: subtitleColumnChildren,
            )
          : null,
      trailing: trailingText,
    );
  }
}
