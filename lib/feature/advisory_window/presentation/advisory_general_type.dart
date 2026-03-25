import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/feature/advisory_window/presentation/advisory_general_type_shimmer.dart';
import 'package:yamtaz/feature/advisory_window/presentation/widgets/item_card_widget.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/no_data_services.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/spacing.dart';
import '../../../core/widgets/breadcrumb_widget.dart';
import '../logic/advisory_cubit.dart';

class AdvisoryGeneralType extends StatelessWidget {
  const AdvisoryGeneralType({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdvisoryCubit, AdvisoryState>(
      builder: (context, state) {
        if (state is AdvisoryGeneralTypesLoading ||
            (state is AdvisoryStepChanged && state.step == 1)) {
          return const AdvisoryGeneralTypeShimmer();
        } else if (context.read<AdvisoryCubit>().advisoriesGeneralSpecialization !=
            null) {
          var data =
              context.read<AdvisoryCubit>().advisoriesGeneralSpecialization!.data;
          
          if (data == null || data.isEmpty) {
            return Animate(
              effects: [FadeEffect(duration: 500.ms)],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NodataFound(),
                    verticalSpace(10.h),
                    Text("لا توجد تخصصات متاحة حالياً لهذا النوع", style: TextStyles.cairo_12_semiBold),
                  ],
                ),
              ),
            );
          }
          final cubit = context.read<AdvisoryCubit>();
          final breadcrumbPath = cubit.selectedAdvisoryItem?.name ?? '';
          return Animate(
            effects: [FadeEffect(duration: 500.ms)],
            child: SingleChildScrollView(
              key: ValueKey<int>(data.length),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BreadcrumbWidget(path: breadcrumbPath),
                  verticalSpace(15.h),
                  Text(
                    "التخصص العام",
                    style: TextStyles.cairo_14_bold,
                  ),
                  verticalSpace(5.h),
                  Text(
                    "اختر تخصص الاستشارة التي تريد الاستشارة فيها",
                    style: TextStyles.cairo_12_semiBold
                        .copyWith(color: appColors.grey15),
                  ),
                  verticalSpace(10.h),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final specialization = data[index];
                      return ItemCardWidget(
                        description: specialization.description,
                        onPressed: () {
                          context.read<AdvisoryCubit>().selectedGeneralType =
                              specialization.id!;
                          context.read<AdvisoryCubit>().selectedGeneralData =
                              specialization;
                          context.read<AdvisoryCubit>().nextStep();
                        },
                        index: index,
                        name: specialization.name!,
                        id: specialization.id!,
                        total: "0",
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else if (state is AdvisoryGeneralTypesError) {
          return Center(
            child: Text('Error: ${state.error}'),
          );
        }
        return Container();
      },
    );
  }
}
