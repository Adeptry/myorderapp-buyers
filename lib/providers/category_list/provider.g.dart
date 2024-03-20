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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categoryListHash() => r'73b117b01e8e23308c50e699f1f383e415a093a1';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$CategoryList
    extends BuildlessAsyncNotifier<List<CategoryEntity>?> {
  late final String merchantIdOrPath;
  late final String? locationId;
  late final String? xCustomLang;

  FutureOr<List<CategoryEntity>?> build({
    required String merchantIdOrPath,
    String? locationId,
    String? xCustomLang,
  });
}

/// See also [CategoryList].
@ProviderFor(CategoryList)
const categoryListProvider = CategoryListFamily();

/// See also [CategoryList].
class CategoryListFamily extends Family<AsyncValue<List<CategoryEntity>?>> {
  /// See also [CategoryList].
  const CategoryListFamily();

  /// See also [CategoryList].
  CategoryListProvider call({
    required String merchantIdOrPath,
    String? locationId,
    String? xCustomLang,
  }) {
    return CategoryListProvider(
      merchantIdOrPath: merchantIdOrPath,
      locationId: locationId,
      xCustomLang: xCustomLang,
    );
  }

  @override
  CategoryListProvider getProviderOverride(
    covariant CategoryListProvider provider,
  ) {
    return call(
      merchantIdOrPath: provider.merchantIdOrPath,
      locationId: provider.locationId,
      xCustomLang: provider.xCustomLang,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'categoryListProvider';
}

/// See also [CategoryList].
class CategoryListProvider
    extends AsyncNotifierProviderImpl<CategoryList, List<CategoryEntity>?> {
  /// See also [CategoryList].
  CategoryListProvider({
    required String merchantIdOrPath,
    String? locationId,
    String? xCustomLang,
  }) : this._internal(
          () => CategoryList()
            ..merchantIdOrPath = merchantIdOrPath
            ..locationId = locationId
            ..xCustomLang = xCustomLang,
          from: categoryListProvider,
          name: r'categoryListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$categoryListHash,
          dependencies: CategoryListFamily._dependencies,
          allTransitiveDependencies:
              CategoryListFamily._allTransitiveDependencies,
          merchantIdOrPath: merchantIdOrPath,
          locationId: locationId,
          xCustomLang: xCustomLang,
        );

  CategoryListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.merchantIdOrPath,
    required this.locationId,
    required this.xCustomLang,
  }) : super.internal();

  final String merchantIdOrPath;
  final String? locationId;
  final String? xCustomLang;

  @override
  FutureOr<List<CategoryEntity>?> runNotifierBuild(
    covariant CategoryList notifier,
  ) {
    return notifier.build(
      merchantIdOrPath: merchantIdOrPath,
      locationId: locationId,
      xCustomLang: xCustomLang,
    );
  }

  @override
  Override overrideWith(CategoryList Function() create) {
    return ProviderOverride(
      origin: this,
      override: CategoryListProvider._internal(
        () => create()
          ..merchantIdOrPath = merchantIdOrPath
          ..locationId = locationId
          ..xCustomLang = xCustomLang,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        merchantIdOrPath: merchantIdOrPath,
        locationId: locationId,
        xCustomLang: xCustomLang,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<CategoryList, List<CategoryEntity>?>
      createElement() {
    return _CategoryListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryListProvider &&
        other.merchantIdOrPath == merchantIdOrPath &&
        other.locationId == locationId &&
        other.xCustomLang == xCustomLang;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, merchantIdOrPath.hashCode);
    hash = _SystemHash.combine(hash, locationId.hashCode);
    hash = _SystemHash.combine(hash, xCustomLang.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CategoryListRef on AsyncNotifierProviderRef<List<CategoryEntity>?> {
  /// The parameter `merchantIdOrPath` of this provider.
  String get merchantIdOrPath;

  /// The parameter `locationId` of this provider.
  String? get locationId;

  /// The parameter `xCustomLang` of this provider.
  String? get xCustomLang;
}

class _CategoryListProviderElement
    extends AsyncNotifierProviderElement<CategoryList, List<CategoryEntity>?>
    with CategoryListRef {
  _CategoryListProviderElement(super.provider);

  @override
  String get merchantIdOrPath =>
      (origin as CategoryListProvider).merchantIdOrPath;
  @override
  String? get locationId => (origin as CategoryListProvider).locationId;
  @override
  String? get xCustomLang => (origin as CategoryListProvider).xCustomLang;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
