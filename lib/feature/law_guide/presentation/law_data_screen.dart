import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/law_guide/data/model/law_response.dart';
import 'package:yamtaz/feature/law_guide/presentation/widgets/laws_data_body.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/di/dependency_injection.dart';
import '../logic/law_guide_cubit.dart';

class LawDataScreen extends StatelessWidget {
  LawDataScreen(
      {super.key,
      required this.data,
      required this.index,
      required this.title});

  final List<Datum> data;
  int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<LawGuideCubit>(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(title,
              style: TextStyles.cairo_14_bold.copyWith(
                color: appColors.black,
              )),
        ),
        body: BlocConsumer<LawGuideCubit, LawGuideState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var user = CacheHelper.getData(key: 'userType');
            return ConditionalBuilder(
                condition: getit<LawGuideCubit>().lawResponse == null,
                builder: (context) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                },
                fallback: (context) {
                  return Animate(
                      effects: [FadeEffect(delay: 200.ms)],
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            verticalSpace(20.h),
                            SvgPicture.asset(
                              AppAssets.logo,
                              color: appColors.primaryColorYellow,
                              width: 40.w,
                              height: 40.w,
                            ),
                            verticalSpace(10.h),
                            Animate(effects: [
                              FadeEffect(delay: 200.ms),
                            ], child: LawsDataBody(data: data, index: index)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: index == 0
                                        ? null
                                        : () {
                                            if (index > 0) {
                                              index--;
                                              context
                                                  .read<LawGuideCubit>()
                                                  .nextLaw();
                                            }
                                          },
                                    child: Icon(
                                      CupertinoIcons.arrow_right_circle,
                                      color: appColors.primaryColorYellow,
                                      size: 40.r,
                                    )),
                                horizontalSpace(20.w),
                                CupertinoButton(
                                    disabledColor: appColors.grey15,
                                    padding: EdgeInsets.zero,
                                    onPressed: index == data.length - 1
                                        ? null
                                        : () {
                                            if (index < data.length) {
                                              index++;
                                              context
                                                  .read<LawGuideCubit>()
                                                  .nextLaw();
                                            }
                                          },
                                    child: Icon(
                                      CupertinoIcons.arrow_left_circle,
                                      color: appColors.primaryColorYellow,
                                      size: 40.r,
                                    )),
                              ],
                            ),
                            verticalSpace(10.h),
                            CustomButton(
                              title: "مواد ذات صلة",
                              bgColor: appColors.primaryColorYellow,
                              onPress: () {},
                              width: 150.w,
                              height: 40.h,
                              fontSize: 15,
                            ),
                            verticalSpace(30.h),

                          ],
                        ),
                      ));
                });
          },
        ),
      ),
    );
  }
}

class LawsDataScreen extends StatelessWidget {
  const LawsDataScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<LawGuideCubit>(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(title,
              style: TextStyles.cairo_14_bold.copyWith(
                color: appColors.black,
              )),
        ),
        body: BlocConsumer<LawGuideCubit, LawGuideState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return ConditionalBuilder(
                condition: getit<LawGuideCubit>().lawResponse == null,
                builder: (context) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                },
                fallback: (context) {
                  return Animate(
                      effects: [FadeEffect(delay: 200.ms)],
                      child: AllLawsDataBody());
                });
          },
        ),
      ),
    );
  }
}
