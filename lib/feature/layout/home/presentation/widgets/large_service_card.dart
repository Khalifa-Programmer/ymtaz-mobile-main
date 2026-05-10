import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/feature/layout/home/data/models/home_model.dart';
import '../../../../../core/widgets/spacing.dart';

class LargeServiceCard extends StatelessWidget {
  final HomeModel item;
  final int index;

  const LargeServiceCard({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    // Alternating colors for a premium look
    final Color primaryColor = index % 2 == 0 ? appColors.blue100 : appColors.primaryColorYellow;
    final Color secondaryColor = index % 2 == 0 ? appColors.primaryColorYellow : appColors.blue100;

    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: Colors.grey[100]!, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: InkWell(
          onTap: () {
            if (item.route != null) {
              context.pushNamed(item.route!);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: appColors.blue100,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          if (item.description.isNotEmpty) ...[
                            verticalSpace(8.h),
                            Text(
                              item.description,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[600],
                                fontFamily: 'Cairo',
                                height: 1.5,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    horizontalSpace(12.w),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: SizedBox(
                        width: 35.w,
                        height: 35.w,
                        child: item.icon,
                      ),
                    ),
                  ],
                ),
                if (item.subSpecializations != null && item.subSpecializations!.isNotEmpty) ...[
                  verticalSpace(20.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: item.subSpecializations!.map((sub) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: index == 0 ? const Color(0xFFF0F7FF) : 
                               index == 1 ? const Color(0xFFFDF7EF) : 
                               const Color(0xFFF2FAF5),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Text(
                        sub,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: index == 0 ? const Color(0xFF0066FF) : 
                                 index == 1 ? const Color(0xFFB48A00) : 
                                 const Color(0xFF00A344),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    )).toList(),
                  ),
                ],
                verticalSpace(16.h),
                /*Row(
                  children: [
                    Icon(Icons.arrow_forward_ios, size: 12.sp, color: primaryColor),
                    horizontalSpace(4.w),
                    Text(
                      "عرض التفاصيل",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
