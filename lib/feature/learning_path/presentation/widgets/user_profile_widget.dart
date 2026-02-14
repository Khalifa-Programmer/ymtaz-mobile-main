import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'د/محمد عبدالله',
            style: TextStyles.cairo_16_medium.copyWith(
              color: appColors.blue100,
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: appColors.blue100.withOpacity(0.1),
              border: Border.all(
                color: appColors.primaryColorYellow,
                width: 2.w,
              ),
            ),
            child: Icon(
              Icons.person,
              color: appColors.blue100,
              size: 28.sp,
            ),
          ),
        ],
      ),
    );
  }
} 
