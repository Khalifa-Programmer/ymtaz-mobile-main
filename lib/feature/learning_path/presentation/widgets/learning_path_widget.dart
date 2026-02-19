import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/router/routes.dart';

class LearningPathWidget extends StatelessWidget {
  const LearningPathWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.learningPaths);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: appColors.primaryColorYellow),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        size: 12.sp,
                        color: appColors.primaryColorYellow,
                      ),
                      Text(
                        'المزيد',
                        style: TextStyles.cairo_12_medium.copyWith(
                          color: appColors.primaryColorYellow,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'المسار التعليمي',
                style: TextStyles.cairo_16_semiBold.copyWith(
                  color: appColors.blue100,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Container(
            height: 10.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: appColors.grey1,
            ),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4 - 32.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    gradient: LinearGradient(
                      colors: [
                        appColors.darkYellow100,
                        appColors.primaryColorYellow,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: appColors.primaryColorYellow.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      appColors.darkYellow100,
                      appColors.primaryColorYellow,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: appColors.primaryColorYellow.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Text(
                  'المستوى الأول',
                  style: TextStyles.cairo_11_medium.copyWith(
                    color: appColors.white,
                  ),
                ),
              ),
              Text(
                'يتبقى 400 مادة',
                style: TextStyles.cairo_12_regular.copyWith(
                  color: appColors.grey10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 
