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
import '../data/model/advisories_categories_types.dart';

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
            return _buildLoadingShimmer();
          }

          if (cubit.advisoriesCategoriesTypes != null) {
            final data = cubit.advisoriesCategoriesTypes!.data!.items ?? [];
            if (data.isEmpty) return const SizedBox();

            return Animate(
              effects: [FadeEffect(duration: 500.ms)],
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(10.h),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      separatorBuilder: (context, index) => verticalSpace(10.h),
                      itemBuilder: (context, index) {
                        final item = data[index];
                        return ToolSelectionType(
                          svgAsset: _getIcon(item),
                          name: item.name ?? '',
                          description: item.description ?? '',
                          onSelected: () {
                            cubit.selectedAdvisoryItem = item;
                            cubit.selectedAdvisoryType = item.id!;
                            cubit.isNeedAppointment = item.requiresAppointment == 1;
                            cubit.isInstant = _isInstantAdvisory(item);
                            cubit.nextStep();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is AdvisoryTypesError) {
            return Center(
              child: Text(
                'فشل تحميل أنواع الاستشارات',
                style: TextStyles.cairo_14_bold.copyWith(color: appColors.red),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  bool _isInstantAdvisory(Item item) {
    if (item.requiresAppointment == 1) return false;
    final name = item.name ?? '';
    if (name.contains("مكتوب")) return false;
    if (name.contains("فور") || name.contains("مباشر") || name.contains("سريع") || name.contains("عاجل")) return true;
    return true; // If it doesn't require an appointment and isn't written, it's considered an instant video/call
  }

  String _getIcon(Item item) {
    final name = item.name ?? '';
    if (name.contains("مكتوب")) return AppAssets.advisoryOrder;
    if (_isInstantAdvisory(item)) return AppAssets.flash;
    if (name.contains("مجدول")) return AppAssets.appointmentOrder;
    if (item.requiresAppointment == 1) return AppAssets.video;
    return AppAssets.advisories;
  }

  Widget _buildLoadingShimmer() {
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
                color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
          ),
          verticalSpace(5.h),
          Container(
            width: 300.w,
            height: 20.h,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
          ),
          verticalSpace(20.h),
          ...List.generate(
              3,
              (index) => Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 140.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r)),
                      ),
                      verticalSpace(10.h),
                    ],
                  )),
        ],
      ),
    );
  }
}
