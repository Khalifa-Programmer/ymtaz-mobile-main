import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/constants/assets.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/spacing.dart';

class Nodata extends StatelessWidget {
  const Nodata({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        verticalSpace(150.h),
        Row(),
        SvgPicture.asset(
          AppAssets.nodatanew,
          width: 100.w,
          height: 100.h,
        ),
        verticalSpace(20.h),
        Text(
          'لا يوجد طلبات',
          style: TextStyles.cairo_12_medium.copyWith(
            color: appColors.black,
          ),
        ),
      ],
    );
  }
}

class NodataFound extends StatelessWidget {
  const NodataFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(),
        SvgPicture.asset(
          AppAssets.nodatanew,
          width: 100.w,
          height: 100.h,
        ),
        verticalSpace(20.h),
        Text(
          'لا يوجد بيانات',
          style: TextStyles.cairo_12_medium.copyWith(
            color: appColors.black,
          ),
        ),
      ],
    );
  }
}

class NoOrdersFound extends StatelessWidget {
  const NoOrdersFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(),
        SvgPicture.asset(
          AppAssets.nodatanew,
          width: 100.w,
          height: 100.h,
        ),
        verticalSpace(20.h),
        Text(
          'لا يوجد طلبات',
          style: TextStyles.cairo_12_medium.copyWith(
            color: appColors.black,
          ),
        ),
      ],
    );
  }
}

class NoProducts extends StatelessWidget {
  const NoProducts({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(),
        SvgPicture.asset(
          AppAssets.nodatanew,
          width: 100.w,
          height: 100.h,
        ),
        verticalSpace(20.h),
        Text(
          'لا يوجد $text حاليا',
          style: TextStyles.cairo_12_medium.copyWith(
            color: appColors.black,
          ),
        ),
      ],
    );
  }
}
