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

class QuanityPicker extends StatefulWidget {
  final ValueChanged<int>? onQuantityChanged; // Callback to inform parent
  final int initialQuantity;

  const QuanityPicker({
    super.key,
    this.onQuantityChanged,
    this.initialQuantity = 1,
  });

  @override
  State<QuanityPicker> createState() => _QuanityPickerState();
}

class _QuanityPickerState extends State<QuanityPicker> {
  late int _quantity;
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
    _quantityController = TextEditingController(text: '$_quantity');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Define the border color here
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: _quantity > 1
                ? () {
                    setState(() {
                      _quantity -= 1;
                      _quantityController.text = '$_quantity';
                      widget.onQuantityChanged?.call(_quantity);
                    });
                  }
                : null,
          ),
          SizedBox(
            width: 50,
            child: TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                // Remove the underline from TextField
                border: InputBorder.none,
              ),
              onChanged: (value) {
                int? newQuantity = int.tryParse(value);
                if (newQuantity != null && newQuantity > 0) {
                  setState(() {
                    _quantity = newQuantity;
                    widget.onQuantityChanged?.call(_quantity);
                  });
                } else {
                  _quantityController.text = '$_quantity';
                }
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                _quantity += 1;
                _quantityController.text = '$_quantity';
                widget.onQuantityChanged?.call(_quantity);
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }
}
