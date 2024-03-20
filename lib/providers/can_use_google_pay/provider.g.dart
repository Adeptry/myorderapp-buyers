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

String _$canUseGooglePayHash() => r'c66e0b060952621644934765bf207eb03082c6c7';

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

abstract class _$CanUseGooglePay extends BuildlessAsyncNotifier<bool> {
  late final String? squareLocationId;

  FutureOr<bool> build(
    String? squareLocationId,
  );
}

/// See also [CanUseGooglePay].
@ProviderFor(CanUseGooglePay)
const canUseGooglePayProvider = CanUseGooglePayFamily();

/// See also [CanUseGooglePay].
class CanUseGooglePayFamily extends Family<AsyncValue<bool>> {
  /// See also [CanUseGooglePay].
  const CanUseGooglePayFamily();

  /// See also [CanUseGooglePay].
  CanUseGooglePayProvider call(
    String? squareLocationId,
  ) {
    return CanUseGooglePayProvider(
      squareLocationId,
    );
  }

  @override
  CanUseGooglePayProvider getProviderOverride(
    covariant CanUseGooglePayProvider provider,
  ) {
    return call(
      provider.squareLocationId,
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
  String? get name => r'canUseGooglePayProvider';
}

/// See also [CanUseGooglePay].
class CanUseGooglePayProvider
    extends AsyncNotifierProviderImpl<CanUseGooglePay, bool> {
  /// See also [CanUseGooglePay].
  CanUseGooglePayProvider(
    String? squareLocationId,
  ) : this._internal(
          () => CanUseGooglePay()..squareLocationId = squareLocationId,
          from: canUseGooglePayProvider,
          name: r'canUseGooglePayProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$canUseGooglePayHash,
          dependencies: CanUseGooglePayFamily._dependencies,
          allTransitiveDependencies:
              CanUseGooglePayFamily._allTransitiveDependencies,
          squareLocationId: squareLocationId,
        );

  CanUseGooglePayProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.squareLocationId,
  }) : super.internal();

  final String? squareLocationId;

  @override
  FutureOr<bool> runNotifierBuild(
    covariant CanUseGooglePay notifier,
  ) {
    return notifier.build(
      squareLocationId,
    );
  }

  @override
  Override overrideWith(CanUseGooglePay Function() create) {
    return ProviderOverride(
      origin: this,
      override: CanUseGooglePayProvider._internal(
        () => create()..squareLocationId = squareLocationId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        squareLocationId: squareLocationId,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<CanUseGooglePay, bool> createElement() {
    return _CanUseGooglePayProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CanUseGooglePayProvider &&
        other.squareLocationId == squareLocationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, squareLocationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CanUseGooglePayRef on AsyncNotifierProviderRef<bool> {
  /// The parameter `squareLocationId` of this provider.
  String? get squareLocationId;
}

class _CanUseGooglePayProviderElement
    extends AsyncNotifierProviderElement<CanUseGooglePay, bool>
    with CanUseGooglePayRef {
  _CanUseGooglePayProviderElement(super.provider);

  @override
  String? get squareLocationId =>
      (origin as CanUseGooglePayProvider).squareLocationId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
