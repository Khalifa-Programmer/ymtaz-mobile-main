import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';

class CustomAuthTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final String title;
  final TextInputType type;
  final VoidCallback? onPressEye;
  final bool passwordVisiable;
  final FocusNode? focusNode;
  final bool? isPssword;

  final TextEditingController externalController;
  final Function? validator;

  const CustomAuthTextField({
    super.key,
    required this.hintText,
    this.focusNode,
    this.obscureText = false,
    required this.externalController,
    required this.title,
    this.type = TextInputType.text,
    this.onPressEye,
    this.passwordVisiable = false,
    this.isPssword = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: externalController,
            obscureText: obscureText,
            focusNode: focusNode,
            keyboardType: type,
            validator: (value) => validator!(value),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            style: TextStyles.cairo_13_bold,
            enabled: true,
            cursorColor: appColors.primaryColorYellow,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0),
              hintText: hintText,
              enabled: true,
              labelStyle: TextStyle(
                  color: appColors.blue100,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.sp),
                borderSide: const BorderSide(color: appColors.red),
              ),
              hintFadeDuration: const Duration(milliseconds: 300),
              hintStyle: TextStyle(
                  color: appColors.grey10,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.sp),
                borderSide: const BorderSide(color: appColors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.sp),
                borderSide:
                    const BorderSide(color: appColors.primaryColorYellow),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.sp),
                borderSide: const BorderSide(color: appColors.grey2),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.sp),
                borderSide: const BorderSide(color: appColors.grey2),
              ),
              suffixIcon: isPssword!
                  ? IconButton(
                      icon: Icon(passwordVisiable
                          ? CupertinoIcons.eye
                          : CupertinoIcons.eye_slash),
                      onPressed: onPressEye,
                    )
                  : null,
              filled: true,
              fillColor: appColors.white,
              labelText: title,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAuthTextFieldWithOutValidate extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final String title;
  final TextInputType type;
  final VoidCallback? onPressEye;
  final bool passwordVisiable;

  final bool? isPssword;

  final TextEditingController externalController;

  const CustomAuthTextFieldWithOutValidate({
    super.key,
    required this.hintText,
    this.obscureText = false,
    required this.externalController,
    required this.title,
    this.type = TextInputType.text,
    this.onPressEye,
    this.passwordVisiable = false,
    this.isPssword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: externalController,
            obscureText: obscureText,
            keyboardType: type,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            style: TextStyles.cairo_13_bold,
            enabled: true,
            cursorColor: appColors.primaryColorYellow,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              labelText: title,
              errorStyle: const TextStyle(height: 0),
              hintText: hintText,
              enabled: true,
              labelStyle: TextStyle(
                  color: appColors.blue100,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.sp),
                borderSide: const BorderSide(color: appColors.red),
              ),
              hintFadeDuration: const Duration(milliseconds: 300),
              hintStyle: TextStyle(
                  color: appColors.grey10,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.sp),
                borderSide: const BorderSide(color: appColors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.sp),
                borderSide:
                    const BorderSide(color: appColors.primaryColorYellow),
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
              filled: true,
            ),
          ),
        ],
      ),
    );
  }
}
