import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';
import 'package:yamtaz/feature/layout/account/presentation/widgets/custom_list_tile.dart';
import 'package:yamtaz/l10n/locale_keys.g.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../auth/login/data/models/login_provider_response.dart';

class MyProfileProviderScreen extends StatelessWidget {
  const MyProfileProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var myAccountCubit = context.read<MyAccountCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.myAccount.tr(),
            style: TextStyles.cairo_14_bold.copyWith(
              color: appColors.black,
            )),
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
                      LoginProviderResponse userDataResponse =
                          getit<MyAccountCubit>().userDataResponse!;
                      context.pushNamed(Routes.seeProviderInfo,
                          arguments: userDataResponse);
                    }),
                // CustomListTile(
                //     title: LocaleKeys.editProfile.tr(),
                //     icon: Icons.mode_edit_outline_rounded,
                //     onTap: () {
                //       UserDataResponse userDataResponse =
                //           getit<MyAccountCubit>().userDataResponse!;
                //
                //       if (userDataResponse.data!.client!.accepted == 1) {
                //         showDialog(
                //           context: context,
                //           builder: (context) {
                //             return CupertinoAlertDialog(
                //               title: Text("الحساب قيد المراجعة"),
                //               content: Text(
                //                   "حسابكم الآن كمقدم خدمة بمنصة يمتاز الإلكترونية هو في حالة انتظار التفعيل، وسيصلكم الإشعار بقبول ملفكم قريباً"),
                //               actions: [
                //                 CupertinoDialogAction(
                //                   child: Text("حسناً"),
                //                   onPressed: () {
                //                     Navigator.pop(context);
                //                   },
                //                 ),
                //               ],
                //             );
                //           },
                //         );
                //       } else {
                //         context.pushNamed(Routes.editProviderInfo,
                //             arguments: userDataResponse);
                //       }
                //     }),
                CustomListTile(
                    title: LocaleKeys.editServiceProviderData.tr(),
                    icon: Icons.edit_attributes_outlined,
                    onTap: () {
                      LoginProviderResponse userDataResponse =
                          getit<MyAccountCubit>().userDataResponse!;

                      if (userDataResponse.data!.account!.accepted == 1) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: Text("الحساب قيد المراجة"),
                              content: Text(
                                  "حسابكم الآن كمقدم خدمة بمنصة يمتاز الإلكترونية هو في حالة انتظار التفعيل، وسيصلكم الإشعار بقبول ملفكم قريباً"),
                              actions: [
                                CupertinoDialogAction(
                                  child: Text("حسناً"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        context.pushNamed(Routes.editProvider,
                            arguments: userDataResponse);
                      }
                    }),
                CustomListTile(
                    title: LocaleKeys.changePassword.tr(),
                    icon: Icons.password,
                    onTap: () {
                      LoginProviderResponse userDataResponse =
                          getit<MyAccountCubit>().userDataResponse!;
                      context.pushNamed(Routes.forgetPasswordProvider,
                          arguments: userDataResponse);
                    }),
                CustomListTile(
                    title: "إعدادات الدفع",
                    icon: Icons.payment_rounded,
                    onTap: () {
                      context.pushNamed(Routes.payoutSettingProvider);
                    }),
                CustomListTile(
                    title: "الخبرات العملية",
                    icon: Icons.work,
                    onTap: () {
                      context.pushNamed(Routes.workSettingProvider);
                    }),
                CustomListTile(
                    title: LocaleKeys.deleteAccount.tr(),
                    icon: Icons.delete_forever_outlined,
                    onTap: () {
                      context.pushNamed(Routes.removeProvider);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
