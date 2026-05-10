import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/feature/layout/home/data/models/specialization_response.dart';

class SpecializationCard extends StatelessWidget {
  final Specialization specialization;
  final int index;

  const SpecializationCard({
    super.key,
    required this.specialization,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // Define colors based on index
    final List<Color> mainColors = [
      appColors.blue100, // Blue
      const Color(0xFF6A1B9A), // Purple
      appColors.green, // Green
      appColors.primaryColorYellow, // Yellow
    ];

    final Color mainColor = mainColors[index % mainColors.length];
    final Color bgColor = mainColor.withOpacity(0.05);

    return InkWell(
      onTap: () => _navigateToSpecialization(context, specialization),
      borderRadius: BorderRadius.circular(15.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        specialization.title ?? '',
                        style: TextStyles.cairo_16_bold.copyWith(
                          color: appColors.blue100,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        specialization.description ?? '',
                        style: TextStyles.cairo_12_regular.copyWith(
                          color: appColors.grey15,
                          height: 1.5,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: bgColor,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    _getSvgForIndex(index),
                    colorFilter: ColorFilter.mode(mainColor, BlendMode.srcIn),
                    width: 24.sp,
                    height: 24.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            if (specialization.services != null &&
                specialization.services!.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: specialization.services!.map((service) {
                    return Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: GestureDetector(
                        onTap: () => _navigateToService(context, service),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            service.title ?? '',
                            style: TextStyles.cairo_12_bold.copyWith(
                              color: mainColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 16.sp,
                color: appColors.grey.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSpecialization(
      BuildContext context, Specialization specialization) {
    // Logic to route based on title or ID
    final title = specialization.title?.toLowerCase() ?? '';
    if (title.contains('استشارات') || title.contains('consultation')) {
      context.pushNamed(Routes.advisoryScreen);
    } else if (title.contains('خدمات') || title.contains('service')) {
      context.pushNamed(Routes.services);
    } else if (title.contains('مواعيد') || title.contains('appointment')) {
      context.pushNamed(Routes.appointmentYmatz);
    } else {
      // Default fallback
      context.pushNamed(Routes.services);
    }
  }

  void _navigateToService(BuildContext context, Service service) {
    // For now, same logic as specialization or specific sub-route
    context.pushNamed(Routes.services);
  }

  String _getSvgForIndex(int index) {
    switch (index % 4) {
      case 0:
        return AppAssets.advisories;
      case 1:
        return AppAssets.services;
      case 2:
        return AppAssets.judgeJuide;
      case 3:
        return AppAssets.guide;
      default:
        return AppAssets.advisories;
    }
  }
}
