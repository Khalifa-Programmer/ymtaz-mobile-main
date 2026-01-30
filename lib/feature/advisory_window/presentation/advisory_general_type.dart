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
import '../logic/advisory_cubit.dart';

class AdvisoryGeneralType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdvisoryCubit, AdvisoryState>(
      builder: (context, state) {
        if (state is AdvisoryGeneralTypesLoading) {
          return AdvisoryGeneralTypeShimmer();
        } else if (context
                .read<AdvisoryCubit>()
                .advisoriesGeneralSpecialization !=
            null) {
          var state = context
              .read<AdvisoryCubit>()
              .advisoriesGeneralSpecialization!
              .data;
          if (state!.isEmpty) {
            return Animate(
              effects: [FadeEffect(duration: 500.ms)],
              child: Center(
                child: NodataFound(),
              ),
            );
          }
          return Animate(
            effects: [FadeEffect(duration: 500.ms)],
            child: SingleChildScrollView(
              key: ValueKey<int>(state.length),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    itemCount: state.length,
                    itemBuilder: (context, index) {
                      final specialization = state[index];
                      return ItemCardWidget(
                        description: specialization.description,
                        onPressed: () {
                          context.read<AdvisoryCubit>().selectedGeneralType =
                              specialization.id!;
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
