import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/feature/learning_path/data/models/learning_paths_response.dart';

class LearningPathCard extends StatelessWidget {
  final LearningPath path;
  final VoidCallback onTap;

  const LearningPathCard({
    super.key,
    required this.path,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: appColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: appColors.lightYellow10, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        path.title,
                        style: TextStyles.cairo_13_bold.copyWith(color: appColors.blue100),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 8.w),
                      Icon(Icons.menu_book_rounded, color: appColors.primaryColorYellow, size: 18.sp),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        Icons.star,
                        color: index < 4 ? appColors.primaryColorYellow : appColors.grey1,
                        size: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '299 ريال', // Mock price for now
              style: TextStyles.cairo_12_bold.copyWith(color: appColors.blue100),
            ),
          ],
        ),
      ),
    );
  }
}
