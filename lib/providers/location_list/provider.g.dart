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

String _$locationListHash() => r'1ffbbfa51c39374d95b703c1564516fc381b5f63';

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

abstract class _$LocationList
    extends BuildlessAsyncNotifier<List<LocationEntity>?> {
  late final String merchantIdOrPath;
  late final num? page;
  late final num? limit;
  late final String? xCustomLang;

  FutureOr<List<LocationEntity>?> build({
    required String merchantIdOrPath,
    num? page,
    num? limit,
    String? xCustomLang,
  });
}

/// See also [LocationList].
@ProviderFor(LocationList)
const locationListProvider = LocationListFamily();

/// See also [LocationList].
class LocationListFamily extends Family<AsyncValue<List<LocationEntity>?>> {
  /// See also [LocationList].
  const LocationListFamily();

  /// See also [LocationList].
  LocationListProvider call({
    required String merchantIdOrPath,
    num? page,
    num? limit,
    String? xCustomLang,
  }) {
    return LocationListProvider(
      merchantIdOrPath: merchantIdOrPath,
      page: page,
      limit: limit,
      xCustomLang: xCustomLang,
    );
  }

  @override
  LocationListProvider getProviderOverride(
    covariant LocationListProvider provider,
  ) {
    return call(
      merchantIdOrPath: provider.merchantIdOrPath,
      page: provider.page,
      limit: provider.limit,
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
  String? get name => r'locationListProvider';
}

/// See also [LocationList].
class LocationListProvider
    extends AsyncNotifierProviderImpl<LocationList, List<LocationEntity>?> {
  /// See also [LocationList].
  LocationListProvider({
    required String merchantIdOrPath,
    num? page,
    num? limit,
    String? xCustomLang,
  }) : this._internal(
          () => LocationList()
            ..merchantIdOrPath = merchantIdOrPath
            ..page = page
            ..limit = limit
            ..xCustomLang = xCustomLang,
          from: locationListProvider,
          name: r'locationListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$locationListHash,
          dependencies: LocationListFamily._dependencies,
          allTransitiveDependencies:
              LocationListFamily._allTransitiveDependencies,
          merchantIdOrPath: merchantIdOrPath,
          page: page,
          limit: limit,
          xCustomLang: xCustomLang,
        );

  LocationListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.merchantIdOrPath,
    required this.page,
    required this.limit,
    required this.xCustomLang,
  }) : super.internal();

  final String merchantIdOrPath;
  final num? page;
  final num? limit;
  final String? xCustomLang;

  @override
  FutureOr<List<LocationEntity>?> runNotifierBuild(
    covariant LocationList notifier,
  ) {
    return notifier.build(
      merchantIdOrPath: merchantIdOrPath,
      page: page,
      limit: limit,
      xCustomLang: xCustomLang,
    );
  }

  @override
  Override overrideWith(LocationList Function() create) {
    return ProviderOverride(
      origin: this,
      override: LocationListProvider._internal(
        () => create()
          ..merchantIdOrPath = merchantIdOrPath
          ..page = page
          ..limit = limit
          ..xCustomLang = xCustomLang,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        merchantIdOrPath: merchantIdOrPath,
        page: page,
        limit: limit,
        xCustomLang: xCustomLang,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<LocationList, List<LocationEntity>?>
      createElement() {
    return _LocationListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LocationListProvider &&
        other.merchantIdOrPath == merchantIdOrPath &&
        other.page == page &&
        other.limit == limit &&
        other.xCustomLang == xCustomLang;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, merchantIdOrPath.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);
    hash = _SystemHash.combine(hash, xCustomLang.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LocationListRef on AsyncNotifierProviderRef<List<LocationEntity>?> {
  /// The parameter `merchantIdOrPath` of this provider.
  String get merchantIdOrPath;

  /// The parameter `page` of this provider.
  num? get page;

  /// The parameter `limit` of this provider.
  num? get limit;

  /// The parameter `xCustomLang` of this provider.
  String? get xCustomLang;
}

class _LocationListProviderElement
    extends AsyncNotifierProviderElement<LocationList, List<LocationEntity>?>
    with LocationListRef {
  _LocationListProviderElement(super.provider);

  @override
  String get merchantIdOrPath =>
      (origin as LocationListProvider).merchantIdOrPath;
  @override
  num? get page => (origin as LocationListProvider).page;
  @override
  num? get limit => (origin as LocationListProvider).limit;
  @override
  String? get xCustomLang => (origin as LocationListProvider).xCustomLang;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
