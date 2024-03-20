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

import '../constants/widget_constants.dart';

Future<T?> showConfirmIfInputMatchesDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required String cancelText,
  required String confirmText,
  required String inputText,
  required String labelText,
  required void Function() onPressedConfirm,
}) {
  final TextEditingController controller = TextEditingController();
  final ValueNotifier<bool> isMatching = ValueNotifier<bool>(false);

  controller.addListener(() {
    isMatching.value = controller.text == inputText;
  });

  return showDialog(
    context: context,
    builder: (context) {
      return ValueListenableBuilder<bool>(
        valueListenable: isMatching,
        builder: (context, isMatching, child) {
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(content),
                const SizedBox(height: WidgetConstants.defaultPaddingDouble),
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: labelText,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(cancelText),
              ),
              TextButton(
                onPressed: isMatching
                    ? () {
                        Navigator.pop(context);
                        onPressedConfirm();
                      }
                    : null,
                child: Text(confirmText),
              ),
            ],
          );
        },
      );
    },
  );
}
