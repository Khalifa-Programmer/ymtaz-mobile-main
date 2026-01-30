import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:yamtaz/core/constants/colors.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/widgets/spacing.dart';

class AdvisoryServiceCardShimmer extends StatelessWidget {
  const AdvisoryServiceCardShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 17.w),
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 17.w),
      decoration: BoxDecoration(
        color: appColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            spreadRadius: 2.r,
            blurRadius: 10.r,
            offset: const Offset(0.0, 0.75),
          ),
        ],
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Skeletonizer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "نوع الاستشارة",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: appColors.grey15,
                  ),
                ),
                const Spacer(),
                Text(
                  "serviceName",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: appColors.blue100,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            verticalSpace(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  CupertinoIcons.clock_fill,
                  color: appColors.primaryColorYellow,
                  size: 20.sp,
                ),
                horizontalSpace(10.w),
                Text(
                  "التاريخ",
                  style: TextStyles.cairo_12_semiBold
                      .copyWith(color: appColors.grey15),
                ),
                const Spacer(),
                Text(
                  " serviceDate",
                  style: TextStyles.cairo_12_semiBold
                      .copyWith(color: appColors.blue100),
                ),
              ],
            ),
            verticalSpace(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  CupertinoIcons.clock_fill,
                  color: appColors.primaryColorYellow,
                  size: 20.sp,
                ),
                horizontalSpace(10.w),
                Text(
                  "الوقت",
                  style: TextStyles.cairo_12_semiBold
                      .copyWith(color: appColors.grey15),
                ),
                const Spacer(),
                Text(
                  "serviceTime",
                  style: TextStyles.cairo_12_semiBold
                      .copyWith(color: appColors.blue100),
                ),
              ],
            ),
            verticalSpace(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  CupertinoIcons.clock_fill,
                  color: appColors.primaryColorYellow,
                  size: 20.sp,
                ),
                horizontalSpace(10.w),
                Text(
                  "السعر",
                  style: TextStyles.cairo_12_semiBold
                      .copyWith(color: appColors.grey15),
                ),
                const Spacer(),
                Text(
                  "servicePrice + ",
                  style: TextStyles.cairo_12_semiBold
                      .copyWith(color: appColors.blue100),
                ),
              ],
            ),
            verticalSpace(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  CupertinoIcons.clock_fill,
                  color: appColors.primaryColorYellow,
                  size: 20.sp,
                ),
                horizontalSpace(10.w),
                Text(
                  "مستوى الطلب",
                  style: TextStyles.cairo_12_semiBold
                      .copyWith(color: appColors.grey15),
                ),
                const Spacer(),
                Text(
                  "  servicePiriorty",
                  style: TextStyles.cairo_12_semiBold
                      .copyWith(color: appColors.blue100),
                ),
              ],
            ),
            verticalSpace(10.h),
            const Divider(
              color: appColors.grey,
              thickness: 0.5,
            ),
            verticalSpace(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 10.r,
                ),
                horizontalSpace(10.w),
                Text(
                  "providerName",
                  style: TextStyles.cairo_12_semiBold
                      .copyWith(color: appColors.grey15),
                ),
                Spacer(),
                Text(
                  "serviceStatus",
                  style: TextStyles.cairo_12_semiBold
                      .copyWith(color: appColors.grey15),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
