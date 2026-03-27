import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/feature/advisory_window/presentation/widgets/lawyer_card_view.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/widgets/spacing.dart';
import '../../layout/services/presentation/widgets/card_loading.dart';
import '../data/model/available_lawyers_for_advisory_type_model.dart';
import '../logic/advisory_cubit.dart';

class SelectLawyerScreen extends StatelessWidget {
  const SelectLawyerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdvisoryCubit, AdvisoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          final advisoryCubit = getit<AdvisoryCubit>();
          final selectedLevel = advisoryCubit.selectedLevel;
          if (selectedLevel == null) {
            return Center(child: Text("No level selected"));
          }
          return ConditionalBuilder(
              condition: state is AdvisoryTypeLawyersLoading,
              builder: (context) => LawyerCardLoading(),
              fallback: (context) {
                final cubit = context.read<AdvisoryCubit>();
                if (state is AdvisoryTypeLawyersLoaded) {
                  final data = state.data;
                  final validData = (data.data ?? []).where((item) => item.lawyer != null).toList();

                  if (validData.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.people_alt_outlined, size: 64.sp, color: appColors.grey15),
                          verticalSpace(16.h),
                          Text(
                            "لا يوجد محامين متاحين حالياً",
                            style: TextStyles.cairo_16_bold.copyWith(color: appColors.blue100),
                          ),
                          verticalSpace(8.h),
                          Text(
                            "يرجى المحاولة مرة أخرى لاحقاً",
                            style: TextStyles.cairo_12_semiBold.copyWith(color: appColors.grey15),
                          ),
                        ],
                      ),
                    );
                  }

                  return Animate(
                    effects: [
                      FadeEffect(duration: 200.ms),
                    ],
                    child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(children: [
                          Row(
                            children: [
                              Text("المحامين المتاحين ",
                                  style: TextStyles.cairo_14_bold.copyWith(
                                    color: appColors.blue100,
                                  )),
                              Text("(${validData.length}) ",
                                  style: TextStyles.cairo_12_bold.copyWith(
                                    color: appColors.grey15,
                                  )),
                            ],
                          ),
                          verticalSpace(16.sp),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final item = validData[index];
                                return LawyerCardAdvisory(
                                  lawyer: item.lawyer!,
                                  service: item.subCategory ?? SubCategory(),
                                  price: item.price ?? "0",
                                  typeId: item.subCategory?.id?.toString() ?? "",
                                  importance: item.importance ?? Importance(title: ""),
                                  description: (item.subCategory?.description ?? "").toString(),
                                  needAppointment:
                                      cubit.isNeedAppointment ? 1 : 0,
                                  onPress: () {
                                    cubit.selectedLawyer = item;
                                    cubit.nextStep();
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return verticalSpace(16.sp);
                              },
                              itemCount: validData.length),
                        ])),
                  );
                } else {
                  return Center(
                    child: Text("حدث خطأ ما"),
                  );
                }
              });
        });
  }
}
