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

String _$customerHash() => r'a8ad029b9b3f9d2fb898b41295a0ddff06e4cf38';

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

abstract class _$Customer extends BuildlessAsyncNotifier<CustomerEntity?> {
  late final String merchantIdOrPath;

  FutureOr<CustomerEntity?> build({
    required String merchantIdOrPath,
  });
}

/// See also [Customer].
@ProviderFor(Customer)
const customerProvider = CustomerFamily();

/// See also [Customer].
class CustomerFamily extends Family<AsyncValue<CustomerEntity?>> {
  /// See also [Customer].
  const CustomerFamily();

  /// See also [Customer].
  CustomerProvider call({
    required String merchantIdOrPath,
  }) {
    return CustomerProvider(
      merchantIdOrPath: merchantIdOrPath,
    );
  }

  @override
  CustomerProvider getProviderOverride(
    covariant CustomerProvider provider,
  ) {
    return call(
      merchantIdOrPath: provider.merchantIdOrPath,
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
  String? get name => r'customerProvider';
}

/// See also [Customer].
class CustomerProvider
    extends AsyncNotifierProviderImpl<Customer, CustomerEntity?> {
  /// See also [Customer].
  CustomerProvider({
    required String merchantIdOrPath,
  }) : this._internal(
          () => Customer()..merchantIdOrPath = merchantIdOrPath,
          from: customerProvider,
          name: r'customerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$customerHash,
          dependencies: CustomerFamily._dependencies,
          allTransitiveDependencies: CustomerFamily._allTransitiveDependencies,
          merchantIdOrPath: merchantIdOrPath,
        );

  CustomerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.merchantIdOrPath,
  }) : super.internal();

  final String merchantIdOrPath;

  @override
  FutureOr<CustomerEntity?> runNotifierBuild(
    covariant Customer notifier,
  ) {
    return notifier.build(
      merchantIdOrPath: merchantIdOrPath,
    );
  }

  @override
  Override overrideWith(Customer Function() create) {
    return ProviderOverride(
      origin: this,
      override: CustomerProvider._internal(
        () => create()..merchantIdOrPath = merchantIdOrPath,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        merchantIdOrPath: merchantIdOrPath,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<Customer, CustomerEntity?> createElement() {
    return _CustomerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomerProvider &&
        other.merchantIdOrPath == merchantIdOrPath;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, merchantIdOrPath.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CustomerRef on AsyncNotifierProviderRef<CustomerEntity?> {
  /// The parameter `merchantIdOrPath` of this provider.
  String get merchantIdOrPath;
}

class _CustomerProviderElement
    extends AsyncNotifierProviderElement<Customer, CustomerEntity?>
    with CustomerRef {
  _CustomerProviderElement(super.provider);

  @override
  String get merchantIdOrPath => (origin as CustomerProvider).merchantIdOrPath;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
