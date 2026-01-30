import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/intro/on_board/presentation/view/widgets/dots_indicator.dart';
import 'package:yamtaz/feature/intro/on_board/presentation/view/widgets/onboard_body.dart';
import 'package:yamtaz/feature/intro/on_board/presentation/view_model/onboarding_cubit.dart';
import 'package:yamtaz/l10n/locale_keys.g.dart';

import '../../../../../core/widgets/custom_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit()..initScreen(),
      child: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          OnboardingCubit myCubit = OnboardingCubit.get(context);
          Locale currentLocale = EasyLocalization.of(context)!.locale;
          String languageCode = currentLocale.languageCode;

          return Scaffold(
            backgroundColor: appColors.white,
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset(0.5, -0.1429),
                      end: FractionalOffset(0.5, 0.349),
                      stops: [0.0, 1.0],
                      colors: [
                        Color(0xFFFFEDCA),
                        Color(0x00DBB762),
                        // Using 0x00 to represent rgba(221, 183, 98, 0)
                      ],
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            verticalSpace(30.h),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 20.0),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        context.pushNamed(Routes.login),
                                    child: Text(
                                      myCubit.currentIndex != 2
                                          ? LocaleKeys.skip.tr()
                                          : "",
                                      style:
                                          TextStyles.cairo_14_medium.copyWith(
                                        color: appColors.black,
                                        decorationColor: appColors.grey10,
                                      ),
                                    ),
                                  ),

                                  // todo redo change language after apple review
                                  // const Spacer(),
                                  // GestureDetector(
                                  //   onTap: () =>
                                  //       myCubit.changeLanguage(context),
                                  //   child: Animate(
                                  //     effects: [FadeEffect(delay: 100.ms)],
                                  //     child:
                                  //         Text( languageCode == 'ar' ? 'EN' : 'AR',
                                  //           style: TextStyles.cairo_14_medium
                                  //
                                  //             ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 550.h,
                              child: PageView.builder(
                                physics: const BouncingScrollPhysics(),
                                controller: myCubit.pageController,
                                itemCount: myCubit.onboardingData.length,
                                onPageChanged: (index) =>
                                    myCubit.pageChanged(index),
                                itemBuilder: (context, index) =>
                                    OnBoardBody(myCubit.onboardingData[index]),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...List.generate(
                                myCubit.onboardingData.length,
                                (index) => Padding(
                                  padding: EdgeInsets.all(3.0.w),
                                  child: DotsIndicator(
                                    isActive: index == myCubit.currentIndex,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(60.h),
                        CustomButton(
                          title: myCubit.currentIndex != 2
                              ? LocaleKeys.next.tr()
                              : LocaleKeys.startNow.tr(),
                          titleColor: myCubit.currentIndex != 2
                              ? appColors.primaryColorYellow
                              : appColors.white,
                          borderColor: myCubit.currentIndex != 2
                              ? appColors.primaryColorYellow
                              : appColors.primaryColorYellow,
                          bgColor: myCubit.currentIndex != 2
                              ? appColors.white
                              : appColors.primaryColorYellow,
                          onPress: () => myCubit.currentIndex != 2
                              ? myCubit.nextPage()
                              : context.pushNamed(Routes.login),
                        ),
                        verticalSpace(12.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
