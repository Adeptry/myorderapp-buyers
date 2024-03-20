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

String _$googleAuthenticationHash() =>
    r'1a20c17b370a0c164e8d488584171d7c30b0e034';

/// See also [GoogleAuthentication].
@ProviderFor(GoogleAuthentication)
final googleAuthenticationProvider =
    NotifierProvider<GoogleAuthentication, GoogleSignIn>.internal(
  GoogleAuthentication.new,
  name: r'googleAuthenticationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$googleAuthenticationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GoogleAuthentication = Notifier<GoogleSignIn>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
