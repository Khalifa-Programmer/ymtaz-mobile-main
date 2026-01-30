import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';

class ExpertSectionWidget extends StatelessWidget {
  const ExpertSectionWidget({super.key});

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
                'يختار خبير',
                style: TextStyles.cairo_16_semiBold.copyWith(
                  color: appColors.blue100,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'تواصل مع خبير قانوني',
                      style: TextStyles.cairo_16_semiBold.copyWith(
                        color: appColors.blue100,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'مساعدة الخبراء مستواك القانوني إلى مراحل متقدمة',
                      style: TextStyles.cairo_12_regular.copyWith(
                        color: appColors.grey10,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Container(
                width: 55.w,
                height: 55.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: appColors.grey2),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.lawyer,
                      width: 32.sp,
                      height: 32.sp,
                      color: appColors.blue100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 