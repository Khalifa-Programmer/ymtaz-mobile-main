import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';

class LearningPathCertificatePage extends StatelessWidget {
  const LearningPathCertificatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.white,
      appBar: AppBar(
        title: Text('الشهادة', style: TextStyles.cairo_15_bold),
        centerTitle: true,
        backgroundColor: appColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: appColors.blue100, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40.h),
            // Certificate Container Placeholder
            Container(
              height: 250.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: appColors.lightYellow10,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: appColors.primaryColorYellow, width: 2),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.workspace_premium, color: appColors.primaryColorYellow, size: 80.sp),
                    SizedBox(height: 16.h),
                    Text(
                      'شهادة إتمام المسار',
                      style: TextStyles.cairo_18_bold.copyWith(color: appColors.blue100),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'تُمنح هذه الشهادة لإتمام جميع الدروس بنجاح',
                      style: TextStyles.cairo_12_regular.copyWith(color: appColors.blue100),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.h),
            CustomButton(
              title: 'تحميل كـ PDF',
              onPress: () {
                // Handle downloading
              },
            ),
            SizedBox(height: 16.h),
            CustomButton(
              title: 'مشاركة الشهادة',
              bgColor: appColors.white,
              titleColor: appColors.primaryColorYellow,
              borderColor: appColors.primaryColorYellow,
              onPress: () {
                // Handle sharing
              },
            ),
          ],
        ),
      ),
    );
  }
}
