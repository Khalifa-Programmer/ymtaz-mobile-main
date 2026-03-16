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
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFBF1D4), // Color from image
            Color(0xFFF1D896), // Darker gold for bottom
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end, // Aligns description text and button to right
          children: [
            // Align Header (Text + Icon) to the absolute right
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min, // Takes only needed space
                children: [
                  SvgPicture.asset(
                    AppAssets.crown,
                    width: 18.sp,
                    color: const Color(0xFFD4AF37),
                  ),
                  horizontalSpace(8.w),
                  Text(
                    "فريقك الاستشاري",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F2D37),
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
              width: double.infinity,
              child: CupertinoButton(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                color: const Color(0xFFD4AF37),
                borderRadius: BorderRadius.circular(12.r),
                onPressed: () {
                  context.pushNamed(Routes.elitePromo);
                },
                child: Text(
                  "ابدأ الآن",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Cairo',
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
