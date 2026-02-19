import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/widgets/spacing.dart';


class AdvisoryServiceCard extends StatelessWidget {
  final String serviceName;
  final String servicePrice;
  final String serviceDate;
  final String serviceTime;
  final String serviceStatus;
  final String servicePiriorty;
  final String providerName;
  final String providerImage;

  const AdvisoryServiceCard({
    super.key,
    required this.serviceName,
    required this.servicePrice,
    required this.serviceDate,
    required this.serviceTime,
    required this.serviceStatus,
    required this.servicePiriorty,
    required this.providerName,
    required this.providerImage,
  });



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 16.h, horizontal: 17.w),
      margin: EdgeInsets.symmetric(
          vertical: 8.h, horizontal: 17.w),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                serviceName,
                style:  TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: appColors.blue100,
                ),
              ),
              const Spacer(),
              Text(
                serviceStatus,
                style: TextStyles.cairo_14_bold
                    .copyWith(
                    color: serviceStatus == "انتظار"? Colors.orange :appColors.green),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          verticalSpace(10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                CupertinoIcons.calendar,
                color:
                appColors.primaryColorYellow,
                size: 20.sp,
              ),
              horizontalSpace(10.w),
              Text(
              "التاريخ",
                style: TextStyles.cairo_12_semiBold
                    .copyWith(
                    color: appColors.grey15),
              ),
              const Spacer(),
              Text(
                serviceDate,
                style: TextStyles.cairo_12_semiBold
                    .copyWith(
                    color: appColors.blue100),
              ),
            ],
          ),
          verticalSpace(10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Icon(
                CupertinoIcons.clock_fill,
                color:
                appColors.primaryColorYellow,
                size: 20.sp,
              ),
              horizontalSpace(10.w),
              Text(
                "الوقت",
                style: TextStyles.cairo_12_semiBold
                    .copyWith(
                    color: appColors.grey15),
              ),
              const Spacer(),
              Text(
                serviceTime,
                style: TextStyles.cairo_12_semiBold
                    .copyWith(
                    color: appColors.blue100),
              ),
            ],
          ),
          verticalSpace(10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Icon(
                CupertinoIcons.money_dollar,
                color:
                appColors.primaryColorYellow,
                size: 20.sp,
              ),
              horizontalSpace(10.w),
              Text(
                "السعر",
                style: TextStyles.cairo_12_semiBold
                    .copyWith(
                    color: appColors.grey15),
              ),
              const Spacer(),
              Text(
                "$servicePriceريال",
                style: TextStyles.cairo_12_semiBold
                    .copyWith(
                    color: appColors.blue100),
              ),
            ],
          ),
          verticalSpace(10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Icon(
                CupertinoIcons.square_stack_3d_up_fill,
                color:
                appColors.primaryColorYellow,
                size: 20.sp,
              ),
              horizontalSpace(10.w),
              Text(
                "مستوى الطلب",
                style: TextStyles.cairo_12_semiBold
                    .copyWith(
                    color: appColors.grey15),
              ),
              const Spacer(),
              Text(
                servicePiriorty,
                style: TextStyles.cairo_12_semiBold
                    .copyWith(
                    color: appColors.blue100),
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
                backgroundImage: NetworkImage(providerImage.isEmpty
                    ? 'https://api.ymtaz.sa/uploads/person.png'
                    : providerImage),
              ),
              horizontalSpace(10.w),
              Text(
                providerName,
                style: TextStyles.cairo_12_semiBold
                    .copyWith(
                    color: appColors.grey15),
              ),

            ],
          ),



        ],
      ),

    );
  }
}
