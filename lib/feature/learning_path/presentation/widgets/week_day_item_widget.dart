import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';

class WeekDayItemWidget extends StatelessWidget {
  final String day;
  final bool isSelected;
  final bool isComplete;
  final bool isRest;

  const WeekDayItemWidget({
    super.key, 
    required this.day, 
    this.isSelected = false, 
    this.isComplete = false, 
    this.isRest = false
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                  color: isRest 
                      ? appColors.red5
                      : isSelected 
                          ? appColors.primaryColorYellow 
                          : isComplete 
                              ? appColors.primaryColorYellow 
                              : appColors.grey2,
                  width: isSelected ? 2.w : 1.w,
                ),
              ),
            ),
            Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isRest 
                    ? appColors.red5 
                    : isSelected 
                        ? appColors.primaryColorYellow 
                        : Colors.transparent,
              ),
              child: Center(
                child: isRest 
                    ? Text(
                        'راحة',
                        style: TextStyle(
                          color: appColors.red,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Cairo',
                        ),
                      )
                    : isComplete
                        ? Icon(
                            Icons.check,
                            color: isSelected ? appColors.white : appColors.primaryColorYellow,
                            size: 16.sp,
                          )
                        : null,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          day,
          style: TextStyles.cairo_10_regular.copyWith(
            color: isSelected ? appColors.blue100 : appColors.grey10,
          ),
        ),
        if (isSelected)
          Container(
            height: 2.h,
            width: 16.w,
            margin: EdgeInsets.only(top: 2.h),
            decoration: BoxDecoration(
              color: appColors.primaryColorYellow,
              borderRadius: BorderRadius.circular(1.r),
            ),
          ),
      ],
    );
  }
} 
