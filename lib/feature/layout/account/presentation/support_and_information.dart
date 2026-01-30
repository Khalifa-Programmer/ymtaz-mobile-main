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
        body: Center(
          child: Column(
            children: [
              Icon(
                Icons.support_agent_rounded,
                size: 200.r,
                color: appColors.primaryColorYellow,
              ),
              Text(
                'أهلا بك في مركز الدعم والمساعدة',
                style: TextStyles.cairo_18_bold.copyWith(
                  color: appColors.primaryColorYellow,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'كيف يمكننا مساعدتك؟',
                style: TextStyles.cairo_16_bold.copyWith(
                  color: appColors.black,
                ),
              ),
              verticalSpace(10.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white, // iOS style background
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 2), // subtle shadow for iOS style
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CupertinoListTile(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      leading: Icon(
                        CupertinoIcons.phone_circle_fill, // iOS style icon
                        color: appColors.primaryColorYellow,
                        size: 28.r,
                      ),
                      title: Text(
                        'تواصل معنا',
                        style: TextStyles.cairo_14_bold.copyWith(
                          color: appColors.black,
                        ),
                      ),
                      trailing: const Icon(
                        CupertinoIcons.forward, // iOS style forward arrow
                        color: Colors.grey,
                      ),
                      onTap: () {
                        context.pushNamed(Routes.contactYmtaz);
                      },
                    ),
                    verticalSpace(5),
                    Divider(
                      height: 1,
                      thickness: 0.3,
                      color: Colors.grey[300],
                    ),
                    verticalSpace(5),
                    CupertinoListTile(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      leading: Icon(
                        CupertinoIcons.info_circle_fill, // iOS style icon
                        color: appColors.primaryColorYellow,
                        size: 28.r,
                      ),
                      title: Text(
                        'عن يمتاز',
                        style: TextStyles.cairo_14_bold.copyWith(
                          color: appColors.black,
                        ),
                      ),
                      trailing: const Icon(
                        CupertinoIcons.forward, // iOS style forward arrow
                        color: Colors.grey,
                      ),
                      onTap: () {
                        context.pushNamed(Routes.aboutYmtaz);
                      },
                    ),
                    verticalSpace(5),
                    Divider(
                      height: 1,
                      thickness: 0.3,
                      color: Colors.grey[300],
                    ),
                    verticalSpace(5),
                    CupertinoListTile(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      leading: Icon(
                        CupertinoIcons.question_circle_fill, // iOS style icon
                        color: appColors.primaryColorYellow,
                        size: 28.r,
                      ),
                      title: Text(
                        'الأسئلة الشائعة',
                        style: TextStyles.cairo_14_bold.copyWith(
                          color: appColors.black,
                        ),
                      ),
                      trailing: const Icon(
                        CupertinoIcons.forward, // iOS style forward arrow
                        color: Colors.grey,
                      ),
                      onTap: () {
                        context.pushNamed(Routes.faq);
                      },
                    ),
                    verticalSpace(5),
                    Divider(
                      height: 1,
                      thickness: 0.3,
                      color: Colors.grey[300],
                    ),
                    verticalSpace(5),
                    CupertinoListTile(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      leading: Icon(
                        Icons.privacy_tip_sharp, // iOS style icon
                        color: appColors.primaryColorYellow,
                        size: 28.r,
                      ),
                      title: Text(
                        'سياسة الخصوصية',
                        style: TextStyles.cairo_14_bold.copyWith(
                          color: appColors.black,
                        ),
                      ),
                      trailing: const Icon(
                        CupertinoIcons.forward, // iOS style forward arrow
                        color: Colors.grey,
                      ),
                      onTap: () {
                        context.pushNamed(Routes.privacyYmtaz);
                      },
                    ),
                    verticalSpace(5),
                    Divider(
                      height: 1,
                      thickness: 0.3,
                      color: Colors.grey[300],
                    ),
                    verticalSpace(5),
                    CupertinoListTile(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      leading: Icon(
                        Icons.pending, // iOS style icon
                        color: appColors.primaryColorYellow,
                        size: 28.r,
                      ),
                      title: Text(
                        'وسائل التواصل',
                        style: TextStyles.cairo_14_bold.copyWith(
                          color: appColors.black,
                        ),
                      ),
                      trailing: const Icon(
                        CupertinoIcons.forward, // iOS style forward arrow
                        color: Colors.grey,
                      ),
                      onTap: () {
                        context.pushNamed(Routes.socialMedia);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
