import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/feature/training/presentation/widgets/video_screen.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/spacing.dart';

class TrainingView extends StatelessWidget {
  const TrainingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('محتوي الدورة',
            style: TextStyles.cairo_14_bold.copyWith(
              color: appColors.black,
            )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 7,
                      blurRadius: 9,
                      offset: const Offset(3, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: VideoScreen()),
            Expanded(
                child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  padding: EdgeInsets.all(20.0.sp),
                  margin: EdgeInsets.symmetric(
                      horizontal: 20.0.sp, vertical: 12.0.sp),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: appColors.grey3,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "دورة شاملة لتعلم علوم الجريمة وأساسيات علم النفس الجنائي والقانون",
                        style: TextStyles.cairo_16_bold
                            .copyWith(color: appColors.blue100),
                      ),
                      verticalSpace(12.h),
                      Container(
                        width: 130.w,
                        height: 2.h,
                        color: appColors.primaryColorYellow,
                      ),
                      verticalSpace(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: appColors.primaryColorYellow,
                                    size: 12.sp,
                                  ),
                                  horizontalSpace(4.w),
                                  Text(
                                    "المدرب : ",
                                    style: TextStyles.cairo_12_semiBold
                                        .copyWith(color: appColors.grey5),
                                  ),
                                  Text(
                                    "أحمد محمد",
                                    style: TextStyles.cairo_12_semiBold
                                        .copyWith(color: appColors.blue100),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.settings_remote,
                                    color: appColors.primaryColorYellow,
                                    size: 12.sp,
                                  ),
                                  horizontalSpace(4.w),
                                  Text(
                                    "الحالة : ",
                                    style: TextStyles.cairo_12_semiBold
                                        .copyWith(color: appColors.grey5),
                                  ),
                                  Text(
                                    "عن بعد",
                                    style: TextStyles.cairo_12_semiBold
                                        .copyWith(color: appColors.blue100),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.date_range_outlined,
                                    color: appColors.primaryColorYellow,
                                    size: 12.sp,
                                  ),
                                  horizontalSpace(4.w),
                                  Text(
                                    "التاريخ : ",
                                    style: TextStyles.cairo_12_semiBold
                                        .copyWith(color: appColors.grey5),
                                  ),
                                  Text(
                                    "٢٠٢٤/١٢/١٢",
                                    style: TextStyles.cairo_12_semiBold
                                        .copyWith(color: appColors.blue100),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.filter_tilt_shift_sharp,
                                    color: appColors.primaryColorYellow,
                                    size: 12.sp,
                                  ),
                                  horizontalSpace(4.w),
                                  Text(
                                    "نوع الدورة : ",
                                    style: TextStyles.cairo_12_semiBold
                                        .copyWith(color: appColors.grey5),
                                  ),
                                  Text(
                                    "مدفوع",
                                    style: TextStyles.cairo_12_semiBold
                                        .copyWith(color: appColors.blue100),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: appColors.primaryColorYellow,
                                    size: 12.sp,
                                  ),
                                  horizontalSpace(4.w),
                                  Text(
                                    "الموضوع : ",
                                    style: TextStyles.cairo_12_semiBold
                                        .copyWith(color: appColors.grey5),
                                  ),
                                  Text(
                                    "المحاماه",
                                    style: TextStyles.cairo_12_semiBold
                                        .copyWith(color: appColors.blue100),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: appColors.primaryColorYellow,
                                    size: 12.sp,
                                  ),
                                  horizontalSpace(4.w),
                                  Text(
                                    "السعر : ",
                                    style: TextStyles.cairo_12_semiBold
                                        .copyWith(color: appColors.grey5),
                                  ),
                                  Text(
                                    "١٠٠٠ ريال سعودي",
                                    style: TextStyles.cairo_12_semiBold
                                        .copyWith(color: appColors.blue100),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0.sp),
                  margin: EdgeInsets.symmetric(
                      horizontal: 20.0.sp, vertical: 12.0.sp),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: appColors.grey3,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "نبذة عن الدورة",
                        style: TextStyles.cairo_16_bold
                            .copyWith(color: appColors.blue100),
                      ),
                      verticalSpace(12.h),
                      Container(
                        width: 130.w,
                        height: 2.h,
                        color: appColors.primaryColorYellow,
                      ),
                      verticalSpace(20.h),
                      Text(
                        "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة لقد تم توليد هذا النص من مولد النص العربى هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة لقد تم توليد هذا النص من مولد النص العربى",
                        style: TextStyles.cairo_14_semiBold
                            .copyWith(color: appColors.grey5),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0.sp),
                  margin: EdgeInsets.symmetric(
                      horizontal: 20.0.sp, vertical: 12.0.sp),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: appColors.grey3,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "تعليمات الدورة",
                        style: TextStyles.cairo_16_bold
                            .copyWith(color: appColors.blue100),
                      ),
                      verticalSpace(12.h),
                      Container(
                        width: 130.w,
                        height: 2.h,
                        color: appColors.primaryColorYellow,
                      ),
                      verticalSpace(20.h),
                      Text(
                        "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة لقد تم توليد هذا النص من مولد النص العربى هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة لقد تم توليد هذا النص من مولد النص العربى",
                        style: TextStyles.cairo_14_semiBold
                            .copyWith(color: appColors.grey5),
                      ),
                    ],
                  ),
                ),
              ]),
            ))
          ],
        ),
      ),
    );
  }
}
