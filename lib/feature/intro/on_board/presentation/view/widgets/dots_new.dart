import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yamtaz/core/constants/colors.dart';

class Components {
  Components._();

  static Widget pageIndicator({
    required PageController pageController,
    required int count,
    Color? unActiveDotColor,
    Color? activeDotColor,
  }) =>
      SmoothPageIndicator(
        controller: pageController,
        count: count,
        axisDirection: Axis.horizontal,
        effect: SwapEffect(
          spacing: 6.w,
          radius: 10.sp,
          dotWidth: 15.w,
          dotHeight: 3.h,
          paintStyle: PaintingStyle.fill,
          dotColor: unActiveDotColor ?? appColors.grey10,
          activeDotColor: activeDotColor ?? appColors.primaryColorYellow,
        ),
      );
}
