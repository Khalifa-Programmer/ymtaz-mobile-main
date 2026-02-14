import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/layout/account/presentation/widgets/custom_list_tile.dart';
import 'package:yamtaz/feature/layout/account/presentation/widgets/user_profile_row.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';

class VisitorAccountScreen extends StatelessWidget {
  const VisitorAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? userName = CacheHelper.getData(key: 'userName');
    String? userEmail = CacheHelper.getData(key: 'userEmail');
    String? userImage = CacheHelper.getData(key: 'userImage');

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    UserProfileColumn(
                      imageUrl: userImage ?? "https://api.ymtaz.sa/uploads/person.png",
                      name: userName ?? "زائر",
                      color: appColors.primaryColorYellow,
                      image: "https://api.ymtaz.sa/uploads/ranks/BrownShield.svg",
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 5.h),
                        Text(
                          userEmail ?? "",
                          style: TextStyles.cairo_14_semiBold.copyWith(color: appColors.grey5),
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: appColors.primaryColorYellow.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "حساب زائر (Google/Apple)",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: appColors.primaryColorYellow,
                            ),
                          ),
                        )
                      ],
                    ),
                    verticalSpace(30.h),
                    CustomListTile(
                      title: "تسجيل الخروج",
                      icon: Icons.logout_rounded,
                      onTap: () => _signOut(context),
                    ),
                    verticalSpace(20.h),
                    Center(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AppAssets.mainLogo,
                            width: 60.w,
                            height: 60.h,
                          ),
                          verticalSpace(10.h),
                          Text(
                            'يمتاز - دليلك القانوني',
                            style: TextStyles.cairo_12_semiBold.copyWith(color: appColors.grey20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signOut(BuildContext context) {
    CacheHelper.removeData(key: 'token');
    CacheHelper.removeData(key: 'userName');
    CacheHelper.removeData(key: 'userEmail');
    CacheHelper.removeData(key: 'userImage');
    CacheHelper.removeData(key: 'userType');
    CacheHelper.removeData(key: 'userId');
    
    getit<MyAccountCubit>().userDataResponse = null;
    getit<MyAccountCubit>().clientProfile = null;
    
    context.pushNamedAndRemoveUntil(Routes.login,
        predicate: (Route<dynamic> route) => false);
  }
}
