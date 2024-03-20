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

part of 'order_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderHash() => r'2ca37ed3d48c94e144a43bda99346d3e41b82439';

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

/// See also [order].
@ProviderFor(order)
const orderProvider = OrderFamily();

/// See also [order].
class OrderFamily extends Family<AsyncValue<OrderEntity>> {
  /// See also [order].
  const OrderFamily();

  /// See also [order].
  OrderProvider call({
    required String merchantIdOrPath,
    required String orderId,
    String? xCustomLang,
  }) {
    return OrderProvider(
      merchantIdOrPath: merchantIdOrPath,
      orderId: orderId,
      xCustomLang: xCustomLang,
    );
  }

  @override
  OrderProvider getProviderOverride(
    covariant OrderProvider provider,
  ) {
    return call(
      merchantIdOrPath: provider.merchantIdOrPath,
      orderId: provider.orderId,
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
  String? get name => r'orderProvider';
}

/// See also [order].
class OrderProvider extends AutoDisposeFutureProvider<OrderEntity> {
  /// See also [order].
  OrderProvider({
    required String merchantIdOrPath,
    required String orderId,
    String? xCustomLang,
  }) : this._internal(
          (ref) => order(
            ref as OrderRef,
            merchantIdOrPath: merchantIdOrPath,
            orderId: orderId,
            xCustomLang: xCustomLang,
          ),
          from: orderProvider,
          name: r'orderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$orderHash,
          dependencies: OrderFamily._dependencies,
          allTransitiveDependencies: OrderFamily._allTransitiveDependencies,
          merchantIdOrPath: merchantIdOrPath,
          orderId: orderId,
          xCustomLang: xCustomLang,
        );

  OrderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.merchantIdOrPath,
    required this.orderId,
    required this.xCustomLang,
  }) : super.internal();

  final String merchantIdOrPath;
  final String orderId;
  final String? xCustomLang;

  @override
  Override overrideWith(
    FutureOr<OrderEntity> Function(OrderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OrderProvider._internal(
        (ref) => create(ref as OrderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        merchantIdOrPath: merchantIdOrPath,
        orderId: orderId,
        xCustomLang: xCustomLang,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<OrderEntity> createElement() {
    return _OrderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrderProvider &&
        other.merchantIdOrPath == merchantIdOrPath &&
        other.orderId == orderId &&
        other.xCustomLang == xCustomLang;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, merchantIdOrPath.hashCode);
    hash = _SystemHash.combine(hash, orderId.hashCode);
    hash = _SystemHash.combine(hash, xCustomLang.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OrderRef on AutoDisposeFutureProviderRef<OrderEntity> {
  /// The parameter `merchantIdOrPath` of this provider.
  String get merchantIdOrPath;

  /// The parameter `orderId` of this provider.
  String get orderId;

  /// The parameter `xCustomLang` of this provider.
  String? get xCustomLang;
}

class _OrderProviderElement
    extends AutoDisposeFutureProviderElement<OrderEntity> with OrderRef {
  _OrderProviderElement(super.provider);

  @override
  String get merchantIdOrPath => (origin as OrderProvider).merchantIdOrPath;
  @override
  String get orderId => (origin as OrderProvider).orderId;
  @override
  String? get xCustomLang => (origin as OrderProvider).xCustomLang;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
