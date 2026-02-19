import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/feature/package_and_subscriptions/presentation/all_packages_screen.dart';
import 'package:yamtaz/feature/package_and_subscriptions/presentation/widgets/time_remainig_progress.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/helpers/fuctions_helpers/functions_helpers.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/widgets/spacing.dart';
import '../../../auth/login/data/models/login_provider_response.dart';

class LawyerPackageCard extends StatelessWidget {
  const LawyerPackageCard({super.key, required this.package});

  final Subscription? package;

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: package != null,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            context.pushNamed(Routes.packages);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: appColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 4,
                  blurRadius: 9,
                  offset: const Offset(3, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                horizontalSpace(10.w),
                TimeRemainingProgress(
                  startDate: DateTime.parse(package!.startDate!.toString()),
                  endDate: DateTime.parse(package!.endDate!.toString()),
                ),
                horizontalSpace(10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${daysRemaining(DateTime.parse(package!.endDate!))} يوم ",
                      style: TextStyles.cairo_12_bold,
                    ),
                    verticalSpace(2.h),
                    Text(
                      "على التجديد",
                      style: TextStyles.cairo_12_semiBold
                          .copyWith(color: appColors.grey15),
                    ),
                  ],
                ),
                horizontalSpace(15.w),
                Container(
                  height: 30.h,
                  width: 1.w,
                  color: appColors.grey15,
                ),
                horizontalSpace(15.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "الباقة الحالية",
                      style: TextStyles.cairo_12_bold,
                    ),
                    verticalSpace(2.h),
                    Text(
                      package!.package!.name!,
                      style: TextStyles.cairo_12_semiBold
                          .copyWith(color: appColors.grey15),
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios, color: appColors.blue100),
              ],
            ),
          ),
        );
      },
      fallback: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AllPackagesScreen()));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: appColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 4,
                  blurRadius: 9,
                  offset: const Offset(3, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      AppAssets.pack,
                      width: 30.w,
                      height: 30.h,
                    ),
                    horizontalSpace(10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          'هل ترغب بمعرفة الباقات و المميزات ؟',
                          style: TextStyles.cairo_12_bold
                              .copyWith(color: appColors.blue100),
                        ),
                        verticalSpace(3.h),
                        Text(
                          textAlign: TextAlign.center,
                          'استكشفها الآن',
                          style: TextStyles.cairo_11_semiBold
                              .copyWith(color: appColors.grey15),
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, color: appColors.blue100),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
