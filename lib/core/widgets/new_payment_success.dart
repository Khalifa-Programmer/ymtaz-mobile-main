import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';

import '../../config/themes/styles.dart';
import '../constants/colors.dart';
import '../di/dependency_injection.dart';
import '../../feature/layout/account/logic/my_account_cubit.dart';

class NewSuccessPayment extends StatelessWidget {
  const NewSuccessPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.white,
      body: Material(
        color: Colors.transparent,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24.0.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40.0.sp),
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 100.0.sp,
                  ),
                  SizedBox(height: 24.0.sp),
                  Text(
                    "تمت عملية الدفع بنجاح",
                    style: TextStyles.cairo_24_bold,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0.sp),
                  Text(
                    "شكراً لك، تم إتمام عملية الدفع بنجاح",
                    style: TextStyles.cairo_16_regular.copyWith(
                      color: appColors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40.0.sp),
                  CustomButton(
                    title: "الفواتير",
                    borderColor: appColors.blue100,
                    borderRadius: 45,
                    bgColor: appColors.blue100,
                    onPress: () {
                      getit<MyAccountCubit>().getPayments();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.homeLayout, (route) => false);
                      Navigator.of(context).pushNamed(Routes.myPaymentsScreen);
                    },
                  ),
                  SizedBox(height: 16.0.sp),
                  CustomButton(
                    title: "باقاتي",
                    borderRadius: 45,
                    onPress: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.homeLayout, (route) => false);
                      Navigator.of(context).pushNamed(Routes.packages);
                    },
                  ),
                  SizedBox(height: 16.0.sp),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.homeLayout, (route) => false);
                    },
                    child: Text(
                      "موافق",
                      style: TextStyles.cairo_16_bold.copyWith(color: appColors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
