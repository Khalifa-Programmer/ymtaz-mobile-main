import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/spacing.dart';

class BreadcrumbWidget extends StatelessWidget {
  final String path;

  const BreadcrumbWidget({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: appColors.primaryColorYellow.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: appColors.primaryColorYellow.withOpacity(0.25),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.route_rounded,
            size: 14.sp,
            color: appColors.primaryColorYellow,
          ),
          horizontalSpace(6.w),
          Expanded(
            child: _buildBreadcrumb(path),
          ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumb(String path) {
    final parts = path.split(' > ');
    return Wrap(
      spacing: 2.w,
      runSpacing: 2.h,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: List.generate(parts.length * 2 - 1, (i) {
        if (i.isOdd) {
          return Icon(
            Icons.arrow_back_ios,
            size: 9.sp,
            color: appColors.grey15,
          );
        }
        final partIndex = i ~/ 2;
        return Text(
          parts[partIndex],
          style: TextStyles.cairo_12_semiBold.copyWith(
            color: partIndex == parts.length - 1
                ? appColors.primaryColorYellow
                : appColors.blue100,
            fontWeight: partIndex == parts.length - 1
                ? FontWeight.bold
                : FontWeight.w600,
          ),
        );
      }),
    );
  }
}
