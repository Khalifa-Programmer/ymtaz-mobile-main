import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/widgets/spacing.dart';

import '../../config/themes/styles.dart';
import '../constants/colors.dart';

class CustomContainer extends StatelessWidget {
  Widget child;
  String title;

  CustomContainer({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.sp),
        border: Border.all(color: appColors.grey2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 1.5.h),
              decoration: BoxDecoration(
                // border: Border.all(color: ColorsPalletes.primaryColorYellow),
                borderRadius: BorderRadius.circular(16.sp),
              ),
              child: child),
        ],
      ),
    );
  }
}

class CustomContainerEditSignUp extends StatelessWidget {
  Widget child;
  String title;

  CustomContainerEditSignUp(
      {super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.cairo_12_medium.copyWith(color: appColors.blue100),
        ),
        verticalSpace(5),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.sp),
            border: Border.all(color: appColors.grey2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 1.5.h),
                  decoration: BoxDecoration(
                    // border: Border.all(color: ColorsPalletes.primaryColorYellow),
                    borderRadius: BorderRadius.circular(16.sp),
                  ),
                  child: child),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomContainerWithOutTitle extends StatelessWidget {
  Widget child;

  CustomContainerWithOutTitle({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: appColors.white,
        borderRadius: BorderRadius.circular(16.sp),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          child,
        ],
      ),
    );
  }
}
