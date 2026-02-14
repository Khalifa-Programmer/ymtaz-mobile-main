import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final Color? bgColor,
      titleColor,
      borderColor; //pass title color and background colors
  final String title;
  final double? height;
  final double? width;
  final VoidCallback? onPress;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? borderRadius;

  const CustomButton(
      {super.key,
      required this.title,
      this.bgColor = appColors.primaryColorYellow,
      this.borderColor = appColors.primaryColorYellow,
      this.titleColor = appColors.white,
      this.height = 48,
      this.width = 343,
      this.onPress,
      this.fontSize = 15,
      this.fontWeight = FontWeight.bold,
      this.borderRadius = 8});

  @override
  Widget build(BuildContext context) {
    /*



    TextButton(
      style: TextButton.styleFrom(
          backgroundColor: bgColor!,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: borderColor!),
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
    );


    * */

    return SizedBox(
      width: width == double.infinity ? double.infinity : width!.w,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            shadowColor: Colors.transparent,
            minimumSize: const Size(double.infinity, 48),
            backgroundColor: bgColor!,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: borderColor!),
                borderRadius: BorderRadius.circular(borderRadius!.sp))),
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
