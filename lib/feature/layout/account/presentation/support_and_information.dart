import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/widgets/spacing.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/router/routes.dart';

class SupportAndInformation extends StatelessWidget {
  const SupportAndInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('مركز الدعم والمساعدة',
              style: TextStyles.cairo_14_bold.copyWith(
                color: appColors.black,
              )),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 40.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [appColors.primaryColorYellow.withOpacity(0.1), Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.support_agent_rounded,
                      size: 120.r,
                      color: appColors.blue100,
                    ),
                    verticalSpace(16.h),
                    Text(
                      'أهلا بك في مركز المساعدة',
                      style: TextStyles.cairo_20_bold.copyWith(
                        color: appColors.blue100,
                      ),
                    ),
                    Text(
                      'كيف يمكننا مساعدتك اليوم؟',
                      style: TextStyles.cairo_14_medium.copyWith(
                        color: appColors.grey15,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    _buildOptionCard(
                      context,
                      icon: CupertinoIcons.phone_circle_fill,
                      title: 'تواصل معنا',
                      subtitle: 'راسل فريق الدعم الفني مباشرة',
                      onTap: () => context.pushNamed(Routes.contactYmtaz),
                    ),
                    _buildOptionCard(
                      context,
                      icon: CupertinoIcons.question_circle_fill,
                      title: 'الأسئلة الشائعة',
                      subtitle: 'إجابات سريعة لأكثر الاستفسارات شيوعاً',
                      onTap: () => context.pushNamed(Routes.faq),
                    ),
                    _buildOptionCard(
                      context,
                      icon: Icons.pending_rounded,
                      title: 'وسائل التواصل',
                      subtitle: 'تابعنا على قنوات التواصل الاجتماعي',
                      onTap: () => context.pushNamed(Routes.socialMedia),
                    ),
                    _buildOptionCard(
                      context,
                      icon: CupertinoIcons.info_circle_fill,
                      title: 'عن يمتاز',
                      subtitle: 'تعرف على رؤيتنا وأهدافنا',
                      onTap: () => context.pushNamed(Routes.aboutYmtaz),
                    ),
                    _buildOptionCard(
                      context,
                      icon: Icons.privacy_tip_rounded,
                      title: 'سياسة الخصوصية',
                      subtitle: 'شروط الاستخدام وحماية البيانات',
                      onTap: () => context.pushNamed(Routes.privacyYmtaz),
                    ),
                    verticalSpace(40.h),
                    Text(
                      "© منصة يمتاز\nجميع الحقوق محفوظة",
                      textAlign: TextAlign.center,
                      style: TextStyles.cairo_12_semiBold.copyWith(color: appColors.grey15),
                    ),
                    verticalSpace(20.h),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildOptionCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(16.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: appColors.grey3, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: appColors.blue100.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                  color: appColors.lightYellow10.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, color: appColors.primaryColorYellow, size: 24.sp),
              ),
              horizontalSpace(16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyles.cairo_14_bold.copyWith(color: appColors.blue100),
                    ),
                    Text(
                      subtitle,
                      style: TextStyles.cairo_12_semiBold.copyWith(color: appColors.grey15),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: appColors.grey3, size: 14.sp),
            ],
          ),
        ),
      ),
    );
  }
}
