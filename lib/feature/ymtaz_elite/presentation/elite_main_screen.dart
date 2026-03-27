import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/app_bar.dart';
import 'package:yamtaz/core/widgets/spacing.dart';

class EliteMainScreen extends StatelessWidget {
  const EliteMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: buildBlurredAppBar(context, "نخبة المستشارين"),
      body: Animate(
        effects: [FadeEffect(duration: 500.ms)],
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              // Large Banner
              _buildBanner(context),
              verticalSpace(30.h),
              // Bottom Action Row
              Row(
                children: [
                  Expanded(
                    child: _buildActionCard(
                      icon: Icons.grid_view_outlined,
                      title: "حالة الطلبات",
                      onTap: () => Navigator.pushNamed(context, Routes.eliteRequests),
                    ),
                  ),
                  horizontalSpace(16.w),
                  Expanded(
                    child: _buildActionCard(
                      icon: Icons.badge_outlined,
                      title: "قائمة المستشارين",
                      onTap: () {
                        // Navigate to filtered lawyers list if exists
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 120.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: appColors.primaryColorYellow.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.all(20.w),
            child: SvgPicture.asset(
              AppAssets.crown,
              color: appColors.primaryColorYellow,
            ),
          ),
          verticalSpace(20.h),
          Text(
            "نخبة المستشارين",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F2D37),
              fontFamily: 'Cairo',
            ),
          ),
          verticalSpace(8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              "تقديم حلول متنوعة وخطوات مدروسة لحل المشكلة بشكل شامل من قبل نخبة من المستشارين المتخصصين بأحدث التقنيات المتاحة",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[400],
                fontFamily: 'Cairo',
                height: 1.6,
              ),
            ),
          ),
          verticalSpace(24.h),
          SizedBox(
            width: 150.w,
            child: CupertinoButton(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              color: appColors.primaryColorYellow,
              onPressed: () => Navigator.pushNamed(context, Routes.eliteRequestScreen),
              child: Text(
                "بدأ الآن",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({required IconData icon, required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: appColors.primaryColorYellow, size: 28.sp),
            verticalSpace(12.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F2D37),
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
