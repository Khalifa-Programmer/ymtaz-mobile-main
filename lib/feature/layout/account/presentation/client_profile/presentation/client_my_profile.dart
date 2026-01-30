import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/feature/layout/account/presentation/widgets/custom_list_tile.dart';

import '../../../../../../config/themes/styles.dart';
import '../../../../../../l10n/locale_keys.g.dart';

class MyProfileClientScreen extends StatelessWidget {
  const MyProfileClientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.myAccount.tr(),
          style: TextStyles.cairo_14_bold,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                CustomListTile(
                    title: LocaleKeys.viewProfile.tr(),
                    icon: Icons.account_box_outlined,
                    onTap: () {
                      context.pushNamed(Routes.seeClientInfo);
                    }),
                CustomListTile(
                    title: LocaleKeys.editProfile.tr(),
                    icon: Icons.mode_edit_outline_rounded,
                    onTap: () {
                      context.pushNamed(Routes.editClient);
                    }),
                CustomListTile(
                    title: LocaleKeys.changePassword.tr(),
                    icon: Icons.password,
                    onTap: () {
                      context.pushNamed(Routes.forgetPasswordClient);
                    }),
                CustomListTile(
                    title: LocaleKeys.paymentMethods.tr(),
                    icon: Icons.payment_rounded,
                    onTap: () {}),
                CustomListTile(
                    title: LocaleKeys.deleteAccount.tr(),
                    icon: Icons.delete_forever_outlined,
                    onTap: () {
                      context.pushNamed(Routes.removeClient);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

getColor(String s) {
  // #FF0000 TO Color(0xFFff0000)
  return Color(int.parse(s.substring(1, 7), radix: 16) + 0xFF000000);
}
