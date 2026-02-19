import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/spacing.dart';

import '../../../../core/router/routes.dart';
import '../../../auth/login/presentation/view/login_body.dart';

class GestScreen extends StatelessWidget {
  const GestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w), // Added .w for responsiveness
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.noAccount,
                  width: 200.0.w,
                ),
                verticalSpace(30.h),
                Text(
                  'ليس لديك حساب؟',
                  style: TextStyles.cairo_20_bold,
                ),
                verticalSpace(10.h),
                Text(
                  'يمكنك الانضمام إلى أسرة يمتاز والاستفادة من كافة الخدمات والمزايا في مكان واحد بكل يسر وسهولة.',
                  textAlign: TextAlign.center,
                  style: TextStyles.cairo_14_semiBold.copyWith(
                    color: Colors.grey, // Subtle color for the description
                  ),
                ),
                verticalSpace(40.h),
                
                // Primary Action: Create Account
                CustomButton(
                  title: "إنشاء حساب جديد",
                  onPress: () {
                    context.pushNamedAndRemoveUntil(Routes.login,
                        predicate: (Route<dynamic> route) => false);
                    showRegisterType(context: context);
                  },
                ),
                
                verticalSpace(15.h),

                // Secondary Action: Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'لديك حساب بالفعل؟',
                      style: TextStyles.cairo_14_semiBold.copyWith(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        context.pushNamedAndRemoveUntil(
                          Routes.login,
                          predicate: (Route<dynamic> route) => false,
                        );
                      },
                      child: Text(
                        'تسجيل الدخول',
                        style: TextStyles.cairo_14_bold.copyWith(
                          color: appColors.primaryColorYellow, // Using your app's theme color
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
