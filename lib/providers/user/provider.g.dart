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

String _$userHash() => r'bb7e9f6537aa89387927c148b5870c4f5cb25116';

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

abstract class _$User extends BuildlessAsyncNotifier<UserEntity?> {
  late final String? xCustomLang;

  FutureOr<UserEntity?> build({
    String? xCustomLang,
  });
}

/// See also [User].
@ProviderFor(User)
const userProvider = UserFamily();

/// See also [User].
class UserFamily extends Family<AsyncValue<UserEntity?>> {
  /// See also [User].
  const UserFamily();

  /// See also [User].
  UserProvider call({
    String? xCustomLang,
  }) {
    return UserProvider(
      xCustomLang: xCustomLang,
    );
  }

  @override
  UserProvider getProviderOverride(
    covariant UserProvider provider,
  ) {
    return call(
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
  String? get name => r'userProvider';
}

/// See also [User].
class UserProvider extends AsyncNotifierProviderImpl<User, UserEntity?> {
  /// See also [User].
  UserProvider({
    String? xCustomLang,
  }) : this._internal(
          () => User()..xCustomLang = xCustomLang,
          from: userProvider,
          name: r'userProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$userHash,
          dependencies: UserFamily._dependencies,
          allTransitiveDependencies: UserFamily._allTransitiveDependencies,
          xCustomLang: xCustomLang,
        );

  UserProvider._internal(
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
  FutureOr<UserEntity?> runNotifierBuild(
    covariant User notifier,
  ) {
    return notifier.build(
      xCustomLang: xCustomLang,
    );
  }

  @override
  Override overrideWith(User Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserProvider._internal(
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
  AsyncNotifierProviderElement<User, UserEntity?> createElement() {
    return _UserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserProvider && other.xCustomLang == xCustomLang;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, xCustomLang.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserRef on AsyncNotifierProviderRef<UserEntity?> {
  /// The parameter `xCustomLang` of this provider.
  String? get xCustomLang;
}

class _UserProviderElement
    extends AsyncNotifierProviderElement<User, UserEntity?> with UserRef {
  _UserProviderElement(super.provider);

  @override
  String? get xCustomLang => (origin as UserProvider).xCustomLang;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
