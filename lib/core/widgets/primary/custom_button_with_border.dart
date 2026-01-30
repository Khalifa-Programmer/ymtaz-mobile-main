import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';

class CustomButtonWithBorder extends StatelessWidget {
  final Color? bgColor, titleColor; //pass title color and background colors
  final String title;
  final double? height;
  final double? width;
  final VoidCallback? onPress;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? borderRadius;

  const CustomButtonWithBorder(
      {super.key,
      required this.title,
      this.bgColor = appColors.primaryColorYellow,
      this.titleColor = appColors.white,
      this.height = 48,
      this.width = 343,
      this.onPress,
      this.fontSize = 20,
      this.fontWeight = FontWeight.bold,
      this.borderRadius = 6});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height!.h,
      width: width!.w,
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: bgColor!,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius!.sp))),
        onPressed: onPress,
        child: Text(
          title,
          style: TextStyle(
              fontFamily: 'cairo',
              fontWeight: fontWeight,
              color: titleColor,
              fontSize: fontSize!.sp),
        ),
      ),
    );
  }
}
