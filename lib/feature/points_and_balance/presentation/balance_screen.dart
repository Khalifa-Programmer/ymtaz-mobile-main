import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/spacing.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({super.key});

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
                      bottom: -200,
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.w, vertical: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "الرصيد الحالي",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: appColors.blue100,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              const Icon(CupertinoIcons.forward)
                            ],
                          ),
                          verticalSpace(10.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "32,423",
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
                          verticalSpace(10.h),
                          Text(
                            "الرصيد المعلق",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: appColors.blue100,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          verticalSpace(10.h),
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.time_solid,
                                color: appColors.primaryColorYellow,
                              ),
                              horizontalSpace(4.w),
                              Text(
                                "8000",
                                style: TextStyle(
                                  fontSize: 16.sp,
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
              ),
              verticalSpace(20.h),
              Text(
                "أحدث المعاملات",
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
                itemCount: 5,
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
                          index == 0
                              ? CupertinoIcons.exclamationmark_circle_fill
                              : index == 1
                                  ? CupertinoIcons.xmark_circle_fill
                                  : CupertinoIcons.checkmark_alt_circle_fill,
                          color: index == 0
                              ? Colors.orangeAccent
                              : index == 1
                                  ? appColors.red
                                  : Colors.green,
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
                            verticalSpace(4.h),
                            Text(
                              "#526524",
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: appColors.blue100,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            Text(
                              index == 0
                                  ? "معلق"
                                  : index == 1
                                      ? "تم الالغاء"
                                      : "تم التسليم",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: index == 0
                                    ? Colors.orangeAccent
                                    : index == 1
                                        ? appColors.red
                                        : Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("2000 ر.س",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: appColors.blue100))
                          ],
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
