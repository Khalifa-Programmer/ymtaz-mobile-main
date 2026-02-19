import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/helpers/extentions.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/constants/assets.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/router/routes.dart';
import '../../../../../core/widgets/spacing.dart';
import '../../../../layout/my_page/view/widgets/my_lawyers_Screen.dart';
import 'item_widget.dart';

class MyOrdersItemsClientCard extends StatelessWidget {
  const MyOrdersItemsClientCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("الطلبات",
            style: TextStyles.cairo_12_bold.copyWith(
              color: appColors.blue100,
            )),
        verticalSpace(10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                ItemWidgetWithLine(
                  title: 'استشاراتي',
                  icon: AppAssets.advisories,
                  onTap: () {
                    context.pushNamed(Routes.myAdvisoryOrders);
                  },
                  index: 2,
                ),
                verticalSpace(16.h),
                ItemWidgetWithLine(
                  title: 'مواعيدي',
                  icon: AppAssets.appointments,
                  onTap: () {
                    context.pushNamed(Routes.myAppointments);
                  },
                  index: 1,
                  // routeName: '/new_orders',
                ),
              ],
            ),
            horizontalSpace(40.w),
            Column(
              children: [
                ItemWidgetWithLine(
                  title: 'خدماتي',
                  icon: AppAssets.services,
                  onTap: () {
                    context.pushNamed(Routes.myServices);
                  },
                  index: 0,
                ),
                verticalSpace(16.h),
                ItemWidgetWithLine(
                  title: 'عملائي',
                  icon: AppAssets.lawyer,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyLawyers(),
                        ));
                  },
                  index: 3,
                ),
              ],
            ),
          ],
        ),
        verticalSpace(10.h),
        // todo add elite requests here
        // GestureDetector(
        //   onTap: () {
        //     context.pushNamed(Routes.eliteRequests);
        //   },
        //   child: Container(
        //     height: 40.h,
        //     margin: EdgeInsets.symmetric(horizontal: 12.w),
        //     decoration: ShapeDecoration(
        //       color: Colors.white,
        //       shadows: [
        //         BoxShadow(
        //           color: Colors.black12.withOpacity(0.04),
        //           // Shadow color
        //           spreadRadius: 3,
        //           // Spread radius
        //           blurRadius: 10,
        //           // Blur radius
        //           offset: const Offset(0, 3), // Offset in x and y direction
        //         ),
        //       ],
        //       shape: RoundedRectangleBorder(
        //         // side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
        //
        //         borderRadius: BorderRadius.circular(4.r),
        //       ),
        //     ),
        //     child: Row(
        //       children: [
        //         Container(
        //           height: double.infinity,
        //           width: 4.h,
        //           decoration: BoxDecoration(
        //             color: appColors.primaryColorYellow,
        //             borderRadius: BorderRadius.only(
        //                 topRight: Radius.circular(10.r),
        //                 bottomRight: Radius.circular(10.r)),
        //           ),
        //         ),
        //         horizontalSpace(10.w),
        //         SvgPicture.asset(
        //           AppAssets.crown,
        //           width: 20.sp,
        //           height: 20.sp,
        //           placeholderBuilder: (context) =>
        //               const CircularProgressIndicator(),
        //         ),
        //         horizontalSpace(10.w),
        //         Text("هيئة المستشارين",
        //             style: TextStyles.cairo_12_bold.copyWith(
        //               color: appColors.blue100,
        //             )),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
