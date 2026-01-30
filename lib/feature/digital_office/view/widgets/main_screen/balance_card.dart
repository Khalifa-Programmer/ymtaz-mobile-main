import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';

import '../../../../../core/widgets/spacing.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: appColors.primaryColorYellow.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(width: 1, color: appColors.darkYellow10)),
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            right: -100,
            top: -200,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: appColors.primaryColorYellow.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            left: -100,
            bottom: -200,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: appColors.primaryColorYellow.withOpacity(0.1),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "الرصيد الحالي",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: appColors.blue100,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      CupertinoIcons.forward,
                      size: 15.sp,
                    )
                  ],
                ),
                verticalSpace(5.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "0,0",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: appColors.blue100,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    horizontalSpace(4.w),
                    Padding(
                      padding: EdgeInsets.only(bottom: 7.h),
                      child: Text(
                        "ريال سعودي",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: appColors.blue100,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace(5.h),
                Text(
                  "الرصيد المعلق",
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: appColors.blue100,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpace(5.h),
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.time_solid,
                      color: appColors.primaryColorYellow,
                      size: 20,
                    ),
                    horizontalSpace(4.w),
                    Text(
                      "0,0",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: appColors.blue100,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    horizontalSpace(4.w),
                    Text(
                      "ريال سعودي",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: appColors.blue100,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SubscripeCard extends StatelessWidget {
  const SubscripeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => AddServices(),
        //   ),
        // );
      },
      child: Container(
        decoration: BoxDecoration(
            color: appColors.primaryColorYellow.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(width: 1, color: appColors.darkYellow10)),
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              right: -100,
              top: -200,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: appColors.primaryColorYellow.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              left: -100,
              bottom: -200,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: appColors.primaryColorYellow.withOpacity(0.1),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.warning_rounded,
                        color: appColors.primaryColorYellow,
                      ),
                      horizontalSpace(6.w),
                      Text(
                        "القنوات الرقمية غير مفعلة لهذا الحساب",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Cairo',
                          color: appColors.blue100,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        CupertinoIcons.forward,
                        size: 15.sp,
                        color: appColors.primaryColorYellow,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class StoppedProductsCard extends StatelessWidget {
  const StoppedProductsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => AddServices(),
        //   ),
        // );
      },
      child: Container(
        decoration: BoxDecoration(
            color: appColors.primaryColorYellow.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(width: 1, color: appColors.darkYellow10)),
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              right: -100,
              top: -200,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: appColors.primaryColorYellow.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              left: -100,
              bottom: -200,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: appColors.primaryColorYellow.withOpacity(0.1),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.warning_rounded,
                        color: appColors.primaryColorYellow,
                      ),
                      horizontalSpace(6.w),
                      Text(
                        "المكتب الرقمي لهذا الحساب غير مفعل",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Cairo',
                          color: appColors.blue100,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
