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
import '../logic/advisory_cubit.dart';

class AdvisoryType extends StatelessWidget {
  const AdvisoryType({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<AdvisoryCubit>(),
      child: BlocBuilder<AdvisoryCubit, AdvisoryState>(
        builder: (context, state) {
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
          if (getit<AdvisoryCubit>().advisoriesCategoriesTypes != null) {
            var data =
                getit<AdvisoryCubit>().advisoriesCategoriesTypes!.data!.items;
            return Animate(
              effects: [FadeEffect(duration: 500.ms)],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "وسيلة الاستشارة",
                    style: TextStyles.cairo_14_bold,
                  ),
                  verticalSpace(5.h),
                  Text(
                    "اختر وسيلة الاستشارة المناسبة لك",
                    style: TextStyles.cairo_12_semiBold
                        .copyWith(color: appColors.grey15),
                  ),
                  verticalSpace(10.h),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data!.length,
                    itemBuilder: (context, index) => ToolSelectionType(
                      isVideo: data[index].requiresAppointment == 1,
                      onSelected: () {
                        getit<AdvisoryCubit>().selectedAdvisoryType =
                            data[index].id!;
                        getit<AdvisoryCubit>().isNeedAppointment =
                            data[index].requiresAppointment == 1;
                        context.read<AdvisoryCubit>().nextStep();
                      },
                      name: data[index].name!,
                      description: data[index].description!,
                    ),
                  )
                ],
              ),
            );
          }
          if (state is AdvisoryTypesError) {
            return Center(
              child: Text('Failed to load advisory types'),
            );
          }
          // Default to showing a loading indicator if no state matches
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
