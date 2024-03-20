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

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myorderapp_square/myorderapp_square.dart';

import '../../extensions/build_context_extensions.dart';
import '../../extensions/material/list_tile_extensions.dart';
import '../list_tiles/name_list_tile.dart';
import '../list_tiles/phone_number_list_tile.dart';

enum AccountListViewItem {
  name,
  email,
  phoneNumber,
  paymentMethods,
  notifications,
  passwordChange,
  passwordForgot,
  signOut,
  delete,
  about,
  terms,
  privacy,
}

class AccountListView extends StatelessWidget {
  final UserEntity? userState;
  final String countryCode;
  final Function(AccountListViewItem) onTapItem;

  const AccountListView({
    super.key,
    required this.onTapItem,
    required this.userState,
    required this.countryCode,
  });

  @override
  Widget build(BuildContext context) {
    final loading = userState == null;
    final email = userState?.email;

    return ListView.separated(
      itemCount: AccountListViewItem.values.length,
      itemBuilder: (context, index) {
        if (index < AccountListViewItem.values.length) {
          final item = AccountListViewItem.values[index];
          switch (item) {
            case AccountListViewItem.name:
              return NameListTile(
                fullName: loading ? "" : userState?.fullName,
                onTap: () => onTapItem(item),
              );
            case AccountListViewItem.email:
              return ListTile(
                title: Text(context.l10n.email),
                subtitle: loading
                    ? const Text("")
                    : email != null
                        ? Text(email)
                        : Text(context.l10n.emailSubtitle),
                trailing: const Icon(Icons.email),
                onTap: () => onTapItem(item),
              );
            case AccountListViewItem.phoneNumber:
              return PhoneNumberListTile(
                phoneNumber: userState?.phoneNumber,
                isLoading: loading,
                countryCode: countryCode,
                onTap: () => onTapItem(item),
              );
            case AccountListViewItem.passwordChange:
              return ListTile(
                title: Text(context.l10n.password),
                subtitle: Text(context.l10n.passwordSubtitle),
                trailing: const Icon(Icons.password),
                onTap: () => onTapItem(item),
              );
            case AccountListViewItem.passwordForgot:
              return ListTile(
                title: Text(context.l10n.passwordForgot),
                subtitle: Text(context.l10n.passwordForgotSubtitle),
                trailing: const Icon(Icons.lock_reset),
                onTap: () => onTapItem(item),
              );
            case AccountListViewItem.paymentMethods:
              return ListTileExtension.captioned(
                title: Text(context.l10n.paymentMethods),
                subtitle: Text(context.l10n.paymentMethodsSubtitle),
                trailing: const Icon(Icons.payment),
                onTap: () => onTapItem(item),
              );
            case AccountListViewItem.notifications:
              return ListTile(
                title: Text(context.l10n.notifications),
                subtitle: Text(context.l10n.notificationsSubtitle),
                trailing: const Icon(Icons.notifications_on),
                onTap: () => onTapItem(item),
              );
            case AccountListViewItem.signOut:
              return ListTile(
                title: Text(context.l10n.logOut),
                subtitle: Text(context.l10n.logOutSubtitle),
                trailing: const Icon(Icons.logout),
                onTap: () => onTapItem(item),
              );
            case AccountListViewItem.about:
              return ListTile(
                title: Text(context.l10n.about),
                trailing: const Icon(Icons.info),
                onTap: () => onTapItem(item),
              );
            case AccountListViewItem.terms:
              return ListTile(
                title: Text(context.l10n.terms),
                trailing: const FaIcon(FontAwesomeIcons.fileContract),
                onTap: () => onTapItem(item),
              );
            case AccountListViewItem.privacy:
              return ListTile(
                title: Text(context.l10n.privacy),
                trailing: const Icon(Icons.privacy_tip),
                onTap: () => onTapItem(item),
              );
            case AccountListViewItem.delete:
              return ListTile(
                title: Text(context.l10n.deleteAccount),
                subtitle: Text(context.l10n.deleteAccountSubtitle),
                trailing: const Icon(Icons.warning),
                onTap: () => onTapItem(item),
              );
          }
        } else {
          return const ListTile();
        }
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
