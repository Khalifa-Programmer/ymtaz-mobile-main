import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/spacing.dart';

import '../../../../../config/themes/styles.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget(
      {super.key,
      this.routeName,
      required this.icon,
      required this.title,
      required this.onTap});

  final String? routeName;
  final String icon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 40.w,
            height: 40.h,
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
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: SvgPicture.asset(
                icon,
                width: 20.sp,
                height: 20.sp,
                placeholderBuilder: (context) =>
                    const CircularProgressIndicator(),
              ),
            ),
          ),
        ),
        verticalSpace(8.h),
        Text(title,
            style: TextStyles.cairo_12_bold.copyWith(
              color: appColors.blue100,
            )),
      ],
    );
  }
}

class ItemWidgetWithLine extends StatelessWidget {
  const ItemWidgetWithLine(
      {super.key,
      this.routeName,
      required this.icon,
      required this.title,
      required this.onTap,
      required this.index});

  final String? routeName;
  final String icon;
  final String title;
  final VoidCallback? onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 40.h,
            width: 140.w,
            decoration: ShapeDecoration(
              color: Colors.white,
              shadows: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.04),
                  // Shadow color
                  spreadRadius: 3,
                  // Spread radius
                  blurRadius: 10,
                  // Blur radius
                  offset: const Offset(0, 3), // Offset in x and y direction
                ),
              ],
              shape: RoundedRectangleBorder(
                // side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),

                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: double.infinity,
                  width: 4.h,
                  decoration: BoxDecoration(
                    color: index % 4 < 2
                        ? appColors.primaryColorYellow
                        : appColors.blue90,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.r),
                        bottomRight: Radius.circular(10.r)),
                  ),
                ),
                horizontalSpace(10.w),
                SvgPicture.asset(
                  icon,
                  width: 20.sp,
                  height: 20.sp,
                  placeholderBuilder: (context) =>
                      const CircularProgressIndicator(),
                ),
                horizontalSpace(10.w),
                Text(title,
                    style: TextStyles.cairo_12_bold.copyWith(
                      color: appColors.blue100,
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ItemWidgetHorizontal extends StatelessWidget {
  const ItemWidgetHorizontal(
      {super.key,
      this.routeName,
      required this.icon,
      required this.title,
      required this.onTap});

  final String? routeName;
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: appColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 4.r,
                blurRadius: 9.r,
                offset: const Offset(3, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Icon(
              icon,
              color: appColors.primaryColorYellow,
              size: 20.sp,
            ),
          ),
        ),
        verticalSpace(8.h),
        Text(title,
            style: TextStyles.cairo_12_bold.copyWith(
              color: appColors.blue100,
            )),
      ],
    );
  }
}
