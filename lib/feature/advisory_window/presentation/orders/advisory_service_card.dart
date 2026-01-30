import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/widgets/spacing.dart';
import '../../../../core/helpers/fuctions_helpers/functions_helpers.dart';

class AdvisoryServiceCard extends StatelessWidget {
  final String serviceName;
  final String servicePrice;
  final String serviceDate;
  final String serviceTime;
  final String serviceStatus;
  final String servicePiriorty;
  final String providerName;
  final String providerImage;
  final String type;

  final String generalType;

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
    required this.type,
    required this.generalType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 17.w),
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 17.w),
      decoration: BoxDecoration(
        color: appColors.white,
        border: Border.all(color: appColors.grey2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 9,
            offset: const Offset(3, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 15.r,
                backgroundImage: NetworkImage(providerImage),
              ),
              horizontalSpace(10.w),
              Text(
                providerName,
                style: TextStyles.cairo_14_semiBold
                    .copyWith(color: appColors.blue100),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: appColors.grey15,
                size: 15.r,
              )
            ],
          ),
          verticalSpace(10.h),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "التخصص الدقيق",
                    style: TextStyles.cairo_12_semiBold
                        .copyWith(color: appColors.grey15),
                  ),
                  verticalSpace(5.h),
                  Text(
                    "التخصص العام",
                    style: TextStyles.cairo_12_semiBold
                        .copyWith(color: appColors.grey15),
                  ),
                  verticalSpace(5.h),
                  Text(
                    "وقت الطلب",
                    style: TextStyles.cairo_12_semiBold
                        .copyWith(color: appColors.grey15),
                  ),
                  verticalSpace(5.h),
                  Text(
                    "الوسيلة",
                    style: TextStyles.cairo_12_semiBold
                        .copyWith(color: appColors.grey15),
                  ),
                ],
              ),
              horizontalSpace(20.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceName,
                    style: TextStyles.cairo_12_semiBold
                        .copyWith(color: appColors.blue100),
                  ),
                  verticalSpace(5.h),
                  Text(
                    generalType,
                    style: TextStyles.cairo_12_semiBold
                        .copyWith(color: appColors.blue100),
                  ),
                  verticalSpace(5.h),
                  Text(
                    "$serviceDate , $serviceTime",
                    style: TextStyles.cairo_12_semiBold
                        .copyWith(color: appColors.blue100),
                  ),
                  verticalSpace(5.h),
                  Text(
                    type,
                    style: TextStyles.cairo_12_semiBold
                        .copyWith(color: appColors.blue100),
                  ),
                ],
              )
            ],
          ),
          verticalSpace(5.h),
          const Divider(
            color: appColors.grey,
            thickness: 0.5,
          ),
          verticalSpace(5.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: getStatusColor(serviceStatus).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Center(
                  child: Text(serviceStatus,
                      style: TextStyles.cairo_12_bold.copyWith(
                        color: getStatusColor(serviceStatus),
                      )),
                ),
              ),
              horizontalSpace(10.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: appColors.primaryColorYellow.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Center(
                  child: Text(servicePiriorty,
                      style: TextStyles.cairo_12_bold.copyWith(
                        color: appColors.primaryColorYellow,
                      )),
                ),
              ),
              Spacer(),
              Text(
                "$servicePrice ريال",
                style:
                    TextStyles.cairo_12_bold.copyWith(color: appColors.blue100),
              ),
            ],
          )
        ],
      ),
    );
  }
}
