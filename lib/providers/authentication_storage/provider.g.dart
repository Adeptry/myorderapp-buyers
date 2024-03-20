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

String _$authenticationStorageHash() =>
    r'd6d719381b85f975b87fc63542a5e40af01b9dff';

/// See also [AuthenticationStorage].
@ProviderFor(AuthenticationStorage)
final authenticationStorageProvider = NotifierProvider<AuthenticationStorage,
    AuthenticationStorageState>.internal(
  AuthenticationStorage.new,
  name: r'authenticationStorageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authenticationStorageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthenticationStorage = Notifier<AuthenticationStorageState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
