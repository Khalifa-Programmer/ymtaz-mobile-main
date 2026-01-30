import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/themes/styles.dart';
import '../constants/colors.dart';

InputDecoration customInputDecoration() {
  return InputDecoration(
    enabled: true,
    labelStyle: TextStyles.cairo_14_semiBold,

    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.sp),
      borderSide: const BorderSide(color: appColors.red),
    ),
    hintFadeDuration: const Duration(milliseconds: 300),
    hintStyle: TextStyle(
        color: appColors.grey10, fontSize: 14.sp, fontWeight: FontWeight.w600),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.sp),
      borderSide: const BorderSide(color: appColors.red),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.sp),
      borderSide: const BorderSide(color: appColors.primaryColorYellow),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.sp),
      borderSide: const BorderSide(color: appColors.grey2),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.sp),
      borderSide: const BorderSide(color: appColors.grey2),
    ),
    fillColor: appColors.white,
    // suffixIcon: isPssword! ? IconButton(
    //   icon: Icon(passwordVisiable ? IconlyLight.show : IconlyLight.hide),
    //   onPressed: onPressEye,
    // ) : null,
    labelText: 'رقم الهاتف',
    filled: true,
  );
}

InputDecoration customInputDecorationPhone() {
  return InputDecoration(
    hintText: "كود أو اسم الدولة",
    enabled: true,
    labelStyle: TextStyles.cairo_14_semiBold,
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.sp),
      borderSide: const BorderSide(color: appColors.red),
    ),
    hintFadeDuration: const Duration(milliseconds: 300),
    hintStyle: TextStyle(
        color: appColors.grey10, fontSize: 14.sp, fontWeight: FontWeight.w600),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.sp),
      borderSide: const BorderSide(color: appColors.red),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.sp),
      borderSide: const BorderSide(color: appColors.primaryColorYellow),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.sp),
      borderSide: const BorderSide(color: appColors.grey2),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.sp),
      borderSide: const BorderSide(color: appColors.grey2),
    ),
    // suffixIcon: isPssword! ? IconButton(
    //   icon: Icon(passwordVisiable ? IconlyLight.show : IconlyLight.hide),
    //   onPressed: onPressEye,
    // ) : null,
    filled: true,
  );
}
