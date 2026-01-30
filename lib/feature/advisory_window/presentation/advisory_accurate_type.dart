import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/feature/advisory_window/presentation/widgets/item_card_widget.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/no_data_services.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/widgets/spacing.dart';
import '../../layout/account/presentation/guest_screen.dart';
import '../logic/advisory_cubit.dart';
import 'advisory_general_type_shimmer.dart';

class AdvisoryAccurateType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdvisoryCubit, AdvisoryState>(
      builder: (context, state) {
        if (state is AdvisoryAccurateTypesLoading) {
          return AdvisoryGeneralTypeShimmer();
        } else if (context
                .read<AdvisoryCubit>()
                .advisoriesAccurateSpecialization !=
            null) {
          var state = context
              .read<AdvisoryCubit>()
              .advisoriesAccurateSpecialization!
              .data;
          if (state!.subCategories!.isEmpty) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "التخصص الدقيق",
                    style: TextStyles.cairo_14_bold,
                  ),
                  verticalSpace(5.h),
                  Text(
                    "اختر تخصص دقيق الاستشارة التي تريد الاستشارة فيها",
                    style: TextStyles.cairo_12_semiBold
                        .copyWith(color: appColors.grey15),
                  ),
                  verticalSpace(10.h),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.subCategories!.length,
                    itemBuilder: (context, index) {
                      final specialization = state.subCategories![index];
                      return ItemCardWidget(
                        description: specialization.description,
                        onPressed: () {
                          var userType = CacheHelper.getData(key: 'userType');

                          if (userType == 'guest') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GestScreen()));
                            return;
                          }
                          getit<AdvisoryCubit>().selectedAccurateData =
                              state.subCategories![index];
                          getit<AdvisoryCubit>().nextStep();
                          context
                              .read<AdvisoryCubit>()
                              .emit(AdvisoryStepChanged(1));
                        },
                        index: index,
                        id: specialization.id!,
                        name: specialization.name!,
                        total: "0",
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else if (state is AdvisoryAccurateTypesError) {
          return Center(
            child: Text('Error: ${state.error}'),
          );
        }
        return Container();
      },
    );
  }
}
