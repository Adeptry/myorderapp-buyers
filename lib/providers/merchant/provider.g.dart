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

String _$merchantHash() => r'56087512bafedf34e85dd12ddceb2267a45f396d';

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

abstract class _$Merchant extends BuildlessAsyncNotifier<MerchantEntity?> {
  late final String merchantIdOrPath;
  late final String? xCustomLang;

  FutureOr<MerchantEntity?> build({
    required String merchantIdOrPath,
    String? xCustomLang,
  });
}

/// See also [Merchant].
@ProviderFor(Merchant)
const merchantProvider = MerchantFamily();

/// See also [Merchant].
class MerchantFamily extends Family<AsyncValue<MerchantEntity?>> {
  /// See also [Merchant].
  const MerchantFamily();

  /// See also [Merchant].
  MerchantProvider call({
    required String merchantIdOrPath,
    String? xCustomLang,
  }) {
    return MerchantProvider(
      merchantIdOrPath: merchantIdOrPath,
      xCustomLang: xCustomLang,
    );
  }

  @override
  MerchantProvider getProviderOverride(
    covariant MerchantProvider provider,
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
  String? get name => r'merchantProvider';
}

/// See also [Merchant].
class MerchantProvider
    extends AsyncNotifierProviderImpl<Merchant, MerchantEntity?> {
  /// See also [Merchant].
  MerchantProvider({
    required String merchantIdOrPath,
    String? xCustomLang,
  }) : this._internal(
          () => Merchant()
            ..merchantIdOrPath = merchantIdOrPath
            ..xCustomLang = xCustomLang,
          from: merchantProvider,
          name: r'merchantProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$merchantHash,
          dependencies: MerchantFamily._dependencies,
          allTransitiveDependencies: MerchantFamily._allTransitiveDependencies,
          merchantIdOrPath: merchantIdOrPath,
          xCustomLang: xCustomLang,
        );

  MerchantProvider._internal(
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
  FutureOr<MerchantEntity?> runNotifierBuild(
    covariant Merchant notifier,
  ) {
    return notifier.build(
      merchantIdOrPath: merchantIdOrPath,
      xCustomLang: xCustomLang,
    );
  }

  @override
  Override overrideWith(Merchant Function() create) {
    return ProviderOverride(
      origin: this,
      override: MerchantProvider._internal(
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
  AsyncNotifierProviderElement<Merchant, MerchantEntity?> createElement() {
    return _MerchantProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MerchantProvider &&
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

mixin MerchantRef on AsyncNotifierProviderRef<MerchantEntity?> {
  /// The parameter `merchantIdOrPath` of this provider.
  String get merchantIdOrPath;

  /// The parameter `xCustomLang` of this provider.
  String? get xCustomLang;
}

class _MerchantProviderElement
    extends AsyncNotifierProviderElement<Merchant, MerchantEntity?>
    with MerchantRef {
  _MerchantProviderElement(super.provider);

  @override
  String get merchantIdOrPath => (origin as MerchantProvider).merchantIdOrPath;
  @override
  String? get xCustomLang => (origin as MerchantProvider).xCustomLang;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
