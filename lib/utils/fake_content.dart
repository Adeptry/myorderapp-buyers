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

import 'package:faker_dart/faker_dart.dart';
import 'package:myorderapp_square/myorderapp_square.dart';

final faker = Faker.instance;

List<CategoryEntity> fakeCatalog() {
  final count = fakeCount();
  return List.generate(count, (index) => fakeCategory());
}

int fakeCount() {
  return faker.datatype.number(min: 3, max: 8);
}

int fakePrice() {
  return faker.datatype.number(min: 100, max: 10000);
}

CategoryEntity fakeCategory() {
  return CategoryEntity(
    id: faker.datatype.uuid(),
    name: faker.commerce.productName(),
    items: fakeItems(count: fakeCount()),
  );
}

List<CategoryEntity> fakeCategories(int count) {
  return List.generate(count, (index) => fakeCategory());
}

ItemEntity fakeItem() {
  return ItemEntity(
    id: faker.datatype.uuid(),
    name: faker.commerce.productName(),
    description: faker.commerce.productDescription(),
    variations: fakeVariations(count: fakeCount()),
    itemModifierLists: fakeItemModifierLists(count: fakeCount()),
    images: [CatalogImageEntity(url: fakeImageUrl())],
  );
}

String fakeImageUrl() {
  final width = faker.datatype.number(min: 1200, max: 1600);
  final height = faker.datatype.number(min: 1000, max: 1200);
  return faker.image.loremPicsum
      .image(width: width, height: height, seed: "$width$height");
}

List<ItemEntity> fakeItems({required int count}) {
  return List.generate(count, (index) => fakeItem());
}

VariationEntity fakeVariation() {
  return VariationEntity(
    id: faker.datatype.uuid(),
    name: faker.commerce.productName(),
    priceMoneyAmount: fakePrice(),
  );
}

List<VariationEntity> fakeVariations({required int count}) {
  return List.generate(count, (index) => fakeVariation());
}

List<ItemModifierListEntity> fakeItemModifierLists({required int count}) {
  return List.generate(count, (index) => fakeItemModifierList());
}

ItemModifierListEntity fakeItemModifierList() {
  final modifierCount = fakeCount();
  final minSelected = faker.datatype.number(min: -1, max: modifierCount);
  final maxSelected =
      faker.datatype.number(min: minSelected, max: modifierCount);

  return ItemModifierListEntity(
    id: faker.datatype.uuid(),
    minSelectedModifiers: minSelected,
    maxSelectedModifiers: maxSelected,
    modifierList: fakeModifierList(modifierCount, minSelected),
  );
}

ModifierListEntity fakeModifierList(int modifierCount, int minSelected) {
  return ModifierListEntity(
    id: faker.datatype.uuid(),
    name: faker.commerce.productMaterial(),
    selectionType:
        minSelected <= 0 ? MoaSelectionType.SINGLE : MoaSelectionType.MULTIPLE,
    modifiers: fakeModifiers(count: modifierCount),
  );
}

ModifierEntity fakeModifier() {
  return ModifierEntity(
    id: faker.datatype.uuid(),
    name: faker.commerce.productAdjective(),
    priceMoneyAmount: fakePrice(),
  );
}

List<ModifierEntity> fakeModifiers({required int count}) {
  return List.generate(count, (index) => fakeModifier());
}
