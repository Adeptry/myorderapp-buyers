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
import 'package:myorderapp_square/myorderapp_square.dart';
import 'package:shimmer/shimmer.dart';

import '../../extensions/build_context_extensions.dart';
import '../../extensions/dart/list_extensions.dart';
import '../../extensions/material/list_tile_extensions.dart';
import '../../extensions/myorderapp_square/item_entity_extensions.dart';

class ItemListTile extends StatelessWidget {
  final ItemEntity item;
  final String currencyCode;
  final Function(ItemEntity)? onTap;
  final bool shouldLoadNetworkImage;

  const ItemListTile({
    super.key,
    this.onTap,
    required this.item,
    required this.currencyCode,
    required this.shouldLoadNetworkImage,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = item.images?.firstIfNotEmpty?.url;
    return ListTileExtension.captioned(
      title: Text(
        item.name ?? "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: imageUrl != null
          ? AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: shouldLoadNetworkImage
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        errorWidget: null,
                        fadeInDuration: const Duration(milliseconds: 150),
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: context.theme.highlightColor,
                          highlightColor:
                              context.theme.colorScheme.primary.withAlpha(100),
                          child: Container(
                            color: context.theme.cardColor,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            )
          : null,
      subtitle: Text(
        item.description ?? "",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      caption: Text(
        item.formattedPriceRange(
          currencyCode,
        ),
        style: context.captionTextStyle,
      ),
      onTap: () => onTap?.call(item),
    );
  }
}
