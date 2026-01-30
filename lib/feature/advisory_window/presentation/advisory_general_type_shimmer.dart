import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/widgets/spacing.dart';

class AdvisoryGeneralTypeShimmer extends StatelessWidget {
  const AdvisoryGeneralTypeShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          shimmerWidget(),
          verticalSpace(20.h),
          shimmerWidget(),
          verticalSpace(20.h),
          shimmerWidget(),
          verticalSpace(20.h),
          shimmerWidget(),
          verticalSpace(20.h),
          shimmerWidget(),
          verticalSpace(20.h),
          shimmerWidget(),
          verticalSpace(20.h),
          shimmerWidget(),
          verticalSpace(20.h),
          shimmerWidget(),
          verticalSpace(20.h),
          shimmerWidget(),
          verticalSpace(20.h),
        ],
      ),
    );
  }
}
Widget shimmerWidget() {
  return Container(
    width: double.infinity,
    height: 50.h,
    color: Colors.white.withOpacity(0.2),
    child: Row(
      children: [
        Container(
          height: 50.h,
          width: 3.h,
          color: Colors.white,
        ),
        horizontalSpace(30.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(10.h),
            Container(
              width: 200.w,
              height: 10.h,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r)),
            ),
            verticalSpace(5.h),
            Container(
              width: 250.w,
              height: 10.h,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r)),
            ),
            verticalSpace(10.h),
          ],
        ),
      ],
    ),
  );
}
