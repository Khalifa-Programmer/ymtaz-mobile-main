import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';

class DotsIndicator extends StatelessWidget {
  final bool isActive;

  const DotsIndicator({super.key, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: isActive ? 30.w : 8.w,
      height: isActive ? 8.h : 8.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: isActive ? appColors.primaryColorYellow : appColors.grey,
      ),
      duration: Duration(milliseconds: 200),
    );
  }
}
