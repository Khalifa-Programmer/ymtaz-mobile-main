import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';

class StatisticsWidget extends StatelessWidget {
  const StatisticsWidget({super.key});

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
                onTap: () {},
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
                'إحصاءات',
                style: TextStyles.cairo_16_semiBold.copyWith(
                  color: appColors.blue100,
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: Color(0xFF8A56AC),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.stacked_bar_chart,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '0',
                    style: TextStyles.cairo_24_bold.copyWith(
                      color: appColors.blue100,
                      fontSize: 28.sp,
                    ),
                  ),
                  Text(
                    'أعلى محاسبة',
                    style: TextStyles.cairo_12_regular.copyWith(
                      color: appColors.grey10,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 80.w),
              Column(
                children: [
                  Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: Color(0xFFFF5722),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.local_fire_department,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '0',
                    style: TextStyles.cairo_24_bold.copyWith(
                      color: appColors.blue100,
                      fontSize: 28.sp,
                    ),
                  ),
                  Text(
                    'أيام المحاسبة',
                    style: TextStyles.cairo_12_regular.copyWith(
                      color: appColors.grey10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
} 
