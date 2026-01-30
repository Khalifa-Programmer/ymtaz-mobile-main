import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/feature/intro/on_board/presentation/data/onboard_model.dart';

class OnBoardBody extends StatelessWidget {
  final OnboardingModel content;

  const OnBoardBody(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 49.5.h),
      child: Column(
        children: [
          Image.asset(
            content.asset,
            height: 278.h,
            width: 280.w,
          ),
          SizedBox(
            height: 44.1.h,
          ),
          Text(
              textAlign: TextAlign.center,
              content.content,
              style:
                  TextStyles.cairo_20_bold.copyWith(color: appColors.blue100)),
          Padding(
            padding: EdgeInsets.only(top: 15.h, right: 16.w, left: 16.h),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                  textAlign: TextAlign.center,
                  content.contentDescription,
                  style: TextStyles.cairo_12_semiBold
                      .copyWith(color: appColors.grey20)),
            ),
          ),
        ],
      ),
    );
  }
}
