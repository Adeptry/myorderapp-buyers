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

String _$currentOrderHash() => r'9ecfcb812a527a51c78f52965845082972dbcffd';

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

abstract class _$CurrentOrder
    extends BuildlessAsyncNotifier<CurrentOrderState?> {
  late final String merchantIdOrPath;
  late final String? xCustomLang;

  FutureOr<CurrentOrderState?> build({
    required String merchantIdOrPath,
    String? xCustomLang,
  });
}

/// See also [CurrentOrder].
@ProviderFor(CurrentOrder)
const currentOrderProvider = CurrentOrderFamily();

/// See also [CurrentOrder].
class CurrentOrderFamily extends Family<AsyncValue<CurrentOrderState?>> {
  /// See also [CurrentOrder].
  const CurrentOrderFamily();

  /// See also [CurrentOrder].
  CurrentOrderProvider call({
    required String merchantIdOrPath,
    String? xCustomLang,
  }) {
    return CurrentOrderProvider(
      merchantIdOrPath: merchantIdOrPath,
      xCustomLang: xCustomLang,
    );
  }

  @override
  CurrentOrderProvider getProviderOverride(
    covariant CurrentOrderProvider provider,
  ) {
    return call(
      merchantIdOrPath: provider.merchantIdOrPath,
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
  String? get name => r'currentOrderProvider';
}

/// See also [CurrentOrder].
class CurrentOrderProvider
    extends AsyncNotifierProviderImpl<CurrentOrder, CurrentOrderState?> {
  /// See also [CurrentOrder].
  CurrentOrderProvider({
    required String merchantIdOrPath,
    String? xCustomLang,
  }) : this._internal(
          () => CurrentOrder()
            ..merchantIdOrPath = merchantIdOrPath
            ..xCustomLang = xCustomLang,
          from: currentOrderProvider,
          name: r'currentOrderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$currentOrderHash,
          dependencies: CurrentOrderFamily._dependencies,
          allTransitiveDependencies:
              CurrentOrderFamily._allTransitiveDependencies,
          merchantIdOrPath: merchantIdOrPath,
          xCustomLang: xCustomLang,
        );

  CurrentOrderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.merchantIdOrPath,
    required this.xCustomLang,
  }) : super.internal();

  final String merchantIdOrPath;
  final String? xCustomLang;

  @override
  FutureOr<CurrentOrderState?> runNotifierBuild(
    covariant CurrentOrder notifier,
  ) {
    return notifier.build(
      merchantIdOrPath: merchantIdOrPath,
      xCustomLang: xCustomLang,
    );
  }

  @override
  Override overrideWith(CurrentOrder Function() create) {
    return ProviderOverride(
      origin: this,
      override: CurrentOrderProvider._internal(
        () => create()
          ..merchantIdOrPath = merchantIdOrPath
          ..xCustomLang = xCustomLang,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        merchantIdOrPath: merchantIdOrPath,
        xCustomLang: xCustomLang,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<CurrentOrder, CurrentOrderState?>
      createElement() {
    return _CurrentOrderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentOrderProvider &&
        other.merchantIdOrPath == merchantIdOrPath &&
        other.xCustomLang == xCustomLang;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, merchantIdOrPath.hashCode);
    hash = _SystemHash.combine(hash, xCustomLang.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CurrentOrderRef on AsyncNotifierProviderRef<CurrentOrderState?> {
  /// The parameter `merchantIdOrPath` of this provider.
  String get merchantIdOrPath;

  /// The parameter `xCustomLang` of this provider.
  String? get xCustomLang;
}

class _CurrentOrderProviderElement
    extends AsyncNotifierProviderElement<CurrentOrder, CurrentOrderState?>
    with CurrentOrderRef {
  _CurrentOrderProviderElement(super.provider);

  @override
  String get merchantIdOrPath =>
      (origin as CurrentOrderProvider).merchantIdOrPath;
  @override
  String? get xCustomLang => (origin as CurrentOrderProvider).xCustomLang;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
