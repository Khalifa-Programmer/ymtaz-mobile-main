import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/helpers/fuctions_helpers/functions_helpers.dart';
import '../../../../../core/widgets/spacing.dart';

class ServiceOfferCardPending extends StatelessWidget {
  final String serviceName;
  final String servicePrice;
  final String serviceDate;
  final String serviceTime;
  final String serviceStatus;
  final String servicePiriorty;
  final String providerName;
  final String providerImage;

  const ServiceOfferCardPending({
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
        mainAxisSize: MainAxisSize.min,
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
                    "وقت الطلب",
                    style: TextStyles.cairo_12_semiBold
                        .copyWith(color: appColors.grey15),
                  ),
                  verticalSpace(5.h),
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
                    "$serviceDate , $serviceTime",
                    style: TextStyles.cairo_12_semiBold
                        .copyWith(color: appColors.blue100),
                  ),
                  verticalSpace(5.h),
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
                  color: getOfferStatusColor(serviceStatus).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Center(
                  child: Text(getOfferStatusText(serviceStatus),
                      style: TextStyles.cairo_12_bold.copyWith(
                        color: getOfferStatusColor(serviceStatus),
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
            ],
          )
        ],
      ),
    );
  }
}

// class ShimmerServiceOfferCardPending extends StatelessWidgetdget {
//   const ShimmerServiceOfferCardPending({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey[300]!,
//       highlightColor: Colors.grey[100]!,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 17.w),
//         padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 17.w),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.r),
//           border: Border.all(color: Colors.grey[200]!),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Top Row with Avatar and Name
//             Row(
//               children: [
//                 // Avatar Placeholder
//                 CircleAvatar(
//                   radius: 15.r,
//                   backgroundColor: Colors.grey[300],
//                 ),
//                 horizontalSpace(10.w),
//                 // Name Placeholder
//                 Container(
//                   width: 120.w,
//                   height: 12.h,
//                   color: Colors.grey[300],
//                 ),
//                 Spacer(),
//                 // Arrow Icon Placeholder
//                 Container(
//                   width: 12.w,
//                   height: 12.h,
//                   color: Colors.grey[300],
//                 ),
//               ],
//             ),
//             verticalSpace(10.h),
//
//             // Details Row
//             Row(
//               children: [
//                 // Left Column Placeholder
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: 80.w,
//                       height: 12.h,
//                       color: Colors.grey[300],
//                     ),
//                     verticalSpace(5.h),
//                     Container(
//                       width: 80.w,
//                       height: 12.h,
//                       color: Colors.grey[300],
//                     ),
//                   ],
//                 ),
//                 horizontalSpace(20.w),
//                 // Right Column Placeholder
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: 120.w,
//                       height: 12.h,
//                       color: Colors.grey[300],
//                     ),
//                     verticalSpace(5.h),
//                     Container(
//                       width: 150.w,
//                       height: 12.h,
//                       color: Colors.grey[300],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             verticalSpace(10.h),
//
//             // Divider Placeholder
//             Container(
//               height: 1.h,
//               color: Colors.grey[300],
//             ),
//             verticalSpace(10.h),
//
//             // Bottom Row with Status and Priority
//             Row(
//               children: [
//                 Container(
//                   width: 60.w,
//                   height: 20.h,
//                   color: Colors.grey[300],
//                 ),
//                 horizontalSpace(10.w),
//                 Container(
//                   width: 80.w,
//                   height: 20.h,
//                   color: Colors.grey[300],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class ShimmerServiceOfferCardPending extends StatelessWidget {
  const ShimmerServiceOfferCardPending({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Skeletonizer(
          textBoneBorderRadius: TextBoneBorderRadius(BorderRadius.circular(25)),
          child: Container(
            child: ServiceOfferCardPending(
              serviceName: '             ',
              servicePrice: '                 ',
              serviceDate: '             ',
              serviceTime: '             ',
              serviceStatus: '               ',
              servicePiriorty: '              ',
              providerName: '                 ',
              providerImage: 'https://api.ymtaz.sa/uploads/person.png',
            ),
          ),
        ),
        Skeletonizer(
          textBoneBorderRadius: TextBoneBorderRadius(BorderRadius.circular(25)),
          child: Container(
            child: ServiceOfferCardPending(
              serviceName: '             ',
              servicePrice: '                 ',
              serviceDate: '             ',
              serviceTime: '             ',
              serviceStatus: '               ',
              servicePiriorty: '              ',
              providerName: '                 ',
              providerImage: 'https://api.ymtaz.sa/uploads/person.png',
            ),
          ),
        ),
      ],
    );
  }
}
