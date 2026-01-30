import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';

class CustomTextFieldPrimary extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final String title;
  final TextInputType type;
  final TextInputAction typeInputAction;
  final Icon? leadingIcon;
  final IconButton? suffixIcon;
  final TextEditingController externalController;
  final FocusNode? focusnode;
  final Function? validator;
  final Function? onChanged;
  final VoidCallback? onTap;
  final int? maxLenght;
  final List<TextInputFormatter>?
      inputFormatters; // Add this line for formatters
  final double? height;

  final bool multiLine;

  // Added multi-line parameter

  const CustomTextFieldPrimary({
    super.key,
    this.maxLenght,
    required this.hintText,
    this.obscureText = false,
    required this.externalController,
    required this.title,
    this.leadingIcon,
    this.focusnode,
    this.suffixIcon,
    this.type = TextInputType.text,
    this.typeInputAction = TextInputAction.done,
    this.validator,
    this.inputFormatters, // Add this line for formatters
    this.onChanged,
    this.onTap,
    this.multiLine = false,
    this.height, // Default value is false
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
            focusNode: focusnode,
            onChanged: onChanged != null 
                ? (value) => onChanged!(value) 
                : null,
            keyboardType: type,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            maxLength: maxLenght,
            inputFormatters: inputFormatters,
            // Add this line for formatters
            validator: validator != null 
                ? (value) => validator!(value) 
                : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: typeInputAction,
            style: TextStyles.cairo_12_semiBold,
            enabled: true,
            onTap: onTap,
            maxLines: multiLine ? 5 : null,
            // Allow multi-line if multiLine is true
            cursorColor: appColors.primaryColorYellow,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0),
              hintText: hintText,
              enabled: true,
              labelStyle: TextStyles.cairo_14_semiBold,
              prefixIcon: leadingIcon,
              prefixIconColor: const Color(0xff808D9E),
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
              label: Text(title),
              filled: true,
            ),
          ),
        ],
      ),
    );
  }
}
