import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/spacing.dart';

import '../../../../config/themes/styles.dart';

class ToolSelectionType extends StatelessWidget {
  const ToolSelectionType(
      {super.key,
      this.isVideo = false,
      this.svgAsset,
      required this.name,
      required this.description,
      required this.onSelected});

  final bool isVideo;
  final String? svgAsset;
  final String name;
  final String description;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        padding: EdgeInsets.all(17.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: appColors.primaryColorYellow),
          boxShadow: [
            BoxShadow(
              color: appColors.primaryColorYellow.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  svgAsset ?? (isVideo ? AppAssets.video : AppAssets.advisories),
                  width: 32.sp,
                  height: 32.sp,
                  colorFilter: ColorFilter.mode(appColors.primaryColorYellow, BlendMode.srcIn),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: appColors.blue100,
                        ),
                      ),
                      verticalSpace(8.h),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: appColors.grey15,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
