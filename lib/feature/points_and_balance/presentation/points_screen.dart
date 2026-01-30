import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/widgets/spacing.dart';

class PointsScreen extends StatelessWidget {
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: appColors.primaryColorYellow.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                        width: 1, color: appColors.darkYellow10)),
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
                          color: appColors.primaryColorYellow
                              .withOpacity(0.1),
                        ),
                      ),
                    ),
                    Positioned(
                      left: -100,
                      bottom: -100,
                      child: Icon(
                        Icons.star_rate_rounded,
                        color:
                            appColors.primaryColorYellow.withOpacity(0.1),
                        size: 300,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.w, vertical: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "إجمالي النقاط",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: appColors.darkYellow100,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          verticalSpace(15.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "9000",
                                style: TextStyle(
                                  fontSize: 26.sp,
                                  color: appColors.blue100,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              horizontalSpace(4.w),
                              Padding(
                                padding: EdgeInsets.only(bottom: 7.h),
                                child: Text(
                                  "نقطة",
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: appColors.blue100,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(15.h),
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.exclamationmark_shield_fill,
                                color: appColors.primaryColorYellow,
                              ),
                              horizontalSpace(5.w),
                              Text(
                                "يمكنك استبدال النقاط باستشارات و خدمات مجانية",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: appColors.blue100,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(15.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpace(20.h),
              Text(
                "استبدال النقاط",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: appColors.blue100,
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalSpace(8.h),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 22.h),
                    decoration: BoxDecoration(
                      color: appColors.grey3,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.discount_rounded,
                          color: appColors.primaryColorYellow,
                        ),
                        horizontalSpace(10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "توكيل محامي",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: appColors.blue100,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text("2000 نقطة",
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: appColors.blue100)),
                        horizontalSpace(4.w),
                        Icon(
                          CupertinoIcons.forward,
                          color: appColors.blue100,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return verticalSpace(16.h);
                },
              )
            ],
          )),
    );
  }
}
