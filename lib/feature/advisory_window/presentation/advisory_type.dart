import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/advisory_window/presentation/widgets/tool_selection_type.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/assets.dart';
import '../logic/advisory_cubit.dart';

class AdvisoryType extends StatelessWidget {
  const AdvisoryType({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<AdvisoryCubit>(),
      child: BlocBuilder<AdvisoryCubit, AdvisoryState>(
        builder: (context, state) {
          final cubit = context.read<AdvisoryCubit>();
          
          if (state is AdvisoryTypesLoading) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                  verticalSpace(5.h),
                  Container(
                    width: 300.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                  verticalSpace(10.h),
                  Container(
                    width: double.infinity,
                    height: 100.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                  verticalSpace(10.h),
                  Container(
                    width: double.infinity,
                    height: 100.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                ],
              ),
            );
          }
          if (cubit.advisoriesCategoriesTypes != null) {
            final data = cubit.advisoriesCategoriesTypes!.data!.items ?? [];
            if (data.isEmpty) return const SizedBox();

            final writtenItem = data.firstWhere(
              (element) => element.requiresAppointment == 0,
              orElse: () => data.first,
            );

            final allVisualItems = data.where((element) => element.requiresAppointment == 1).toList();
            final baseVisualItem = allVisualItems.isNotEmpty ? allVisualItems.first : data.first;

            final instantVisualItem = allVisualItems.firstWhere(
              (element) => (element.name?.contains("فورية") ?? false),
              orElse: () => baseVisualItem,
            );

            final scheduledVisualItem = allVisualItems.firstWhere(
              (element) => (element.name?.contains("مجدولة") ?? false) || (allVisualItems.length > 1 && element != instantVisualItem),
              orElse: () => allVisualItems.length > 1 ? allVisualItems[1] : baseVisualItem,
            );

            return Animate(
              effects: [FadeEffect(duration: 500.ms)],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (cubit.showVisualOptions)
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios, size: 18.sp),
                          onPressed: () {
                            cubit.toggleVisualOptions(false);
                          },
                        ),
                      Text(
                        cubit.showVisualOptions ? "نوع الاستشارة المرئية" : "وسيلة الاستشارة",
                        style: TextStyles.cairo_14_bold,
                      ),
                    ],
                  ),
                  verticalSpace(5.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: cubit.showVisualOptions ? 40.w : 0),
                    child: Text(
                      cubit.showVisualOptions
                          ? "اختر نوع الاستشارة المرئية المناسبة لك"
                          : "اختر وسيلة الاستشارة المناسبة لك للحصول على أفضل خدمة",
                      style: TextStyles.cairo_12_semiBold
                          .copyWith(color: appColors.grey15),
                    ),
                  ),
                  verticalSpace(10.h),
                  if (!cubit.showVisualOptions) ...[
                    // Level 1: Written vs Visual
                    ToolSelectionType(
                      svgAsset: AppAssets.advisoryOrder,
                      name: "استشارة مكتوبة",
                      description: "احصل على رد مكتوب لشرح قضيتك ومرفقاتك بدقة من قبل المحامي",
                      onSelected: () {
                        cubit.selectedAdvisoryType = writtenItem.id!;
                        cubit.isNeedAppointment = false;
                        cubit.isInstant = false;
                        cubit.nextStep();
                      },
                    ),
                    verticalSpace(10.h),
                    ToolSelectionType(
                      isVideo: true,
                      name: "استشارة مرئية",
                      description: "تواصل مع المحامي عبر مكالمة فيديو مباشرة لمناقشة التفاصيل",
                      onSelected: () {
                        cubit.toggleVisualOptions(true);
                      },
                    ),
                  ] else ...[
                    // Level 2: Visual Options
                    ToolSelectionType(
                      svgAsset: AppAssets.flash,
                      name: "استشارة مرئية فورية",
                      description: "تواصل مع المحامي مباشرة الآن دون الحاجة لحجز موعد مسبق",
                      onSelected: () {
                        cubit.selectedAdvisoryType = instantVisualItem.id!;
                        cubit.isNeedAppointment = false;
                        cubit.isInstant = true;
                        cubit.nextStep();
                      },
                    ),
                    verticalSpace(10.h),
                    ToolSelectionType(
                      svgAsset: AppAssets.appointmentOrder,
                      name: "موعد مرئية (مجدولة)",
                      description: "احجز موعداً لاستشارة مرئية في وقت لاحق يناسبك",
                      onSelected: () {
                        cubit.selectedAdvisoryType = scheduledVisualItem.id!;
                        cubit.isNeedAppointment = true;
                        cubit.isInstant = false;
                        cubit.nextStep();
                      },
                    ),
                  ],
                ],
              ),
            );
          }
          if (state is AdvisoryTypesError) {
            return Center(
              child: Text('Failed to load advisory types'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
