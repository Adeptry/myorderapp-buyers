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

String _$categoryScaffoldHash() => r'61e09e9254c7aaebf1c1611637e2d907bd04bbc9';

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

abstract class _$CategoryScaffold
    extends BuildlessNotifier<CategoryScaffoldState> {
  late final String? xCustomLang;

  CategoryScaffoldState build(
    String? xCustomLang,
  );
}

/// See also [CategoryScaffold].
@ProviderFor(CategoryScaffold)
const categoryScaffoldProvider = CategoryScaffoldFamily();

/// See also [CategoryScaffold].
class CategoryScaffoldFamily extends Family<CategoryScaffoldState> {
  /// See also [CategoryScaffold].
  const CategoryScaffoldFamily();

  /// See also [CategoryScaffold].
  CategoryScaffoldProvider call(
    String? xCustomLang,
  ) {
    return CategoryScaffoldProvider(
      xCustomLang,
    );
  }

  @override
  CategoryScaffoldProvider getProviderOverride(
    covariant CategoryScaffoldProvider provider,
  ) {
    return call(
      provider.xCustomLang,
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
  String? get name => r'categoryScaffoldProvider';
}

/// See also [CategoryScaffold].
class CategoryScaffoldProvider
    extends NotifierProviderImpl<CategoryScaffold, CategoryScaffoldState> {
  /// See also [CategoryScaffold].
  CategoryScaffoldProvider(
    String? xCustomLang,
  ) : this._internal(
          () => CategoryScaffold()..xCustomLang = xCustomLang,
          from: categoryScaffoldProvider,
          name: r'categoryScaffoldProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$categoryScaffoldHash,
          dependencies: CategoryScaffoldFamily._dependencies,
          allTransitiveDependencies:
              CategoryScaffoldFamily._allTransitiveDependencies,
          xCustomLang: xCustomLang,
        );

  CategoryScaffoldProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.xCustomLang,
  }) : super.internal();

  final String? xCustomLang;

  @override
  CategoryScaffoldState runNotifierBuild(
    covariant CategoryScaffold notifier,
  ) {
    return notifier.build(
      xCustomLang,
    );
  }

  @override
  Override overrideWith(CategoryScaffold Function() create) {
    return ProviderOverride(
      origin: this,
      override: CategoryScaffoldProvider._internal(
        () => create()..xCustomLang = xCustomLang,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        xCustomLang: xCustomLang,
      ),
    );
  }

  @override
  NotifierProviderElement<CategoryScaffold, CategoryScaffoldState>
      createElement() {
    return _CategoryScaffoldProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryScaffoldProvider &&
        other.xCustomLang == xCustomLang;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, xCustomLang.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CategoryScaffoldRef on NotifierProviderRef<CategoryScaffoldState> {
  /// The parameter `xCustomLang` of this provider.
  String? get xCustomLang;
}

class _CategoryScaffoldProviderElement
    extends NotifierProviderElement<CategoryScaffold, CategoryScaffoldState>
    with CategoryScaffoldRef {
  _CategoryScaffoldProviderElement(super.provider);

  @override
  String? get xCustomLang => (origin as CategoryScaffoldProvider).xCustomLang;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
