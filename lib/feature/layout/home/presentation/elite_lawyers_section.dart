import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/spacing.dart';

class EliteLawyersSection extends StatelessWidget {
  const EliteLawyersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: LinearGradient(
          colors: [
            appColors.primaryColorYellow.withOpacity(0.5),
            appColors.lightYellow10,
            appColors.lightYellow10.withOpacity(0.8),
            appColors.primaryColorYellow.withOpacity(0.2),
          ],
          stops: [0.0, 0.2, 0.4, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: appColors.primaryColorYellow.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    AppAssets.crown,
                    width: 30.sp, // Enlarged icon
                    colorFilter: ColorFilter.mode(appColors.blue100, BlendMode.srcIn),
                  ),
                  horizontalSpace(8.w),
                  Text(
                    "هيئة المستشارين (خدمة النخبة)",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: appColors.blue100,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(8.h),
            Text(
              "تقديم حلول متنوعة وخطوات مدروسة لحل المشكلة بشكل شامل من قبل نخبة من المستشارين المتخصصين بأحدث التقنيات المتاحة",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 11.sp,
                color: const Color(0xFF0F2D37).withOpacity(0.9),
                fontFamily: 'Cairo',
                height: 1.6,
              ),
            ),
            verticalSpace(20.h),
            SizedBox(
              width: 140.w, // Smaller, more elegant button
              child: Container(
                decoration: BoxDecoration(
                  color: appColors.blue100,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: CupertinoButton(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  onPressed: () {
                    context.pushNamed(Routes.elitePromo);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ابدأ الآن",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      horizontalSpace(5.w),
                      Icon(Icons.arrow_forward_ios, color: Colors.white, size: 12.sp),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
